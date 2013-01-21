source ~/.zsh.d/zshrc

compdef mosh=ssh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ -s "$HOME/.zsh_local" ]] && source "$HOME/.zsh_local"
