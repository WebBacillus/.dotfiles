# Dotfiles

Personal system configuration for Hyprland (Wayland), Neovim, Waybar, and other tools on EndeavourOS.

## Structure

```
├── hypr/          # Hyprland compositor config + scripts
├── waybar/        # Status bar configs and styles
├── astronvim_v6/  # Neovim (AstroNvim) configuration
├── kitty/         # Terminal emulator
├── fish/          # Shell configuration
├── rofi/          # Application launcher
├── tmux/          # Terminal multiplexer
├── droid/         # Factory AI Droid settings (MCP, encrypted)
├── custom_script/ # Utility scripts and cron jobs
└── ...            # Other tool configs (btop, yazi, kanshi, etc.)
```

## Package List Backup

A daily cron job backs up installed packages and auto-commits changes:

- `pkglist.txt` — explicitly installed native pacman packages
- `aur_pkglist.txt` — explicitly installed AUR/foreign packages

**Script:** `custom_script/package-list-backup.sh`
**Cron snippet:** `custom_script/package-list-backup.cron` (daily at 2am)
**To install the cron job:** copy the cron snippet into your crontab (`crontab custom_script/package-list-backup.cron`)

## Setup

```bash
git clone https://github.com/webbacillus/.dotfiles ~/.dotfiles
# Then symlink individual config directories to ~/.config/ as needed
```

