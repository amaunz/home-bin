#!/bin/bash
# Copies bash, vim and irb init files to $HOME

cp -v --backup=numbered .bashrc .bash_aliases .vimrc .irbrc "$HOME"
