if status is-interactive
    # Commands to run in interactive sessions can go here
end

bind --mode insert \cf forward-char

# zoxide (only if installed)
if type -q zoxide
    zoxide init fish | source
end

set -U FZF_DISABLE_KEYBINDINGS 1
# fzf (only if installed)
if type -q fzf
    fzf --fish | source
end
bind -M insert -e \ec

set -gx EDITOR nvim
set -gx VISUAL nvim

# Check the Operating System
set -l os_name (uname)

if test "$os_name" = "Darwin"
    # --- MacOS Specific Paths ---
    fish_add_path /Users/t.pasit.khumsena/.antigravity/antigravity/bin

else if test "$os_name" = "Linux"
    # --- Windows/WSL/Linux Specific Paths ---
end


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# Only initialize conda if it exists
if test -f /home/webbacillus/miniconda3/bin/conda
    eval /home/webbacillus/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else if test -f "/home/webbacillus/miniconda3/etc/fish/conf.d/conda.fish"
    . "/home/webbacillus/miniconda3/etc/fish/conf.d/conda.fish"
else if test -d "/home/webbacillus/miniconda3"
    set -x PATH "/home/webbacillus/miniconda3/bin" $PATH
end
# <<< conda initialize <<<

# Initialize pyenv (only if installed)
if type -q pyenv
    pyenv init - | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Linuxbrew (only if installed)
if type -q /home/linuxbrew/.linuxbrew/bin/brew
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"
end
