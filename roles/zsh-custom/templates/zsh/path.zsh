# Source system environment (if readable)
if [ -r /etc/environment ]; then
  source /etc/environment
fi

# Source all enabled path snippets (via symlinks)
setopt nullglob
for file in "$HOME/.config/shells/zsh/path/enabled"/*.zsh; do
  [ -f "$file" ] && source_if_exists "$file"
done
unsetopt nullglob