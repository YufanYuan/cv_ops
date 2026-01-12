# 通用简历生成器 (General Resume Generator)

[English](./README.md) | [中文](./README_CN.md)

本项目是 [renderCV](https://github.com/rendercv/rendercv) 和 [CUE](https://cuelang.org/) 的工程化封装，旨在提供一种结构化、可编程的方式来生成高质量的简历。

## 核心优势 (Why this Wrapper?)

原生的 `renderCV` 虽然强大，但在维护复杂或多版本简历时，单纯使用 YAML 往往会导致大量重复和易错的配置。本项目提供了一个**经过验证的工程化模板 (Proven Template)**，是你构建简历的最佳起点：

1.  **逻辑驱动 (Logic > Config)**: 使用 CUE 替代 YAML。通过变量、循环和 Schema 校验，你可以定义一次个人信息（如教育背景），然后在中文/英文或不同岗位的简历中无限复用，彻底告别复制粘贴。
2.  **工程化环境**: 无需手动配置 Python 版本或安装庞大的 LaTeX 依赖。本项目提供开箱即用的 **Dev Container**，环境配置一步到位。
3.  **模块化设计**: 严格区分内容 (`src/content`)、设计 (`src/design`) 和语言 (`src/locale`)。修改排版或切换语言不再需要重写整个文件。

## Setup (安装与配置)

> [!IMPORTANT]
> **仅支持 Dev Container**
>
> 我们**强烈建议**（并且实际上只支持）在 **Dev Container** 中使用本项目。
> 提供的 Dev Container 预配置了所有必要的工具（`uv`、`cue`、`just` 等），让您可以立即开始工作，避免环境配置的繁琐问题。

1. 在 VS Code 中打开此仓库。
2. 出现提示时，选择在 Dev Container 中重新打开文件夹。
3. 等待容器构建和初始化脚本运行完成。

## Usage (使用方法)

### 构建简历

使用 `just` 命令运行器来构建您的简历。

```bash
just build {template name}
```

**注意：** `{template name}`（模板名称）**不是**文件名。它对应于您在 `src/content/` 下的 CUE 文件中定义的**根级对象名称**。

例如，如果您在 `src/content/example_cn.cue` 中有如下定义 `example_cn: ...`，则运行：

```bash
just build example_cn
```

### 创建新简历

- **位置：** 所有简历内容必须写在 `src/content/` 目录下。
- **最佳实践：** 强烈建议将不同的简历内容分散到不同的 `.cue` 文件中（例如 `resume_en.cue`、`resume_cn.cue`），以便于管理。
- **根对象：** 确保每个特定简历都有由一个唯一的顶级键（这将成为您的模板名称）。

### 示例

1. 创建 `src/content/my_resume.cue`：
   ```cue
   package content
   
   my_awesome_resume: {
       // ... 您的简历内容 ...
   }
   ```
2. 构建它：
   ```bash
   just build my_awesome_resume
   ```

---

## 未来愿景与规划：Agentic Resume

> **核心目标：** 以最小的精力成本，实现高质量的批量投递 (High-quality mass application)。

我们将把本项目从一个静态生成器逐步演进为 **Agentic Career Assistant (智能职业助手)**。其核心哲学是将您的“经历数据”与“简历视图”彻底解耦。

### 核心概念
1.  **原子化资产 (Atomic Assets)**: 您不再需要反复“写”简历，而是维护一个 **原子化经历数据库**。每一段经历都会被拆解为结构化的数据块（背景、挑战、方法、结果），存入您的 `Experience Bank`。
2.  **动态优化 (Dynamic Optimization)**: 当您申请工作时，只需将 **岗位描述 (JD)** 和您的 **经历库** 喂给 Agent。
3.  **千人千面**: Agent 会自动根据 JD 的关键词和要求，从库中挑选最匹配的原子经历，并调整润色语言，瞬间生成一份完全定制化的简历。

### 为什么需要这个？
- **对于多面手 (Generalists)**: 申请技术岗时强调深度，申请管理岗时强调广度——使用同一套数据源，无需维护多份文档。
- **对于自由职业者**: 针对不同客户的需求，一键生成针对性的 Proposal 或履历。
- **对于所有人**: 彻底打破“海投（数量）”与“精修（质量）”之间的权衡矛盾。
