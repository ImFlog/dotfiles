# export LANG=en_US.UTF-8

# VIM <3
export EDITOR='nvim'
alias vi='nvim'
alias vim='nvim'

# Git related
alias gst='git status'
alias gup='git fetch && git pull'
alias gpu='git push'
alias gsta='git stash'
alias gpop="git stash pop"
alias gci="git commit -m"
alias gbr='git branch'
alias gclean="git remote prune origin && git branch -vv | grep ': gone]' | awk '{print \$1; }' | grep -v '\*' | xargs git branch -D"
alias gco="git checkout"

# OhMyZsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="" # I use starship
COMPLETION_WAITING_DOTS="true"
plugins=(
  asdf
  brew
  docker
  docker-compose
  extract
  golang
  gradle
  helm
  kubectl
  minikube
  yarn
)
source $ZSH/oh-my-zsh.sh
# zsh autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Starship
eval "$(starship init zsh)"

# Bat
alias cat=bat
alias rcat=cat
export MANPAGER="sh -c 'col -bx | bat -l man -p'" # manpage use bat

# Prettyping
alias ping=prettyping --nolegend

# ASDF
. $(brew --prefix asdf)/libexec/asdf.sh
export ASDF_GOLANG_MOD_VERSION_ENABLED=true
. ~/.asdf/plugins/java/set-java-home.zsh

# Atuin
eval "$(atuin init zsh)"

# additional paths
export PATH="/Users/admin/.local/bin:$PATH"

# Load secrets
eval ~/.zsh_secrets

# Very important, gotta catch them all
fortune | pokemonsay
