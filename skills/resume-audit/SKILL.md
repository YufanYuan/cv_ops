---
name: resume-audit
description: Audit a generated resume against master data and report PASS or FAIL with unsupported claims.
---

# Resume Auditor

## When to use
Use this skill after a resume has been generated in `cue-src/content/generated/{target}.cue` and you need to verify it against the master data in `cue-src/details/`.

## Inputs
- `target`: target profile name (e.g. `google`).

## References
- Generated resume: `cue-src/content/generated/{target}.cue`
- Master data (source of truth): `cue-src/details/*.cue`

## Instructions
1. Read the generated resume file.
2. Read all master data files under `cue-src/details/`.
3. Compare claims (skills, tools, metrics, projects, roles) in the resume against the master data.
4. Ignore minor wording differences if the meaning is identical.
5. Output:
   - `PASS` if all claims are supported.
   - `FAIL` and a bullet list of unsupported claims otherwise.

## Example prompt
"Run $resume-audit for target=google and report if any hallucinations exist."
