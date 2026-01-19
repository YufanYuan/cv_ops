---
name: resume-sync
description: Propose master data updates by comparing a generated resume to cue-src/details.
---

# Resume Sync (Master Data Updates)

## When to use
Use this skill when a generated resume contains new information that should be added to the master data in `cue-src/details/`.

## Inputs
- `target`: target profile name (e.g. `google`).

## References
- Generated resume: `cue-src/content/generated/{target}.cue`
- Master data (source of truth): `cue-src/details/*.cue`

## Instructions
1. Read the generated resume file and all master data files.
2. Identify NEW information present in the resume but missing from master data. Focus on concrete facts: metrics, tools, projects, or responsibilities.
3. Ignore purely stylistic rewrites or formatting changes.
4. If no new facts exist, output exactly `NO_CHANGES`.
5. Otherwise, output a valid CUE snippet that could be appended to `cue-src/details/suggested_update.cue`.

## Output
- `NO_CHANGES` or a CUE snippet for manual review and merge.

## Example prompt
"Use $resume-sync to propose updates for target=google."
