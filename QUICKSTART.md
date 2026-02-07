# Quick Start Guide

## First Time Setup

1. **Backup your existing config files:**
   ```bash
   ./backup.sh
   git add .
   git commit -m "Initial backup of config files"
   git push
   ```

2. **On a new machine, install the configs:**
   ```bash
   git clone https://github.com/cricket1989/nicksdots.git
   cd nicksdots
   ./install.sh
   ```

## Daily Workflow

### When you make changes to your config files:

Since the install script creates symlinks, your changes are automatically reflected in the repository. Just commit and push:

```bash
cd ~/nicksdots  # or wherever you cloned the repo
git status      # see what changed
git add .
git commit -m "Update vim config"
git push
```

### When you want to backup without symlinks:

If you prefer to manually backup config files instead of using symlinks:

```bash
./backup.sh
git add .
git commit -m "Update configs"
git push
```

## Adding New Config Files

1. **Edit backup.sh** - Add a backup_file line:
   ```bash
   backup_file "$HOME/.myconfig" "$REPO_DIR/config/myapp/.myconfig"
   ```

2. **Edit install.sh** - Add a link_file line:
   ```bash
   link_file "$REPO_DIR/config/myapp/.myconfig" "$HOME/.myconfig"
   ```

3. **Create the directory** if needed:
   ```bash
   mkdir -p config/myapp
   ```

## Tips

- Check what files are in your home directory: `ls -la ~`
- Sample configs are provided - customize them with your preferences
- The .gitignore protects sensitive files from being committed
- Existing files are backed up before being replaced (with timestamp)
