#!/usr/bin/env bash

# Dotfiles Install Script
# This script installs configuration files from this repository to your home directory
# It creates symlinks by default, so changes to files are automatically synced

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}Installing dotfiles from repository...${NC}\n"

# Function to create symlink with backup
link_file() {
    local source="$1"
    local dest="$2"
    
    if [ -f "$source" ]; then
        # Backup existing file if it exists and is not a symlink
        if [ -e "$dest" ] && [ ! -L "$dest" ]; then
            backup="$dest.backup.$(date +%Y%m%d_%H%M%S)"
            mv "$dest" "$backup"
            echo -e "${YELLOW}⚠${NC}  Backed up existing: $dest -> $backup"
        fi
        
        # Remove existing symlink if present
        if [ -L "$dest" ]; then
            rm "$dest"
        fi
        
        # Create symlink
        ln -s "$source" "$dest"
        echo -e "${GREEN}✓${NC} Linked: $source -> $dest"
    else
        echo -e "${RED}✗${NC} Not found in repo: $source"
    fi
}

# Install Zsh configs
link_file "$REPO_DIR/config/zsh/.zshrc" "$HOME/.zshrc"
link_file "$REPO_DIR/config/zsh/.zshenv" "$HOME/.zshenv"
link_file "$REPO_DIR/config/zsh/.zprofile" "$HOME/.zprofile"

# Install Bash configs
link_file "$REPO_DIR/config/bash/.bashrc" "$HOME/.bashrc"
link_file "$REPO_DIR/config/bash/.bash_profile" "$HOME/.bash_profile"

# Install Vim configs
link_file "$REPO_DIR/config/vim/.vimrc" "$HOME/.vimrc"

# Install Git configs
link_file "$REPO_DIR/config/git/.gitconfig" "$HOME/.gitconfig"

# Install Tmux config
link_file "$REPO_DIR/config/tmux/.tmux.conf" "$HOME/.tmux.conf"

echo -e "\n${BLUE}Installation complete!${NC}"
echo -e "Your dotfiles are now symlinked from this repository."
echo -e "Any changes you make to the files in your home directory will be reflected here."
