import os
import subprocess
from pathlib import Path
import json


def get_allowed_roots():
    # Helper to ensure we only access allowed directories
    workspace_root = Path(os.getcwd())
    return [
        workspace_root / "cue-src" / "details",
        workspace_root / "cue-src" / "content",
    ]


def validate_path(filepath: str) -> Path:
    # Ensure usage of absolute path, or relative to cwd.
    # Security check: ensure path is within allowed roots
    path = Path(filepath).resolve()
    allowed_roots = get_allowed_roots()

    is_allowed = False
    for root in allowed_roots:
        if path.is_relative_to(root):
            is_allowed = True
            break

    if not is_allowed:
        # For now, simplistic check. Maybe allow all if running in container.
        # But per user request "details 和 content 这两个目录下", let's be loose but mindful.
        # Check if it starts with the workspace root at least
        workspace_root = Path(os.getcwd())
        if not path.is_relative_to(workspace_root):
            raise PermissionError(f"Access denied to {path}")

    return path


def list_files(directory: str) -> str:
    """
    Lists files in the specified directory.
    Supports recursive listing if needed, but here simple glob.
    """
    try:
        path = validate_path(directory)
        if not path.exists():
            return f"Error: Directory {directory} does not exist."

        files = []
        # Support recursive walk for subdirectories
        for root, dirs, filenames in os.walk(path):
            for filename in filenames:
                full_path = Path(root) / filename
                rel_path = full_path.relative_to(path)
                files.append(str(rel_path))

        return json.dumps(files, indent=2)
    except Exception as e:
        return f"Error listing files: {e}"


def read_file(filepath: str) -> str:
    """
    Reads the content of a file.
    """
    try:
        path = validate_path(filepath)
        if not path.exists():
            return f"Error: File {filepath} does not exist."
        return path.read_text(encoding="utf-8")
    except Exception as e:
        return f"Error reading file: {e}"


def update_file(filepath: str, patch_content: str) -> str:
    """
    Updates a file using a unified patch.
    The patch should include the header like `--- file` and `+++ file`.
    However, often LLMs struggle with perfect patch headers.
    We'll assume the LLM provides a standard unified diff.
    """
    try:
        path = validate_path(filepath)
        if not path.exists():
            return f"Error: File {filepath} does not exist."

        # Write patch to temp file
        import tempfile

        with tempfile.NamedTemporaryFile(
            mode="w", suffix=".patch", delete=False
        ) as tmp:
            tmp.write(patch_content)
            tmp_path = tmp.name

        # Run patch command
        # Note: patch command behavior depends on context lines.
        # We assume the user/LLM generates valid patches.
        # -u: unified
        # -N: ignore patches that seem to be reversed or already applied? No, maybe just default.
        result = subprocess.run(
            ["patch", str(path), tmp_path], capture_output=True, text=True
        )

        os.unlink(tmp_path)

        if result.returncode != 0:
            return f"Error applying patch:\n{result.stderr}\nOutput:\n{result.stdout}"

        return "Successfully updated file."
    except Exception as e:
        return f"Error updating file: {e}"


# Tool Definitions for OpenAI
TOOLS_DEF = [
    {
        "type": "function",
        "function": {
            "name": "list_files",
            "description": "List files in a directory (e.g., cue-src/details, cue-src/content).",
            "parameters": {
                "type": "object",
                "properties": {
                    "directory": {
                        "type": "string",
                        "description": "The directory path relative to repo root.",
                    }
                },
                "required": ["directory"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "read_file",
            "description": "Read the content of a specific file.",
            "parameters": {
                "type": "object",
                "properties": {
                    "filepath": {
                        "type": "string",
                        "description": "The file path relative to repo root.",
                    }
                },
                "required": ["filepath"],
            },
        },
    },
    {
        "type": "function",
        "function": {
            "name": "update_file",
            "description": "Update a file by applying a unified diff patch.",
            "parameters": {
                "type": "object",
                "properties": {
                    "filepath": {
                        "type": "string",
                        "description": "The file path to update.",
                    },
                    "patch_content": {
                        "type": "string",
                        "description": "The unified diff content to apply.",
                    },
                },
                "required": ["filepath", "patch_content"],
            },
        },
    },
]

AVAILABLE_TOOLS = {
    "list_files": list_files,
    "read_file": read_file,
    "update_file": update_file,
}
