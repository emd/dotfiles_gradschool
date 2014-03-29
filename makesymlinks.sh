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

# Also, symlink files for vim-latex settings
vim_latex=~/.vim/bundle/vim-latex


# vim-latex settings
#
# $files are contained in dotfiles directory and create vim-latex settings
# $file_dirs are the subdirectories of $vim_latex in which $files
# should be placed, e.g. if ${files[0]}=tex.vim and
# ${file_dirs[0]}=ftplugin then
#
#       ln -s $dir/$files[0] $vim_latex/${file_dirs[0]}/${files[0]}
#
# will link tex.vim to the appropriate location in vim-latex.

# files and file_dirs must have the *same* size
files=( "tex.vim" "tex_macros.vim" )
file_dirs=( "ftplugin" "after/ftplugin" )

for (( i=0; i<${#files[@]}; i++ )); do
    mkdir -p $vim_latex/${file_dirs[i]}
    file_path=$vim_latex/${file_dirs[i]}/${files[i]}

    if [ -e $file_path ]; then
        echo "Moving $file_path to $olddir"
        mv $file_path $olddir/.
    fi

    echo "Creating a symlink to ${files[i]} in $vim_latex/${file_dirs[i]}"
    ln -s $dir/${files[i]} $file_path
done
