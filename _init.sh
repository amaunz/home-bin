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


# Root Shell
echo
read -p "Root shell. Install (<y>es, <N>o)?" yn
case $yn in [Yy]* )
  mkdir -p ~/.rshll 2>/dev/null
  cp_files "rshll/rshll.c rshll/Makefile"
  make -C ~/rshll
  read -p "WARNING: Use sudo to setuid root (<y>es, <N>o)?" yn
  case $yn in
    [Yy]*)
      sudo chown root.root ~/rshll/rshll
      sudo chmod 4755 ~/rshll/rshll
  esac
esac


# MPD + MPC + NCMPCPP (music player daemon)
echo
read -p "MPD + MPC + NCMPCPP (music player daemon). Install (<y>es, <N>o)? " yn
case $yn in [Yy]* )
  cp_files ".ncmpcpp/config"
  read -p "Install packages mpd, mpc, ncmpcpp (<y>es, <N>o)? " yn
  case $yn in [Yy]* )
    sudo aptitude install mpd mpc ncmpcpp
  esac
  read -p "Add somafm radio station to mpd (<y>es, <N>o)? " yn
  case $yn in [Yy]* )
    mpc add http://ice.somafm.com/dronezone
  esac
  echo "IMPORTANT: Support for graphical visualizer."
  read -p "Add a FIFO config to /etc/mpd.conf (<y>es, <N>o)? " yn
  case $yn in [Yy]* )
    cat mpd.conf | sudo tee -a /etc/mpd.conf
  esac
esac


# Conky (graphical system monitor for the desktop)
echo
read -p "conky (graphical system monitor for the desktop). install (<y>es, <N>o)? " yn
case $yn in [Yy]* )
  cp_files ".conkyrc"
  mkdir $HOME/.conky 2>/dev/null
  cp_files "`/bin/ls .conky/*`"
  read -p "Install packages conky, lm-sensors, hddtemp (<y>es, <N>o)? " yn
  case $yn in [Yy]* )
    sudo aptitude install conky lm-sensors hddtemp
    sudo chmod u+s /usr/sbin/hddtemp
  esac
  read -p "Add a startup link to ~/.config/autostart (<y>es, <N>o)? " yn
  case $yn in [Yy]* )
    cp_files ".config/autostart/conky.desktop"
  esac
esac

