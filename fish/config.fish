if status is-interactive
    # Commands to run in interactive sessions can go here
end

bind --mode insert \cf forward-char

zoxide init fish | source
fzf --fish | source

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
if test -f /home/webbacillus/miniconda3/bin/conda
    eval /home/webbacillus/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/webbacillus/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/webbacillus/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/webbacillus/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

# Initialize pyenv
if type -q pyenv
    pyenv init - | source
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv fish)"
