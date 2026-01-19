---
name: resume-generate
description: Generate a tailored CUE resume from a JD file and the master data in cue-src/details.
---

# Resume Generator (CUE)

## When to use
Use this skill when a user provides a job description (JD) file and wants a tailored resume CUE file generated under `cue-src/content/generated/`.

## Inputs
- `target`: target profile name (e.g. `google`).
- `jd_path`: path to the JD file (txt/pdf/docx/image). If the file is binary or not readable as text, ask the user to provide a text version.
- `locale` (optional): `zh` or `en`. If unspecified, infer from the JD language.

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
4. Use the template matching the inferred locale to structure the output.
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

## Output
- Return the file path you wrote and a short summary of the tailored changes (no full CUE dump in chat).

## Example prompt
"Use $resume-generate to build a resume for target=google from jd_path=./jd/google.txt in English."
