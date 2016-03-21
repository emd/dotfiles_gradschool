#!/bin/bash

##############################################################
# This script creates symlinks from dotfiles in $HOME/dotfiles
# to $HOME. It also symlinks relevant vim-latex setting files
# to the appropriate subdirectories of vim-latex package.
##############################################################

# dotfiles directory
dir=~/dotfiles

# old dotfiles backup directory
olddir=~/dotfiles_old

# list of dot files/folders to symlink to $HOME
# NOTE: Dots are *suppressed* and are manually prepended
# in the linking commands below. This allows us to easily
# list contents of dotfiles w/o needing to use -a flag.
files="bashrc bash_profile vimrc cshrc login"

echo "Creating $olddir for backup of any existing dotfiles in \$HOME"
mkdir -p $olddir

for file in $files; do
    # If on a NERSC system, user dotfiles must have a `.ext` appended.
    if [ -e /usr/common/usg/bin/nersc_host ]; then
        if [ $file == "bashrc" ] || [ $file == "bash_profile" ]; then
            # Move existing dotfile to $olddir
            if [ -e ~/.$file.ext ]; then
                echo "Moving .$file.ext from \$HOME to $olddir"
                mv ~/.$file.ext $olddir/.
            fi

            # Create symlink to new dotfile
            echo "Creating a symlink to $file in \$HOME"
            ln -s $dir/$file ~/.$file.ext
        else
            # Move existing dotfile to $olddir
            if [ -e ~/.$file ]; then
                echo "Moving .$file from \$HOME to $olddir"
                mv ~/.$file $olddir/.
            fi

            # Create symlink to new dotfile
            echo "Creating a symlink to $file in \$HOME"
            ln -s $dir/$file ~/.$file
        fi

    # Handles dotfiles for all other systems
    else
        # Move existing dotfile to $olddir
        if [ -e ~/.$file ]; then
            echo "Moving .$file from \$HOME to $olddir"
            mv ~/.$file $olddir/.
        fi

        # Create symlink to new dotfile
        echo "Creating a symlink to $file in \$HOME"
        ln -s $dir/$file ~/.$file
    fi
done


# Also, symlink files for matplotlibrc settings
if [ -n "$MATPLOTLIBRC" ]; then
    file=matplotlibrc

    # Move existing dotfile to $olddir
    if [ -e $MATPLOTLIBRC/$file ]; then
        echo "Moving $file from \$MATPLOTLIBRC to $olddir"
        mv $MATPLOTLIBRC/$file $olddir/.
    fi

    # Create symlink to new dotfile
    echo "Creating a symlink to $file in \$MATPLOTLIBRC"
    ln -s $dir/$file $MATPLOTLIBRC/$file
fi


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
