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
 python python3 rename the_silver_searcher thefuck tree vim wget zsh"

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
# Python stuff

pip install virtualenvwrapper

#-------------------------------------------------------------------------------
# zsh

if ! [ -d ~/.oh-my-zsh ]; then
  echo "Cloning oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo "oh-my-zsh already exists"
fi

#-------------------------------------------------------------------------------
# zsh theme, plugins & settings

git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

ln -s -f ~/dotfiles/.zshrc ~/.zshrc
wget -P "${HOME}/Library/Fonts" https://github.com/powerline/fonts/raw/master/Meslo/Meslo%20LG%20M%20Regular%20for%20Powerline.otf
source ~/.zshrc

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
