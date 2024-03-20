#!/bin/zsh

plugins=(
  "antidote"   # zsh plugin management
  "starship"   # starship for a cool shell prompt
  "pokemonsay" # pokemon on startup
  "bat"        # improved cat
  "prettyping" # improved ping
  "asdf"       # programming language version manager
)
for plugin in $plugins; do 
  brew install $plugin
done

cp .zsh_plugins.txt ~/.zsh_plugins.txt
