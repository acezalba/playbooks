# Source system environment (if readable)
if [ -r /etc/environment ]; then
  source /etc/environment
fi

# Source all enabled path snippets (via symlinks)
for file in "$HOME/.config/shells/zsh/path/"*.zsh; do
  [ -f "$file" ] && source "$file"
done