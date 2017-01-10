#!/bin/bash

############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

olddir=~/dotfiles_old             # old dotfiles backup directory
files="aliases bash_profile editorconfig exports gitconfig
    gitignore gvimrc inputrc screenrc vimrc wgetrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
read -r -p 'Do you want to backup existing dotfiles to /dotfiles_old? [y/N] ' response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    echo "Creating $olddir for backup of any existing dotfiles in ~"
    mkdir -p $olddir
    echo "...done"
    echo "Moving any existing dotfiles from ~ to $olddir"
    for file in $files; do
        mv ~/.$file ~/dotfiles_old/
    done
fi

for file in $files; do
    echo "Creating symlink to $file in home directory."
    ln -s -f ~/dotfiles/.$file ~/.$file
done