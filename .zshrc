setopt CORRECT              # Spell correction for commands

# VIM <3
export EDITOR='vim'
alias vi='vim'

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
# alias cat=bat # Messes with AI coding tools in certain cases :(
alias rcat=cat
export MANPAGER="sh -c 'col -bx | bat -l man -p'" # manpage use bat

# GNU sed (replace macOS default)
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"

# ASDF
. $(brew --prefix asdf)/libexec/asdf.sh
export ASDF_GOLANG_MOD_VERSION_ENABLED=true
export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_available
. ~/.asdf/plugins/java/set-java-home.zsh
# Go environment (via asdf)
export GOPATH="$(asdf where golang)/packages"
export GOROOT="$(asdf where golang)/go"
export PATH="${PATH}:${GOROOT}/bin:${GOPATH}/bin"
export PATH="${PATH}:$(asdf where flutter)/bin"

# Atuin
eval "$(atuin init zsh)"

# additional paths
export PATH="$PATH:$HOME/.local/bin"

# Load secrets
source ~/.zsh_secrets

# Very important, gotta catch them all
echo 'Go !' | pokemonsay
