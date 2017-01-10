#!/usr/bin/env bash

# Homebrew

if ! type brew > /dev/null; then
  echo "Homebrew not found, installing..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew already installed"
  brew update
fi

#-------------------------------------------------------------------------------
# Packages

packages="bash cask coreutils ffmpeg gcc git openssh p7zip postgresql
 python python3 rename the_silver_searcher thefuck tree wget zsh"

for package in $packages; do
  brew install "$package"
done

brew install "macvim --overwrite-system-vi"

# Post-install stuff
brew services start postgresql

#-------------------------------------------------------------------------------
# Apps

apps="bettertouchtool cakebrew dropbox flux flycut flashlight google-chrome sourcetree 
  google-drive github iterm2 heroku-toolbelt slack spotify sublime-text transmission vlc"

for app in $apps; do
  brew cask install "$app"
done

brew cask cleanup

#-------------------------------------------------------------------------------
# zsh

if ! [ -d ~/.oh-my-zsh ]; then
  echo "Cloning oh-my-zsh..."
  git clone git@github.com:robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
else
  echo "oh-my-zsh already exists"
fi

#-------------------------------------------------------------------------------
# zsh theme

if ! [ -L ~/.oh-my-zsh/themes/nilswerner.zsh-theme ]; then
  echo "Linking zsh theme..."
  ln -s ~/dotfiles/nilswerner.zsh-theme ~/.oh-my-zsh/themes/nilswerner.zsh-theme
else
  echo "zsh theme already linked"
fi

#-------------------------------------------------------------------------------
# Unicorn leap

if ! [ -e  ~/code/unicornleap ]; then
  echo "Installing unicornleap..."
  mkdir -p ~/code
  cd ~/code
  git clone git@github.com:jgdavey/unicornleap.git
  cd unicornleap
  make && make install
else
  echo "unicornleap already installed"
fi

#-------------------------------------------------------------------------------
# Python stuff