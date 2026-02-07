#!/usr/bin/env bash

# Dotfiles Backup Script
# This script backs up configuration files from your home directory to this repository

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}Backing up configuration files to repository...${NC}\n"

# Function to backup a file
backup_file() {
    local source="$1"
    local dest="$2"
    
    if [ -f "$source" ]; then
        mkdir -p "$(dirname "$dest")"
        cp "$source" "$dest"
        echo -e "${GREEN}✓${NC} Backed up: $source -> $dest"
    else
        echo -e "${RED}✗${NC} Not found: $source"
    fi
}

# Backup Zsh configs
backup_file "$HOME/.zshrc" "$REPO_DIR/config/zsh/.zshrc"
backup_file "$HOME/.zshenv" "$REPO_DIR/config/zsh/.zshenv"
backup_file "$HOME/.zprofile" "$REPO_DIR/config/zsh/.zprofile"

# Backup Bash configs
backup_file "$HOME/.bashrc" "$REPO_DIR/config/bash/.bashrc"
backup_file "$HOME/.bash_profile" "$REPO_DIR/config/bash/.bash_profile"

# Backup Vim configs
backup_file "$HOME/.vimrc" "$REPO_DIR/config/vim/.vimrc"

# Backup Git configs
backup_file "$HOME/.gitconfig" "$REPO_DIR/config/git/.gitconfig"

# Backup Tmux config
backup_file "$HOME/.tmux.conf" "$REPO_DIR/config/tmux/.tmux.conf"

echo -e "\n${BLUE}Backup complete!${NC}"
echo -e "Don't forget to commit and push your changes:\n"
echo -e "  cd $REPO_DIR"
echo -e "  git add ."
echo -e "  git commit -m 'Update config files'"
echo -e "  git push"
