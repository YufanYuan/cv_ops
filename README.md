# General Resume Generator

[English](./README.md) | [中文](./README_CN.md)

This project is an engineering wrapper around [renderCV](https://github.com/sinaatalay/rendercv) and [CUE](https://cuelang.org/), designed to provide a structured and programmable way to generate high-quality resumes.

## Setup

> [!IMPORTANT]
> **Dev Container Support Only**
>
> We **strongly suggest** (and essentially only support) using this project within a **Dev Container**.
> The provided Dev Container comes pre-configured with all necessary tools (`uv`, `cue`, `just`, etc.) to get you started immediately without environment hell.

1. Open this repository in VS Code.
2. When prompted, reopen the folder in the Dev Container.
3. Wait for the container to build and initialization scripts to run.

## Usage

### Building a Resume

Use the `just` command runner to build your resume.

```bash
just build {template name}
```

**Note:** The `{template name}` is **NOT** the filename. It corresponds to the **root-level object name** defined in your CUE files within `src/content/`.

For example, if you have a definition like `example_cn: ...` in `src/content/example_cn.cue`, you would run:

```bash
just build example_cn
```

### Creating New Resumes

- **Location:** All resume content must be written in `src/content/`.
- **Best Practice:** It is highly recommended to separate different resume contents into different `.cue` files (e.g., `resume_en.cue`, `resume_cn.cue`) for better organization.
- **Root Object**: Ensure each specific resume has a unique top-level key (which becomes your template name).

### Example

1. Create `src/content/my_resume.cue`:
   ```cue
   package content
   
   my_awesome_resume: {
       // ... your resume content ...
   }
   ```
2. Build it:
   ```bash
   just build my_awesome_resume
   ```
