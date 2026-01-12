#!/bin/bash

curl -L https://github.com/cue-lang/cue/releases/download/v0.15.1/cue_v0.15.1_linux_amd64.tar.gz -o cue.tar.gz
mkdir ~/cue
mv cue.tar.gz ~/cue/
cd ~/cue
tar -xvf cue.tar.gz
rm cue.tar.gz
echo '
# setup cue
export PATH=$PATH:~/cue
' >>~/.bashrc
