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

