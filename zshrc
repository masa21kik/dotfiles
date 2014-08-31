source ~/.zsh.d/zshrc

compdef mosh=ssh

[[ -s "$HOME/.zsh_local" ]] && source "$HOME/.zsh_local"

# rbenvの設定
if [ -s "$HOME/.rbenv" ]
then
  export PATH=$HOME/.rbenv/bin:$PATH
  eval "$(rbenv init -)"
fi

# go
export GOROOT=$HOME/local/go
export GOPATH=$HOME
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# peco
# from http://weblog.bulknews.net/post/89635306479/ghq-peco-percol
function peco-src () {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# process kill
function peco-pkill() {
  for pid in `ps | peco | awk '{ print $2 }'`
  do
    kill $pid
    echo "Killed ${pid}"
  done
}
alias pk="peco-pkill"
