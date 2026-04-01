# Dotfiles Repository

Personal system configuration for Hyprland (Wayland), waybar, Neovim, and other tools.

## Repository Structure

Organized by tool/application. Each directory contains configurations meant to be symlinked to their target locations (`~/.config/`, `~`, etc.).

```
├── hypr/          # Hyprland compositor config + extensive scripts
├── waybar/        # Status bar (configs/, style/, Modules*/)
├── nvim/          # AstroNvim configuration
├── kitty/         # Terminal emulator
├── rofi/          # Application launcher
├── yazi/          # File manager + plugins
├── btop/          # System monitor
├── fish/          # Shell
├── tmux/          # Terminal multiplexer
├── droid/         # Factory AI Droid settings (MCP servers, encrypted settings)
├── yasb/          # Status bar
├── ahk/           # AutoHotkey (Windows)
├── vivaldi/       # Browser
├── komorebic/     # Window manager (Windows)
└── powershell/    # PowerShell profile
```

## Common Commands

```bash
# Pull latest changes
git pull origin master

# View changes
git status
git diff

# Commit changes
git add <files>
git commit -m "message"

# Decrypt encrypted settings (droid/)
./droid/decrypt_settings.sh
```

## Key Details

### Encrypted Files
Some files are encrypted with sops + age. The `.sops.yaml` rule encrypts `*.enc.json` files. Use `droid/decrypt_settings.sh` to decrypt.

### Hyprland Scripts
The `hypr/scripts/` directory contains 50+ shell scripts for window management, themes, brightness, media, screenshots, and more. Many are called via keybinds defined in `hyprland.conf`.

### Waybar Modularity
- `waybar/configs/` - Multiple config presets (e.g., "[TOP] Default Laptop")
- `waybar/style/` - Theme variants (e.g., "[Light] Obsidian Glow.css")
- `waybar/Modules*.lua` - Custom module definitions
- Active config/style symlinked as `config` and `style.css`

### Droid Configuration
- `droid/config.json` - Custom AI models for Droid
- `droid/mcp.json` - MCP server definitions
- `droid/settings.enc.json` - Encrypted user settings

### Language Preferences (from user memories)
- Go: Clean Architecture with mockery for mocks
- Python: FastAPI + pytest, use `uv` for package management
