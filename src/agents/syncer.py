import fire
import os
import sys
from pathlib import Path
from common import call_llm


def get_master_data(data_dir: Path) -> str:
    """Reads all .cue files from the data directory."""
    master_data = ""
    if not data_dir.exists():
        return ""
    for file in data_dir.glob("*.cue"):
        try:
            content = file.read_text(encoding="utf-8")
            master_data += f"\n// File: {file.name}\n{content}\n"
        except Exception as e:
            print(f"Warning: Could not read {file}: {e}")
    return master_data


def syncer(target: str):
    """
    Identifies new information in a generated resume and suggests updates to Master Data.

    Args:
        target: The target name (e.g., 'google').
    """
    workspace_root = Path(os.getcwd())
    generated_file = (
        workspace_root / "cue-src" / "content" / "generated" / f"{target}.cue"
    )
    data_dir = workspace_root / "cue-src" / "details"

    if not generated_file.exists():
        print(f"Error: Target file {generated_file} does not exist.")
        return

    resume_content = generated_file.read_text(encoding="utf-8")
    master_data = get_master_data(data_dir)

    system_prompt = (
        "You are a Synopsis Agent. Your goal is to keep the Master Data up to date.\n"
        "Rules:\n"
        "1. Compare the Resume content against the Master Data.\n"
        "2. Identify NEW information (metrics, tools, project details) present in the Resume but MISSING from Master Data.\n"
        "3. Ignore wording changes or formatting differences.\n"
        "4. If new info is found, output a valid CUE snippet that could be appended to the Master Data (e.g. adding a new list item or project).\n"
        "5. If no new info is found, output 'NO_CHANGES'.\n"
    )

    user_prompt = (
        f"Resume Content ({target}):\n{resume_content}\n\n"
        f"Master Data:\n{master_data}\n\n"
        "Identify new info and propose updates."
    )

    print(f"Syncing {target}...")
    proposal = call_llm(system_prompt, user_prompt)

    if "NO_CHANGES" in proposal:
        print("No new information detected to sync.")
        return

    print("\n--- Proposed Master Data Update ---")
    print(proposal)
    print("-----------------------------------")

    choice = (
        input(
            "Do you want to save this proposal to 'data/suggested_update.cue'? [y/N] "
        )
        .strip()
        .lower()
    )
    if choice == "y":
        output_file = data_dir / "suggested_update.cue"
        output_file.write_text(proposal, encoding="utf-8")
        print(f"Saved proposal to {output_file}. Please review and merge manually.")
    else:
        print("Skipped saving.")


if __name__ == "__main__":
    fire.Fire(syncer)
