function fish_user_key_bindings
  fzf --fish | source
  bind -M insert -e \ec
  bind -e \ec
end
