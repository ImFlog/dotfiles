# VIM <3
export EDITOR='vim'
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

# Antidote configuration
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load # loads ~/.zsh_plugins.txt

# Starship
eval "$(starship init zsh)"

# Pokemonsay
pokemonsay

# Bat
alias cat=bat
alias rcat=cat
export MANPAGER="sh -c 'col -bx | bat -l man -p'" # manpage use bat

# Prettyping
alias ping=prettyping --nolegend

# ASDF
echo -e "\n. $(brew --prefix asdf)/libexec/asdf.sh" >> ${ZDOTDIR:-~}/.zshrc
export ASDF_GOLANG_MOD_VERSION_ENABLED=true

