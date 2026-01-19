#!/bin/bash

# 定义目录
FONT_DIR="./fonts"
EXTERNAL_DIR="./.external"
BIN_DIR="./.bin"

# 检测系统和架构
detect_system() {
    OS="$(uname -s)"
    ARCH="$(uname -m)"
    
    # 转换为统一格式
    case "$OS" in
        Linux*)     OS="linux" ;;
        Darwin*)    OS="darwin" ;;
        CYGWIN*)    OS="windows" ;;
        MINGW*)     OS="windows" ;;
        *)          OS="unknown" ;;
    esac
    
    case "$ARCH" in
        x86_64*)    ARCH="amd64" ;;
        aarch64*)   ARCH="arm64" ;;
        arm64*)     ARCH="arm64" ;;
        i686*)      ARCH="386" ;;
        *)          ARCH="unknown" ;;
    esac
    
    echo "检测到系统: $OS, 架构: $ARCH"
}

# 创建目录
create_directories() {
    echo "创建必要的目录..."
    mkdir -p "$FONT_DIR" "$EXTERNAL_DIR" "$BIN_DIR"
    echo "目录创建完成！"
}

# 下载 Noto Sans SC 字体
download_fonts() {
    echo "正在下载 Noto Sans SC 字体到 $FONT_DIR ..."
    
    # 定义需要下载的字体粗细列表
    FONT_WEIGHTS=("Thin" "ExtraLight" "Light" "Regular" "Medium" "SemiBold" "Bold" "ExtraBold" "Black")
    
    # 遍历下载每种粗细的字体
    for WEIGHT in "${FONT_WEIGHTS[@]}"; do
        FONT_FILE="$FONT_DIR/NotoSansSC-${WEIGHT}.ttf"
        
        # 检查字体是否已存在
        if [ -f "$FONT_FILE" ]; then
            echo "字体 $FONT_FILE 已存在，跳过下载"
            continue
        fi
        
        # 构建下载链接
        URL="https://github.com/google/fonts/raw/main/ofl/notosanssc/NotoSansSC-${WEIGHT}.ttf"
        
        # 下载字体
        if command -v curl &> /dev/null; then
            curl -L "$URL" -o "$FONT_FILE"
        elif command -v wget &> /dev/null; then
            wget -O "$FONT_FILE" "$URL"
        else
            echo "错误：curl 或 wget 未找到，无法下载字体！"
            return 1
        fi
        
        # 检查下载是否成功
        if [ -f "$FONT_FILE" ]; then
            echo "已下载 $FONT_FILE"
        else
            echo "错误：下载 $FONT_FILE 失败！"
            return 1
        fi
    done
    
    echo "所有 Noto Sans SC 字体下载完成！"
}

# 安装 cue
install_cue() {
    echo "正在安装 cue..."
    
    # 检查 cue 是否已存在于 .external 目录
    if [[ "$OS" == "windows" ]]; then
        CUE_BINARY="$EXTERNAL_DIR/cue.exe"
        BIN_LINK="$BIN_DIR/cue.exe"
    else
        CUE_BINARY="$EXTERNAL_DIR/cue"
        BIN_LINK="$BIN_DIR/cue"
    fi
    
    # 检查是否已安装
    if [ -f "$CUE_BINARY" ]; then
        echo "cue 已安装在 $CUE_BINARY，跳过下载和安装"
        
        # 检查软链接是否存在，不存在则创建
        if [ ! -L "$BIN_LINK" ]; then
            ln -s "$CUE_BINARY" "$BIN_LINK"
            echo "已创建 cue 软链接 $BIN_LINK -> $CUE_BINARY"
        fi
        return 0
    fi
    
    # 获取最新版本号
    LATEST_VERSION=$(curl -s https://api.github.com/repos/cue-lang/cue/releases/latest | grep -o '"tag_name": "v[0-9]*\.[0-9]*\.[0-9]*"' | grep -o '[0-9]*\.[0-9]*\.[0-9]*')
    if [ -z "$LATEST_VERSION" ]; then
        echo "错误：无法获取 cue 最新版本号！"
        return 1
    fi
    echo "cue 最新版本：$LATEST_VERSION"
    
    # 根据系统和架构选择下载链接
    case "$OS" in
        "linux")
            case "$ARCH" in
                "amd64")   CUE_URL="https://github.com/cue-lang/cue/releases/download/v${LATEST_VERSION}/cue_v${LATEST_VERSION}_linux_amd64.tar.gz" ;;
                "arm64")   CUE_URL="https://github.com/cue-lang/cue/releases/download/v${LATEST_VERSION}/cue_v${LATEST_VERSION}_linux_arm64.tar.gz" ;;
                *)          echo "不支持的架构：$ARCH" ; return 1 ;;
            esac ;;
        "darwin")
            case "$ARCH" in
                "amd64")   CUE_URL="https://github.com/cue-lang/cue/releases/download/v${LATEST_VERSION}/cue_v${LATEST_VERSION}_darwin_amd64.tar.gz" ;;
                "arm64")   CUE_URL="https://github.com/cue-lang/cue/releases/download/v${LATEST_VERSION}/cue_v${LATEST_VERSION}_darwin_arm64.tar.gz" ;;
                *)          echo "不支持的架构：$ARCH" ; return 1 ;;
            esac ;;
        "windows")
            case "$ARCH" in
                "amd64")   CUE_URL="https://github.com/cue-lang/cue/releases/download/v${LATEST_VERSION}/cue_v${LATEST_VERSION}_windows_amd64.zip" ;;
                "386")     CUE_URL="https://github.com/cue-lang/cue/releases/download/v${LATEST_VERSION}/cue_v${LATEST_VERSION}_windows_386.zip" ;;
                *)          echo "不支持的架构：$ARCH" ; return 1 ;;
            esac ;;
        *)
            echo "不支持的系统：$OS" ; return 1 ;;
    esac

    echo "正在从 $CUE_URL 下载 cue..."
    
    # 设置压缩包文件名
    CUE_FILE="$EXTERNAL_DIR/cue_$(date +%s).tar.gz"
    
    # 下载并安装
    if command -v curl &> /dev/null; then
        curl -L -f "$CUE_URL" -o "$CUE_FILE"
        if [ $? -ne 0 ]; then
            echo "错误：cue 下载失败！"
            return 1
        fi
    elif command -v wget &> /dev/null; then
        wget -O "$CUE_FILE" -q "$CUE_URL"
        if [ $? -ne 0 ]; then
            echo "错误：cue 下载失败！"
            return 1
        fi
    else
        echo "错误：curl 或 wget 未找到！"
        return 1
    fi
    
    # 解压
    if [[ "$CUE_URL" == *.zip ]]; then
        if command -v unzip &> /dev/null; then
            unzip -o "$CUE_FILE" -d "$EXTERNAL_DIR"
            if [ $? -ne 0 ]; then
                echo "错误：cue 解压失败！"
                rm "$CUE_FILE"
                return 1
            fi
        else
            echo "错误：unzip 未找到！"
            rm "$CUE_FILE"
            return 1
        fi
    else
        if command -v tar &> /dev/null; then
            tar -xzf "$CUE_FILE" -C "$EXTERNAL_DIR"
            if [ $? -ne 0 ]; then
                echo "错误：cue 解压失败！"
                rm "$CUE_FILE"
                return 1
            fi
        else
            echo "错误：tar 未找到！"
            rm "$CUE_FILE"
            return 1
        fi
    fi
    
    # 清理压缩包
    rm "$CUE_FILE"
    
    # 检查二进制文件是否存在，处理可能存在的子目录情况
    if [ ! -f "$CUE_BINARY" ]; then
        # 查找解压后的 cue 二进制文件
        FOUND_CUE=$(find "$EXTERNAL_DIR" -name "cue" -type f | head -1)
        if [ -z "$FOUND_CUE" ]; then
            echo "错误：找不到 cue 二进制文件！"
            return 1
        fi
        # 将找到的 cue 二进制文件移动到 .external 目录
        mv "$FOUND_CUE" "$CUE_BINARY"
        # 清理解压产生的子目录
        CUE_SUBDIR=$(dirname "$FOUND_CUE")
        if [ "$CUE_SUBDIR" != "$EXTERNAL_DIR" ]; then
            rm -rf "$CUE_SUBDIR"
        fi
    fi
    
    # 设置执行权限
    chmod +x "$CUE_BINARY"
    
    # 创建软链接到 .bin 目录
    ln -s "$CUE_BINARY" "$BIN_LINK"
    
    echo "cue 安装完成！"
    echo "cue 二进制文件：$CUE_BINARY"
    echo "软链接：$BIN_LINK -> $CUE_BINARY"
}

# 安装 just
install_just() {
    echo "正在安装 just..."
    
    # 检查 just 是否已存在于 .external 目录
    if [[ "$OS" == "windows" ]]; then
        JUST_BINARY="$EXTERNAL_DIR/just.exe"
        BIN_LINK="$BIN_DIR/just.exe"
    else
        JUST_BINARY="$EXTERNAL_DIR/just"
        BIN_LINK="$BIN_DIR/just"
    fi
    
    # 检查是否已安装
    if [ -f "$JUST_BINARY" ]; then
        echo "just 已安装在 $JUST_BINARY，跳过下载和安装"
        
        # 检查软链接是否存在，不存在则创建
        if [ ! -L "$BIN_LINK" ]; then
            ln -s "$JUST_BINARY" "$BIN_LINK"
            echo "已创建 just 软链接 $BIN_LINK -> $JUST_BINARY"
        fi
        return 0
    fi
    
    # 获取最新版本号
    LATEST_VERSION=$(curl -s https://api.github.com/repos/casey/just/releases/latest | grep -o '"tag_name": "[v]*[0-9]*\.[0-9]*\.[0-9]*"' | sed 's/"tag_name": "//' | sed 's/"$//' | sed 's/^v//')
    if [ -z "$LATEST_VERSION" ]; then
        echo "错误：无法获取 just 最新版本号！"
        return 1
    fi
    
    # 根据系统和架构选择下载链接
    case "$OS" in
        "linux")
            case "$ARCH" in
                "amd64")   JUST_URL="https://github.com/casey/just/releases/download/${LATEST_VERSION}/just-${LATEST_VERSION}-x86_64-unknown-linux-musl.tar.gz" ;;
                "arm64")   JUST_URL="https://github.com/casey/just/releases/download/${LATEST_VERSION}/just-${LATEST_VERSION}-aarch64-unknown-linux-musl.tar.gz" ;;
                *)          echo "不支持的架构：$ARCH" ; return 1 ;;
            esac ;;
        "darwin")
            case "$ARCH" in
                "amd64")   JUST_URL="https://github.com/casey/just/releases/download/${LATEST_VERSION}/just-${LATEST_VERSION}-x86_64-apple-darwin.tar.gz" ;;
                "arm64")   JUST_URL="https://github.com/casey/just/releases/download/${LATEST_VERSION}/just-${LATEST_VERSION}-aarch64-apple-darwin.tar.gz" ;;
                *)          echo "不支持的架构：$ARCH" ; return 1 ;;
            esac ;;
        "windows")
            case "$ARCH" in
                "amd64")   JUST_URL="https://github.com/casey/just/releases/download/${LATEST_VERSION}/just-${LATEST_VERSION}-x86_64-pc-windows-msvc.zip" ;;
                "386")     JUST_URL="https://github.com/casey/just/releases/download/${LATEST_VERSION}/just-${LATEST_VERSION}-i686-pc-windows-msvc.zip" ;;
                *)          echo "不支持的架构：$ARCH" ; return 1 ;;
            esac ;;
        *)
            echo "不支持的系统：$OS" ; return 1 ;;
    esac
    
    # 设置压缩包文件名
    JUST_FILE="$EXTERNAL_DIR/just_$(date +%s).$(basename "$JUST_URL" | cut -d. -f3-)"
    
    # 下载并安装
    if command -v curl &> /dev/null; then
        curl -L -f "$JUST_URL" -o "$JUST_FILE"
        if [ $? -ne 0 ]; then
            echo "错误：just 下载失败！"
            return 1
        fi
    elif command -v wget &> /dev/null; then
        wget -O "$JUST_FILE" -q "$JUST_URL"
        if [ $? -ne 0 ]; then
            echo "错误：just 下载失败！"
            return 1
        fi
    else
        echo "错误：curl 或 wget 未找到！"
        return 1
    fi
    
    # 解压
    if [[ "$JUST_URL" == *.zip ]]; then
        if command -v unzip &> /dev/null; then
            unzip -o "$JUST_FILE" -d "$EXTERNAL_DIR"
            if [ $? -ne 0 ]; then
                echo "错误：just 解压失败！"
                rm "$JUST_FILE"
                return 1
            fi
        else
            echo "错误：unzip 未找到！"
            rm "$JUST_FILE"
            return 1
        fi
    else
        if command -v tar &> /dev/null; then
            tar -xzf "$JUST_FILE" -C "$EXTERNAL_DIR"
            if [ $? -ne 0 ]; then
                echo "错误：just 解压失败！"
                rm "$JUST_FILE"
                return 1
            fi
        else
            echo "错误：tar 未找到！"
            rm "$JUST_FILE"
            return 1
        fi
    fi
    
    # 清理压缩包
    rm "$JUST_FILE"
    
    # 检查二进制文件是否存在，处理可能存在的子目录情况
    if [ ! -f "$JUST_BINARY" ]; then
        # 查找解压后的 just 二进制文件
        FOUND_JUST=$(find "$EXTERNAL_DIR" -name "just" -type f | head -1)
        if [ -z "$FOUND_JUST" ]; then
            echo "错误：找不到 just 二进制文件！"
            return 1
        fi
        # 将找到的 just 二进制文件移动到 .external 目录
        mv "$FOUND_JUST" "$JUST_BINARY"
        # 清理解压产生的子目录
        JUST_SUBDIR=$(dirname "$FOUND_JUST")
        if [ "$JUST_SUBDIR" != "$EXTERNAL_DIR" ]; then
            rm -rf "$JUST_SUBDIR"
        fi
    fi
    
    # 设置执行权限
    chmod +x "$JUST_BINARY"
    
    # 创建软链接到 .bin 目录
    ln -s "$JUST_BINARY" "$BIN_LINK"
    
    echo "just 安装完成！"
    echo "just 二进制文件：$JUST_BINARY"
    echo "软链接：$BIN_LINK -> $JUST_BINARY"
}

# 安装 uv
install_uv() {
    echo "正在安装 uv..."
    
    # 检查 uv 是否已存在于 .external 目录
    if [[ "$OS" == "windows" ]]; then
        UV_BINARY="$EXTERNAL_DIR/uv.exe"
        BIN_LINK="$BIN_DIR/uv.exe"
    else
        UV_BINARY="$EXTERNAL_DIR/uv"
        BIN_LINK="$BIN_DIR/uv"
    fi
    
    # 检查是否已安装
    if [ -f "$UV_BINARY" ]; then
        echo "uv 已安装在 $UV_BINARY，跳过下载和安装"
        
        # 检查软链接是否存在，不存在则创建
        if [ ! -L "$BIN_LINK" ]; then
            ln -s "$UV_BINARY" "$BIN_LINK"
            echo "已创建 uv 软链接 $BIN_LINK -> $UV_BINARY"
        fi
        return 0
    fi
    
    # 根据系统和架构选择下载链接
    case "$OS" in
        "linux")
            case "$ARCH" in
                "amd64")   UV_URL="https://github.com/astral-sh/uv/releases/latest/download/uv-x86_64-unknown-linux-gnu.tar.gz" ;;
                "arm64")   UV_URL="https://github.com/astral-sh/uv/releases/latest/download/uv-aarch64-unknown-linux-gnu.tar.gz" ;;
                *)          echo "不支持的架构：$ARCH" ; return 1 ;;
            esac ;;
        "darwin")
            case "$ARCH" in
                "amd64")   UV_URL="https://github.com/astral-sh/uv/releases/latest/download/uv-x86_64-apple-darwin.tar.gz" ;;
                "arm64")   UV_URL="https://github.com/astral-sh/uv/releases/latest/download/uv-aarch64-apple-darwin.tar.gz" ;;
                *)          echo "不支持的架构：$ARCH" ; return 1 ;;
            esac ;;
        "windows")
            case "$ARCH" in
                "amd64")   UV_URL="https://github.com/astral-sh/uv/releases/latest/download/uv-x86_64-pc-windows-msvc.zip" ;;
                "386")     UV_URL="https://github.com/astral-sh/uv/releases/latest/download/uv-i686-pc-windows-msvc.zip" ;;
                *)          echo "不支持的架构：$ARCH" ; return 1 ;;
            esac ;;
        *)
            echo "不支持的系统：$OS" ; return 1 ;;
    esac
    
    # 设置压缩包文件名
    UV_FILE="$EXTERNAL_DIR/uv_$(date +%s).$(basename "$UV_URL" | cut -d. -f2-)"
    
    # 下载并安装
    if command -v curl &> /dev/null; then
        curl -L -f "$UV_URL" -o "$UV_FILE"
        if [ $? -ne 0 ]; then
            echo "错误：uv 下载失败！"
            return 1
        fi
    elif command -v wget &> /dev/null; then
        wget -O "$UV_FILE" -q "$UV_URL"
        if [ $? -ne 0 ]; then
            echo "错误：uv 下载失败！"
            return 1
        fi
    else
        echo "错误：curl 或 wget 未找到！"
        return 1
    fi
    
    # 解压
    if [[ "$UV_URL" == *.zip ]]; then
        if command -v unzip &> /dev/null; then
            unzip -o "$UV_FILE" -d "$EXTERNAL_DIR"
            if [ $? -ne 0 ]; then
                echo "错误：uv 解压失败！"
                rm "$UV_FILE"
                return 1
            fi
        else
            echo "错误：unzip 未找到！"
            rm "$UV_FILE"
            return 1
        fi
    else
        if command -v tar &> /dev/null; then
            tar -xzf "$UV_FILE" -C "$EXTERNAL_DIR"
            if [ $? -ne 0 ]; then
                echo "错误：uv 解压失败！"
                rm "$UV_FILE"
                return 1
            fi
        else
            echo "错误：tar 未找到！"
            rm "$UV_FILE"
            return 1
        fi
    fi
    
    # 清理压缩包
    rm "$UV_FILE"
    
    # 检查二进制文件是否存在，处理可能存在的子目录情况
    if [ ! -f "$UV_BINARY" ]; then
        # 查找解压后的 uv 二进制文件
        FOUND_UV=$(find "$EXTERNAL_DIR" -name "uv" -type f | head -1)
        if [ -z "$FOUND_UV" ]; then
            echo "错误：找不到 uv 二进制文件！"
            return 1
        fi
        # 将找到的 uv 二进制文件移动到 .external 目录
        mv "$FOUND_UV" "$UV_BINARY"
        # 清理解压产生的子目录
        UV_SUBDIR=$(dirname "$FOUND_UV")
        if [ "$UV_SUBDIR" != "$EXTERNAL_DIR" ]; then
            rm -rf "$UV_SUBDIR"
        fi
    fi
    
    # 设置执行权限
    chmod +x "$UV_BINARY"
    
    # 创建软链接到 .bin 目录
    ln -s "$UV_BINARY" "$BIN_LINK"
    
    echo "uv 安装完成！"
    echo "uv 二进制文件：$UV_BINARY"
    echo "软链接：$BIN_LINK -> $UV_BINARY"
}

# 主函数
main() {
    echo "===== 开始执行配置脚本 ====="
    
    # 检测系统和架构
    detect_system
    
    # 创建目录
    create_directories
    
    # 下载字体
    download_fonts
    if [ $? -ne 0 ]; then
        echo "字体下载失败！"
        return 1
    fi
    
    # 安装工具
    install_cue
    if [ $? -ne 0 ]; then
        echo "cue 安装失败！"
        return 1
    fi
    
    install_just
    if [ $? -ne 0 ]; then
        echo "just 安装失败！"
        return 1
    fi
    
    install_uv
    if [ $? -ne 0 ]; then
        echo "uv 安装失败！"
        return 1
    fi
    
    echo "===== 所有配置完成！====="
    echo "可执行文件已添加到 $BIN_DIR"
    echo "建议将 $BIN_DIR 添加到 PATH 环境变量中"
}

# 执行主函数
main