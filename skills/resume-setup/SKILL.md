---
name: resume-setup
description: Install CUE/just/uv via configure.sh and prepare the environment for resume generation.
---

# Resume Environment Setup

## When to use
Use this skill before running resume generation/audit when the environment is missing dependencies.

## Instructions
1. Run the repository setup script:
   ```bash
   ./configure.sh
   ```
2. Add the local tool directory to PATH for the current shell:
   ```bash
   export PATH="$PWD/.bin:$PATH"
   ```
3. Install Python dependencies using uv:
   ```bash
   uv sync
   ```
   If PATH is not set, call the binary directly:
   ```bash
   ./.bin/uv sync
   ```
4. Confirm tools are available:
   ```bash
   cue version
   just --version
   uv --version
   ```

## Output
- Report success once the tools and dependencies are ready.
- If setup fails or tools are not found, prompt the user to add `./.bin` to their `PATH` and re-run the checks.

## Example prompt
"Run $resume-setup to prepare the environment before generating a resume."
