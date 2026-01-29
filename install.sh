#!/bin/zsh
# Exit on error
set -e

if [[ $(command -v brew) == "" ]]; then
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Updating Homebrew"
    brew update
fi

# Install brew taps
taps=(
  possatti/possatti   # for pokemonsay
)
for tap in $taps; do
  brew tap $tap
done

# Install brew plugins
plugins=(
  "font-fira-code-nerd-font" # custom font with ligatures
  "starship"                 # starship for a cool shell prompt
  "bat"                      # improved cat
  "prettyping"               # improved ping
  "asdf"                     # programming language version manager
  "atuin"                    # ctrl-r with superpowers
  "pokemonsay"               # pokemon on startup
  "watch"                    # watch command
  "zsh-autosuggestions"      # autosuggestions based on previous commands
  "p7zip"                    # extract from CLI
  "k9s" 		     # kubernetes resource management
  "ffmpeg"                   # audio / video management
  "git"
  "uv"
  "gh"
  "jq"
  "yq"
  "go-task"                  # Taskfile
  "ghostty"                  # Terminal
  "ollama"                   # local LLM
  "docker"                   # container
  "bruno"                    # API client
  "keepassxc"                # secret manager
)
for plugin in $plugins; do 
  brew install $plugin
done

# Install ohmyzsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing OhMyZsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Updating OhMyZsh"
  $ZSH/tools/upgrade.sh
fi

echo 'Linking .zshrc file'
ln -s ~/.zshrc .zshrc 

echo 'Linking vim config'
ln -s ~/.vimrc .vimrc

# Git
echo 'Linking git config'
ln -s ~/.gitconfig git/.gitconfig

mkdir -p ~/.config

echo 'Linking starship config'
ln -s ~/.config/starship.toml starship.toml

echo 'Linking atuin config'
ln -s ~/.config/atuin/config.toml atuin.config.toml

echo 'Linking asdf config'
ln -s ~/.asdfrc .asdfrc 

echo 'Starting ollama service'
brew services start ollama

sudo ./sudo_install.sh
