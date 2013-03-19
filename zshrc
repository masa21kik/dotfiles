source ~/.zsh.d/zshrc

compdef mosh=ssh

[[ -s "$HOME/.zsh_local" ]] && source "$HOME/.zsh_local"

# rbenvの設定
if [ -s "$HOME/.rbenv" ]
then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi
