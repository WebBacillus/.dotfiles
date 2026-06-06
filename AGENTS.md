# Dotfiles Repository

Personal dotfiles for EndeavourOS/Hyprland. Most top-level directories are intended to be symlinked into `~/.config` or a tool-specific home directory, not built as one app.

## Active Paths

- `~/.config/hypr` currently resolves to this repo's `hypr/`; editing `hypr/*` affects the live Hyprland config.
- `waybar/config` and `waybar/style.css` are symlinks to the active preset; currently `configs/[TOP] Default Laptop` and `style/[Light] Obsidian Glow.css`.
- Neovim config lives in `astronvim_v6/` (`init.lua`, `lua/lazy_setup.lua`, `lua/plugins/`); `astronvim_v5/` is an older template, and there is no root `nvim/` directory.

## Shell

- Login shell is **fish**; auto-start logic lives in `~/.config/fish/config.fish`, not `.profile`.

## Hyprland

- `hypr/hyprland.conf` sources vendor defaults from `hypr/configs/` first, then user overrides from `hypr/UserConfigs/`; prefer `UserConfigs/` for local behavior changes unless updating shared defaults intentionally.
- This install is Hyprland `0.55.x`, while these files are still hyprlang `.conf`. Validate with `hyprctl reload` and then `hyprctl configerrors`.
- Window rules use the newer field syntax already present in `configs/WindowRules.conf`: `windowrule = match:class ^(foo)$, float on`. Do not copy old `windowrule = float, class:^(foo)$` or pre-0.53 rules from `configs/WindowRules-pre-53.conf` into active files.
- Current boolean effect names include `no_blur` and `no_anim`, not old `noblur`/`noanim`.
- Monitor profiles are selected by the Rofi profile flow and overwrite `~/.config/hypr/monitors.conf`, backing up the previous file as `Previous_Profile.conf`.

## Waybar

- Presets are split across `waybar/configs/`, `waybar/style/`, and module files (`Modules*`, `UserModules`). If changing the active bar, patch the symlink target or update the symlink deliberately.
- Many preset filenames contain spaces and brackets; quote paths in shell commands.

## Secrets

- Encrypted JSON is managed with `sops` + age. Do not commit decrypted outputs.
- `droid/decrypt_settings.sh [-k keyfile]` decrypts `droid/settings.enc.json` to `~/.factory/settings.json`.
- `claude/decrypt_settings.sh [-k keyfile]` decrypts `claude/settings.enc.json` and `claude/.credentials.enc.json` to `~/.claude/`.
- Both decrypt scripts default to `~/.config/sops/age/keys.txt`.

## Generated Files

- `custom_script/package-list-backup.sh` regenerates `pkg/pkglist.txt` and `pkg/aur_pkglist.txt` with `pacman -Qqen`/`pacman -Qqem`, then commits only those files with message `chore: update package lists` when changed.
- The package-list cron is `custom_script/package-list-backup.cron` and runs daily at 02:00.
