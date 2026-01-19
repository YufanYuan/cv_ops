import fire
import os
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


def guardian(target: str):
    """
    Audits a generated resume for hallucinations against the Master Data.

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
        "You are a strict Resume Auditor. Your job is to verify that a generated resume "
        "contains ONLY facts supported by the user's Master Data.\n"
        "Rules:\n"
        "1. Compare the claims in the Resume against the Master Data.\n"
        "2. Identifiy any skills, metrics, or experiences involved in the Resume that are NOT present in the Master Data.\n"
        "3. Ignore minor wording changes if the meaning is identical.\n"
        "4. Output a report. If everything is supported, strict 'PASS'. If not, output 'FAIL' and list the hallucinations.\n"
    )

    user_prompt = (
        f"Resume Content ({target}):\n{resume_content}\n\n"
        f"Master Data:\n{master_data}\n\n"
        "Audit the resume."
    )

    print(f"Auditing {target}...")
    report = call_llm(system_prompt, user_prompt)
    print("\n--- Audit Report ---")
    print(report)
    print("--------------------")


if __name__ == "__main__":
    fire.Fire(guardian)
