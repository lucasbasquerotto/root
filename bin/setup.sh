#!/bin/bash
set -eou pipefail

CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

ctl_dir="ctl"

if [ ! -d "$ctl_dir/.git" ] || [ "${1:-}" = "-f" ]; then
	echo -e "${CYAN}$(date '+%F %X') Clone repository...${NC}"
	shopt -s dotglob && rm -rf "${ctl_dir:?}"/*
	git clone https://github.com/lucasbasquerotto/ctl.git "$ctl_dir"
else
	echo -e "${CYAN}$(date '+%F %X') Pull repository...${NC}"
	git -C "$ctl_dir" pull
fi

echo -e "${CYAN}$(date '+%F %X') Root Setup...${NC}"

"$ctl_dir"/run dev-setup "https://lucasbasquerotto@bitbucket.org/lucasbasquerotto/ansible-main-env-demo.git"
