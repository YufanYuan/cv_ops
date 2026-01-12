# 通用简历生成器 (General Resume Generator)

[English](./README.md) | [中文](./README_CN.md)

本项目是 [renderCV](https://github.com/rendercv/rendercv) 和 [CUE](https://cuelang.org/) 的工程化封装，旨在提供一种结构化、可编程的方式来生成高质量的简历。

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
