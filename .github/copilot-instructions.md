# Copilot Instructions for nicksdots

## Overview
This is a personal dotfiles repository for an Arch Linux system. It contains configuration files for various applications and system tools, primarily focused on Zsh shell, Hyprland (Wayland compositor), and terminal customization.

## Repository Structure

### Primary Configuration Directories
- `.config/` - Main configuration directory (XDG_CONFIG_HOME equivalent)
  - Contains configs for: hypr, kitty, alacritty, rofi, waybar, yazi, btop, fastfetch, and more
- `.local/` - Local user files and binaries
- `zsh/` - Zsh-specific configuration files
- `.oh-my-zsh/` - Oh My Zsh framework installation
- `oh-my-zsh-custom/` - Custom Oh My Zsh plugins and themes
- `.themes/` - GTK and system themes

### Key Configuration Files
- `.config/.zshrc` and `zsh/.zshrc` - Zsh shell configuration
- `.config/.p10k.zsh` - Powerlevel10k prompt configuration
- `.config/hypr/` - Hyprland compositor configuration
- `.config/kitty/` and `.config/alacritty/` - Terminal emulator configs

## Coding Standards and Conventions

### Shell Scripts (Bash/Zsh)
- Use Zsh syntax when the shebang is `#!/usr/bin/env zsh` or `#!/bin/zsh`
- Follow existing indentation style (2 spaces)
- Add comments for complex logic
- Prefer built-in commands over external programs when possible
- Use proper quoting for variables to prevent word splitting

### Configuration Files
- Maintain existing formatting and indentation style
- Keep comments that explain non-obvious configuration
- Test configuration changes before committing
- Preserve user-specific paths (e.g., `/home/nick/`) in configurations

### File Organization
- Place new application configs in `.config/[app-name]/`
- Shell scripts and functions go in `zsh/` or `.local/bin/`
- Keep dotfiles at their conventional locations (e.g., `.zshrc`, `.zprofile`)

## Environment-Specific Notes

### System
- Target OS: Arch Linux
- Package Manager: `pacman` and `yay` (AUR helper)
- Display Server: Wayland (via Hyprland)
- Shell: Zsh with Oh My Zsh

### Tools and Applications
- Terminal: Kitty, Alacritty
- Editor: Neovim (aliased as `lvim`), VS Code
- File Manager: Yazi (terminal), Dolphin (GUI)
- Bar: Waybar
- Launcher: Rofi
- Theme Engine: Matugen (material color generation)

### Oh My Zsh Configuration
- Theme: Agnoster (with Powerlevel10k available)
- Plugins: git, zsh-autosuggestions, zsh-autocomplete, zsh-syntax-highlighting
- Custom plugins location: `oh-my-zsh-custom/plugins/`

## Best Practices

### When Adding New Configurations
1. Follow the XDG Base Directory specification
2. Place configs in `.config/[application]/` when possible
3. Update `.gitignore` to exclude cache files, logs, and secrets
4. Test configurations in isolation before committing

### When Modifying Shell Configs
1. Be careful with PATH modifications - avoid duplicates
2. Preserve existing aliases and functions
3. Source files that exist before using them
4. Consider startup time - avoid heavy operations in `.zshrc`

### When Working with Symlinks
- This repository may be deployed using GNU Stow or similar tools
- Maintain flat structure where appropriate for easy symlinking
- Don't assume absolute paths will work on other systems

## Prohibited Actions
- Don't commit secrets, API keys, or personal tokens
- Don't hardcode absolute paths that won't work on other systems (unless unavoidable)
- Don't remove working configurations without good reason
- Don't add large binary files or compiled artifacts

## Testing and Validation
- For shell scripts: Use `shellcheck` to validate syntax
- For Zsh configs: Test with `zsh -n <file>` for syntax errors
- For application configs: Verify the application can load the config
- Always preview changes with `git diff` before committing

## Git Workflow
- Keep commits focused and atomic
- Write clear commit messages describing what was changed and why
- Don't commit files listed in `.gitignore` (cache, logs, secrets, wal/, .oh-my-zsh/)

## Additional Context
- This is a personal configuration repository for user "nick"
- Configurations are optimized for a single-user desktop environment
- Many configs reference `/home/nick/` which is user-specific
- The repository represents an actively used system configuration
