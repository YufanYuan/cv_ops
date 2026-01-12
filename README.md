# CVOps Generator

[English](./README.md) | [中文](./README_CN.md)

**CVOps** is an engineering wrapper around [renderCV](https://github.com/rendercv/rendercv) and [CUE](https://cuelang.org/), designed to provide a structured and programmable way to generate high-quality resumes.

## Why this Wrapper?

While `renderCV` is powerful, maintaining complex or multiple resumes in raw YAML can be repetitive and error-prone. This project offers a **battle-tested engineering template** that serves as a proven starting point for your resume:

1.  **Logic > Config (CUE vs YAML)**: Use variables, loops, and schemas to enforce consistency. Define your education or contact info once and reuse it across multiple resume versions (e.g., English/Chinese, specialized roles) without copy-pasting.
2.  **Engineering > Script**: Instead of manually managing Python versions and LaTeX dependencies, this repo provides a fully configured **Dev Container**. It just works.
3.  **Systematic Design**: Strict separation of Content (`src/content`), Design (`src/design`), and Locale (`src/locale`) means you can change your layout or language without rewriting your life story.

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

---

## Vision & Roadmap: The "Agentic" Resume

> **Goal:** High-quality mass application with minimized effort.

We are evolving this project from a static generator into an **Agentic Career Assistant**. The core philosophy is to decouple your "Experience Data" from the "Resume View".

### The Concept
1.  **Atomic Assets**: You don't write a resume; you build a database of **Atomic Experiences**. Each experience is a structured data block (Context, Problem, Method, Result) stored in your `Experience Bank`.
2.  **Dynamic Optimization**: When you apply for a job, you feed the **Job Description (JD)** and your **Experience Bank** into the Agent.
3.  **Tailored Output**: The Agent selects the most relevant atomic experiences, rewrites them to match the keywords and tone of the JD, and assembles a perfectly tailored resume in an instant.

### Why?
- **For Generalists**: Highlight your technical depth for engineering roles and your leadership scope for management roles—using the same source of truth.
- **For Freelancers**: Generate specific proposals/profiles for every different client requirement.
- **For Everyone**: Break the trade-off between quantity (mass applying) and quality (tailored content).
