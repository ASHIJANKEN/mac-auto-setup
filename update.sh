#!/bin/bash
cat << EOS

 AkkeyLab

 The elapsed time does not matter.
 Because speed is important.

EOS

#
# repository update
#
git checkout ashija
git pull origin ashija

# #
# # private.zsh update
# #
# cp $(cd $(dirname ${BASH_SOURCE:-$0}); pwd)/settings/zsh/private.zsh ~/.yadr/zsh/private.zsh
# source ~/.zshrc

#
# Homebrew update and upgrade
#
brew upgrade

#
# Homebrew Cask check and upgrade
#
brew cask outdated
brew cask upgrade

#
# App Store app upgrade
#
mas upgrade

#
# Update .Brewfile
# global: Save .Brewfile to the home folder
# force: Force overwrite
#
brew bundle dump --global --force

