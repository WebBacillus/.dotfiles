if status is-interactive
    # Commands to run in interactive sessions can go here
end

bind --mode insert \cf forward-char

zoxide init fish | source
fzf --fish | source

set -gx EDITOR nvim
set -gx VISUAL nvim
