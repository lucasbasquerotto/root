#!/bin/bash
set -eou pipefail

git clone https://github.com/lucasbasquerotto/ctl.git

cd ctl
./run dev-setup "https://lucasbasquerotto@bitbucket.org/lucasbasquerotto/ansible-main-env-demo.git"
