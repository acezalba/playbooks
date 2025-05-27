for file in "$HOME/.config/shells/zsh/aliases/"*.zsh; do
  [ -f "$file" ] && source "$file"
done
