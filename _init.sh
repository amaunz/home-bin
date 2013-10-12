#!/bin/bash
#

# Copies some non-existing or non-differing files to $HOME
# for differing files, vimdiff is invoked
function cp_files {
  filelist="$1"
  for f in $filelist; do
    if [ -f "$HOME/$f" ] && ! cmp "$f" "$HOME/$f" >/dev/null 2>&1; then
      read -p "File  $HOME/$f exists. Vimdiff (y/N)? " yn && case $yn in [Yy]* ) (cp -v --backup=numbered "$HOME/$f" "$HOME/$f~" && vimdiff "$f" "$HOME/$f") ; esac
    else
      cp -v --parents $f "$HOME"
    fi
  done
}


# Main shell tools
echo
read -p "Main shell tools. Install (y/N)? " yn
mkdir -p ~/.config/terminator 2>/dev/null
case $yn in [Yy]* )
  cp .gitconfig_cfg .gitconfig
  sed -i "s,REPO_DIR,`pwd`,g" .gitconfig
  cp_files ".bash_profile .bashrc .bash_aliases .vimrc .gvimrc .irbrc .gitconfig .screenrc .htoprc .lessfilter .config/terminator/config .Rprofile"
esac

# Vim bundle
echo
read -p "Vim plugins. Install (y/N)?" yn
git submodule init
git submodule update
mkdir -p ~/.vim 2>/dev/null
case $yn in [Yy]* )
  cmd="rsync -av --delete bundle ~/.vim"
  cmd2="rsync -av autoload ~/.vim"
  read -p "WARNING: Really delete existing plugins (y/N)?" yn
  case $yn in
    [Yy]*)
      eval "$cmd"; eval "$cmd2" ;;
    *)
      printf "Use '%s' to manually sync" "$cmd"
      echo
      echo "Add '-n' to do dry run";;
  esac
esac

# Conky (graphical system monitor for the desktop)
echo
read -p "Conky (graphical system monitor for the desktop). Install (y/N)? " yn
case $yn in [Yy]* )
  cp_files ".conkyrc"
  mkdir $HOME/.conky 2>/dev/null
  cp_files "`/bin/ls .conky/*`"
  echo "IMPORTANT: Install packages conky, lm-sensors, hddtemp. Then set hddtemp uid root:"
  echo "IMPORTANT:  sudo aptitude install conky lm-sensors hddtemp"
  echo "IMPORTANT:  sudo chmod u+s /usr/sbin/hddtemp"
  echo "IMPORTANT: Add a startup link to your Desktop manager:"
  echo "IMPORTANT:  sh -c \"sleep 10; exec conky -c ~/.conkyrc\""
  echo "IMPORTANT: Thank you for your attention."
esac

