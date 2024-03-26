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
  homebrew/cask-fonts # for fira code font
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
  "fortune"                  # wisdom on startup
  "pokemonsay"               # pokemon on startup
  "nvim"                     # neovim
  "watch"                    # watch command
  "zsh-autosuggestions"      # autosuggestions based on previous commands
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

echo 'Copying .zshrc file'
cp .zshrc ~/.zshrc

echo 'Copying starship config'
cp starship.toml ~/.config/starship.toml

echo 'Copying atuin config'
cp atuin.config.toml ~/.config/atuin/config.toml
