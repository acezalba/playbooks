for file in "$HOME/.config/shells/zsh/config/"*.zsh; do
  [ -f "$file" ] && source "$file"
done
