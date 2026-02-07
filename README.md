# nicksdots

Personal configuration files backup repository.

## Overview

This repository contains my dotfiles and configuration files for various applications. It includes scripts to backup configurations from your system and install them on a new machine.

## Directory Structure

```
nicksdots/
├── config/
│   ├── bash/          # Bash configuration files
│   ├── git/           # Git configuration
│   ├── tmux/          # Tmux configuration
│   ├── vim/           # Vim configuration
│   └── zsh/           # Zsh configuration
├── backup.sh          # Script to backup configs from system to repo
└── install.sh         # Script to install configs from repo to system
```

## Usage

### Backing Up Configuration Files

To backup your current configuration files to this repository:

```bash
./backup.sh
```

This will copy your configuration files from your home directory to the appropriate directories in this repository. After running the backup script, commit and push your changes:

```bash
git add .
git commit -m "Update config files"
git push
```

### Installing Configuration Files

To install configuration files from this repository to your system:

```bash
./install.sh
```

This script will:
- Create symlinks from your home directory to the files in this repository
- Backup any existing configuration files (with timestamp)
- Any changes you make to configs will be automatically reflected in the repository

### Adding New Configuration Files

1. **Manually add files** to the appropriate directory under `config/`
2. **Update the scripts** to include the new files:
   - Edit `backup.sh` to add a new `backup_file` line
   - Edit `install.sh` to add a new `link_file` line

Example:
```bash
# In backup.sh
backup_file "$HOME/.config/myapp/config.yml" "$REPO_DIR/config/myapp/config.yml"

# In install.sh
link_file "$REPO_DIR/config/myapp/config.yml" "$HOME/.config/myapp/config.yml"
```

## Setting Up on a New Machine

1. Clone this repository:
   ```bash
   git clone https://github.com/cricket1989/nicksdots.git
   cd nicksdots
   ```

2. Run the install script:
   ```bash
   ./install.sh
   ```

3. Your configuration files are now symlinked and ready to use!

## Notes

- The `.gitignore` file is configured to exclude sensitive files like SSH keys, history files, and temporary files
- Existing configuration files are automatically backed up with timestamps before being replaced
- Using symlinks means your changes are automatically tracked by git - just commit and push when ready

## Customization

Feel free to modify the scripts to include additional configuration files or change the directory structure to suit your needs.
