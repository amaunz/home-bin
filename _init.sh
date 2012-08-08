#!/bin/bash
#
# Copies some non-existing or non-differing dotfiles to $HOME
# for differing files, vimdiff is invoked
# @example { 
#   ./_init.sh
# }

cp .gitconfig_cfg .gitconfig 
sed -i "s,REPO_DIR,`pwd`,g" .gitconfig

for f in .bashrc .bash_aliases .vimrc .gvimrc .irbrc .gitconfig .screenrc .htoprc .lessfilter; do 
  if [ -f "$HOME/$f" ] && ! cmp "$f" "$HOME/$f" >/dev/null 2>1; then
    read -p "File  $HOME/$f exists. Vimdiff (y/N)? " yn && case $yn in [Yy]* ) (cp -v --backup=numbered "$HOME/$f" "$HOME/$f~" && vimdiff "$f" "$HOME/$f") ; esac
  else
    cp -v $f "$HOME"
  fi
done

