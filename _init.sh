#!/bin/bash
#

# Copies some non-existing or non-differing files to $HOME
# for differing files, vimdiff is invoked
function cp_files {
  filelist="$1"
  for f in $filelist; do
    if [ -f "$HOME/$f" ] && ! cmp "$f" "$HOME/$f" >/dev/null 2>&1; then
      read -p "File  $HOME/$f exists. Vimdiff (<y>es, compare files; <N>o, skip file; <o>verwrite file)? " yno 
      case $yno in 
        [Yy]*) 
          cp -v --backup=numbered "$HOME/$f" "$HOME/$f~" && vimdiff "$f" "$HOME/$f";;
        [Oo]*) 
          cp -v --parents $f "$HOME"
      esac
    else
      cp -v --parents $f "$HOME"
    fi
  done
}


# Main shell tools
echo
read -p "Main shell tools. Install (<y>es, <N>o)? " yn
mkdir -p ~/.config/terminator 2>/dev/null
mkdir -p ~/.vim/_backup 2>/dev/null
mkdir -p ~/.vim/_undo 2>/dev/null
mkdir -p ~/.vim/_swap 2>/dev/null
mkdir -p ~/tmp 2>/dev/null
case $yn in [Yy]* )
  cp .gitconfig_cfg .gitconfig
  sed -i "s,REPO_DIR,`pwd`,g" .gitconfig
  cp_files ".bash_profile .bashrc .bash_aliases .vimrc .gvimrc .irbrc .gitconfig .screenrc .htoprc .lessfilter .config/terminator/config .Rprofile .subversion/config .Xmodmap"
esac


# Vim bundle
echo
read -p "Vim plugins. Install (<y>es, <N>o)?" yn
git submodule init
git submodule update
mkdir -p ~/.vim 2>/dev/null
case $yn in [Yy]* )
  cmd="rsync -av --delete bundle ~/.vim"
  cmd2="rsync -av autoload ~/.vim"
  read -p "WARNING: Really delete existing plugins (<y>es, <N>o)?" yn
  case $yn in
    [Yy]*)
      eval "$cmd"; eval "$cmd2" ;;
    *)
      printf "Use '%s' to manually sync" "$cmd"
      echo
      echo "Add '-n' to do dry run";;
  esac
esac

