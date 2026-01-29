#!/bin/zsh

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Always show hidden files
defaults write http://com.apple.Finder AppleShowAllFiles true
# No accents when a char is kept pressed
defaults write -g ApplePressAndHoldEnabled -bool false
# Use touch ID for sudo commands
sed "s/^#auth/auth/" /etc/pam.d/sudo_local.template | sudo tee /etc/pam.d/sudo_local
