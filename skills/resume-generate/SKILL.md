---
name: resume-generate
description: Generate a tailored CUE resume from a JD file and the master data in cue-src/details.
---

# Resume Generator (CUE)

## When to use
Use this skill when a user provides a job description (JD) file and wants a tailored resume CUE file generated under `cue-src/content/generated/`.

## Inputs
- `jd_path`: path to the JD file (txt/pdf/docx/image). If the file is binary or not readable as text, ask the user to provide a text version.
- `target` (optional): target profile name. If omitted, infer a short role name from the JD and append `YYMMDDHHMM` timestamp (minute-level) for the output filename.
- `locale` (optional): `zh` or `en`. If unspecified, infer from the JD language and use the matching style example.

## References
- Master data (source of truth): `cue-src/details/*.cue`
- Style examples:
  - `assets/template_zh.cue`
  - `assets/template_en.cue`
- Output location: `cue-src/content/generated/{target}.cue`

## Instructions
1. Read the JD content from `jd_path`. If it is not text-readable, request a text extraction from the user.
2. Read all master data files under `cue-src/details/` and treat them as the only factual source.
3. Select only experiences/skills most relevant to the JD; omit unrelated items.
4. Use the template matching the inferred locale (`template_zh.cue` for `zh`, `template_en.cue` for `en`) to structure the output.
5. Write a valid CUE file to `cue-src/content/generated/{target}.cue` with:
   - `package content` at the top.
   - Required imports:
     ```cue
     import (
       D "yufan.resume/design"
       L "yufan.resume/locale"
     )
     ```
   - A single top-level object named `{target}: #DocBase & { ... }`.
6. Ensure the output contains no fabricated metrics or claims not present in master data.
7. Run `just compile {target}` to validate the generated output before reporting success.

## Output
- Return the file path you wrote and a short summary of the tailored changes (no full CUE dump in chat).

## Example prompt
"Use $resume-generate to build a resume from jd_path=./jd/google.txt in English."
