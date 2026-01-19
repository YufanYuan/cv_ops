import os
import asyncio
import fire
import mimetypes
import base64
from pathlib import Path
from pydantic_ai import Agent, RunContext

from dotenv import load_dotenv

# Configure logfire to suppress verbose logs if needed, or just let it be.
# logfire.configure(send_to_logfire='if-token-present')

# Import tools
try:
    import tools
except ImportError:
    from agents import tools

load_dotenv()


def get_jd_content(jd_path: Path) -> str | list:
    """
    Reads the JD content from various file formats.
    Returns a string for text-based JDs (txt) or a list of dicts for multimodal (image, pdf, docx).
    """
    mime_type, _ = mimetypes.guess_type(jd_path)

    is_multimodal = False
    if mime_type:
        if mime_type.startswith("image"):
            is_multimodal = True
        elif mime_type == "application/pdf":
            is_multimodal = True
        elif mime_type in [
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            "application/msword",
        ]:
            is_multimodal = True

    if is_multimodal:
        print(f"Detected File Input ({mime_type}): {jd_path}")
        with open(jd_path, "rb") as f:
            base64_data = base64.b64encode(f.read()).decode("utf-8")

        return [
            {
                "type": "text",
                "text": "Here is the Job Description file. Extract the key requirements and description.",
            },
            {
                "type": "image_url",
                "image_url": {"url": f"data:{mime_type};base64,{base64_data}"},
            },
        ]

    # Default to simple text read
    return jd_path.read_text(encoding="utf-8")


def get_style_reference(workspace_root: Path) -> str:
    """
    Reads a reference CUE file to guide the structure.
    Checks for 'template_zh.cue' or 'example_backend.cue' or similar.
    Since user created 'example_backend.cue', we can check for that as well if name implies.
    But sticking to the logic that worked or extending it.
    """
    # Try looking for a specific template or falls back
    candidates = [
        workspace_root / "src" / "agents" / "template_zh.cue",
        workspace_root / "cue-src" / "content" / "example_cn.cue",
        workspace_root / "example_cn.cue",
    ]
    for path in candidates:
        if path.exists():
            return path.read_text(encoding="utf-8")
    return ""


# Define the Pydantic AI Agent
# We optimize the system prompt to encourage tool usage
resume_agent = Agent(
    "openai:gpt-5.2",
    deps_type=str,
    system_prompt=(
        "You are an expert Resume Strategist and CUE Logician.\n"
        "Your goal is to construct a HIGH-IMPACT resume tailored to a provided Job Description (JD).\n\n"
        "RESOURCE ACCESS:\n"
        "- You DO NOT have the candidate's master data in your context yet.\n"
        "- You MUST use the `list_files` tool to explore the `cue-src/details` directory.\n"
        "- You MUST use the `read_file` tool to read relevant files (e.g., `cue-src/details/experience.cue`, `skills.cue`).\n"
        "- Do NOT assume you know the candidate's details until you read these files.\n\n"
        "PROCESS:\n"
        "1. ANALYZE the JD to identify key requirements.\n"
        "2. EXPLORE & READ Master Data using tools.\n"
        "3. SELECT only the most relevant experience/skills. Filter out irrelevant items.\n"
        "4. REFINE & POLISH the content to match the JD's keyword terminology.\n"
        "5. FORMAT the output strictly adhering to the provided 'Style Reference' structure.\n"
        "   - Output valid CUE syntax starting with `package content`.\n"
        "   - Matches the target name object (e.g. `google: #DocBase & ...`).\n"
        "   - No markdown code blocks in the final output string (just the CUE code).\n"
    ),
)


@resume_agent.tool
def list_files_tool(ctx: RunContext[str], directory: str) -> str:
    """
    List files in a directory relative to the repository root.
    Example: `list_files_tool(ctx, 'cue-src/details')`
    """
    return tools.list_files(directory)


@resume_agent.tool
def read_file_tool(ctx: RunContext[str], filepath: str) -> str:
    """
    Read the content of a file.
    Example: `read_file_tool(ctx, 'cue-src/details/experience.cue')`
    """
    return tools.read_file(filepath)


async def main_async(name: str, jd: str):
    workspace_root = Path(os.getcwd())
    generated_dir = workspace_root / "cue-src" / "content" / "generated"

    generated_dir.mkdir(parents=True, exist_ok=True)
    target_file = generated_dir / f"{name}.cue"

    jd_path = Path(jd)
    if not jd_path.exists():
        print(f"Error: JD file not found at {jd_path}")
        return

    jd_content = get_jd_content(jd_path)
    style_ref = get_style_reference(workspace_root)

    print(f"Starting Resume Agent for target: {name}")
    print("Agent will autonomousy explore Master Data using tools...")

    # Build the user prompt
    user_msg_content = (
        f"TARGET PROFILE NAME: {name}\n\n"
        f"STYLE REFERENCE (Follow this Structure):\n{style_ref}\n\n"
        f"INSTRUCTIONS:\n"
        "Generate a tailored resume for the JD below.\n"
        "Use your tools to read the Master Data from `cue-src/details`.\n"
        "Ensure the output valid CUE."
    )

    if isinstance(jd_content, list):
        # For multimodal input, Pydantic AI Agent expects a string prompt
        # Extract the image data and create a descriptive prompt
        image_data = None
        for item in jd_content:
            if item["type"] == "image_url":
                image_data = item["image_url"]["url"]
                break
        
        # Create a combined text prompt mentioning the image
        user_content = (
            f"{user_msg_content}\n\n"
            "JOB DESCRIPTION (IMAGE):\n"
            "An image containing the job description has been provided. "
            "Please analyze the image and extract the key requirements and description.\n"
            f"Image data: {image_data}\n"
        )
    else:
        user_content = f"{user_msg_content}\n\nJOB DESCRIPTION:\n{jd_content}"

    # Verify if target file exists (read it if so? Optional, maybe for update flow)
    # The prompt implies generation. If update needed, we could instruct agent to read it too.
    if target_file.exists():
        print(
            f"Target file {target_file} exists. Agent will overwrite it with a fresh generation based on Master Data."
        )

    # Use the Pydantic AI Agent to run the prompt
    result = await resume_agent.run(user_content)

    # Cleaning output
    output_text = result
    lines = output_text.splitlines()
    if lines and lines[0].strip().startswith("```"):
        lines = lines[1:]
    if lines and lines[-1].strip().startswith("```"):
        lines = lines[:-1]

    clean_content = "\n".join(lines)

    # Ensure the file starts with the correct package declaration and imports
    if not clean_content.startswith("package content"):
        clean_content = f"package content\n\n{clean_content}"
    
    # Add necessary imports if they're not present
    if "import" not in clean_content:
        clean_content = clean_content.replace(
            "package content",
            "package content\n\nimport (\n\tD \"yufan.resume/design\"\n\tL \"yufan.resume/locale\"\n)"
        )

    target_file.write_text(clean_content, encoding="utf-8")
    print(f"Successfully generated: {target_file}")


def generator(name: str, jd: str):
    # Use asyncio to run the async function
    asyncio.run(main_async(name, jd))


if __name__ == "__main__":
    fire.Fire(generator)
