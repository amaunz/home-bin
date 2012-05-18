#!/bin/bash
# Copies bash, git, vim and irb init files to $HOME
# WARNING: Backups will be made, but of course user-defined settings in the files get lost.

cp -v --backup=numbered .gitconfig_cfg .gitconfig 
sed -i "s,REPO_DIR,`pwd`,g" .gitconfig
cp -v --backup=numbered .bashrc .bash_aliases .vimrc .irbrc .gitconfig "$HOME"
cp -v lessfilter "$HOME/.lessfilter"
