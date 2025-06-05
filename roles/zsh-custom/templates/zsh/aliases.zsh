setopt nullglob
for file in "$HOME/.config/shells/zsh/aliases/"*.zsh; do
  [ -f "$file" ] && source_if_exists "$file"
done
unsetopt nullglob