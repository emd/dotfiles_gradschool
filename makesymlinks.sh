#!/bin/bash

######################################################
# This script creates symlinks from the home directory
# to any desired dotfiles in ~/dotfiles
######################################################

# dotfiles directory
dir=~/dotfiles

# old dotfiles backup directory
olddir=~/dotfiles_old

# list of dot files/folders to symlink in ~
# NOTE: Dots are *suppressed* and are manually prepended
# in the linking commands below. This allows us to easily
# list contents of dotifles w/o needing to use -a flag.
files="vimrc"

echo "Creating $olddir for backup of any existing dotfiles in \$HOME"
mkdir -p $olddir

echo "Moving any existing dotfiles from ~ to $olddir"
for file in $files; do
    if [ -e ~/.$file ]; then
        mv ~/.$file $olddir/.
    fi
done

for file in $files; do
    echo "Creating a symlink to $file in \$HOME"
    ln -s $dir/$file ~/.$file
done
