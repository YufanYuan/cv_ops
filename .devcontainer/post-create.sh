#!/bin/bash
uv sync

# font installation, important step for adding fonts. rendercv don't actually read fonts in fonts folder.
sudo apt update
sudo apt install -y fontconfig fonts-noto-cjk vim
fc-cache -fv

bash ./.devcontainer/install-cue.sh
source ~/.bashrc
just compile example_cn
./compile.sh dist/baseline.yaml
