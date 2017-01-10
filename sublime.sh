#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then  # Mac script
    # Install package control
    echo 'Installing package control'
    curl "https://sublime.wbond.net/Package%20Control.sublime-package" -o "${HOME}/Library/Application Support/Sublime Text 3/Installed Packages/Package Control.sublime-package"

    echo "Creating symlink to sublime package control settings"
    ln -s -f ~/dotfiles/sublime/Package\ Control.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User

    echo 'Creating symlink to sublime user settings'
    ln -s -f ~/dotfiles/sublime/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User

    echo 'Creating symlink to trailing spaces package settings'
    ln -s -f ~/dotfiles/sublime/trailing_spaces.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User

    echo 'Creating symlink to side bar settings'
    ln -s -f ~/dotfiles/sublime/Side\ Bar.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User

    echo ' Creating symlink to Anaconda settings'
    ln -s -f ~/dotfiles/sublime/Anaconda.sublime-settings ~/Library/Application\ Support/Sublime\ Text*/Packages/User

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    echo "linux script not done yet"
    wget -O "$HOME/.config/sublime-text-3/Installed Packages/Package Control.sublime-package" https://sublime.wbond.net/Package%20Control.sublime-package
    ln -s Package\ Control.sublime-settings ~/.config/sublime-text-2/Packages/User/

elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo "Windows script not built yet"
fi


