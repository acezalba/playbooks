setopt nullglob
for file in "$HOME/.config/shells/zsh/config/"*.zsh; do
  [ -f "$file" ] && source_if_exists "$file"
done
unsetopt nullglob
