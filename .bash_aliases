export LS_OPTIONS="--color"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lhrt'
alias mv='mv -v -b'
alias cp='cp -v -b'
backup() {
  cp -v -b "$1" "$1~"
}
alias mktexclean='find \( -name "*.aux" -o -name "*.log" -o -name "*.blg" -o -name "*.bak" -name "*.idx" -o -name "*.out" -o -name "*.idx" -o -name "*.backup" -o -name "*~" \) -exec rm -r {} \;'
alias w3m='w3m -F'
alias xtightvncviewer='xtightvncviewer -compresslevel 9'


# Some useful scripts to put in your ~/.bashrc in case you are using bash (assuming OT_PREFIX is '~/opentox-ruby'):
# USE ONLY IF YOUR NGINX PORT IS >1024 (NOT PRIVILEGED)

# Load server config
otconfig() {
  source $HOME/.opentox-ui.sh
}

# Update the version
otupdate() {
  START_DIR=`pwd`
  otconfig
  cd $HOME/opentox-ruby/www/opentox
  for d in `find -not -name "." -type d -maxdepth 1 2>/dev/null`; do echo ; echo $d ; cd $d ; MYBRANCH=`git branch | grep "*" | sed 's/.*\ //g'`; git pull origin $MYBRANCH ; cd - ;  done
  cd  $HOME/opentox-ruby/www/opentox/algorithm/libfminer
  mv libbbrc/Makefile libbbrc/Makefile~
  mv liblast/Makefile liblast/Makefile~
  if ! git pull; then
    echo "Error! Pull for Fminer failed."
    return 1
  fi
  mv libbbrc/Makefile~ libbbrc/Makefile
  mv liblast/Makefile~ liblast/Makefile
  make -C libbbrc/ clean
  make -C libbbrc/ ruby
  make -C liblast/ clean
  make -C liblast/ ruby
  cd -
  cd $HOME/opentox-ruby/www/opentox/algorithm/last-utils
  if ! git pull; then
    echo "Error! Pull for Last-Utils failed."
    return 1
  fi
  cd -
  cd opentox-ruby
  LINK_DIR=`gem which opentox-ruby | sed 's/\/opentox-ruby.rb//'`
  if [ -h $LINK_DIR ]; then 
    rm -f $LINK_DIR
  fi
  rake install
  if ! [ -h $LINK_DIR ]; then
    echo "Warning! Your lib $LINK_DIR is no symlink. Linking back for you..."
    rm -rf "$LINK_DIR~"
    mv "$LINK_DIR" "$LINK_DIR~"
    ln -sf $HOME/opentox-ruby/www/opentox/opentox-ruby/lib `echo ${LINK_DIR::${#LINK_DIR}-3}`
  fi
  echo "Please execute 'otstart' to restart."
  cd "$START_DIR"
}

# Start the server
otstart() {
  otconfig
  otkill
  bash -c "nohup redis-server $HOME/opentox-ruby/redis-2.2.2/redis.conf >/dev/null 2>&1 &"
  bash -c "nohup nginx -c $HOME/opentox-ruby/nginx/conf/nginx.conf >/dev/null 2>&1 &"
  sleep 2
  if ! pgrep -u $USER nginx>/dev/null 2>&1; then echo "Failed to start nginx."; fi
  if ! pgrep -u $USER redis-server>/dev/null 2>&1; then echo "Failed to start redis."; fi
}

# Display log
alias otless='less $HOME/.opentox/log/production.log'

# Tail log
alias ottail='tail -f $HOME/.opentox/log/production.log'

# Reload the server
otreload() {
  otconfig
  bash -c "nginx -s reload"
}

# Kill the server
otkill() {
  otconfig
  killall nginx >/dev/null 2>&1
  bash -c "redis-cli -p $OHM_PORT shutdown >/dev/null 2>&1"
  while ps x | grep PassengerWatchdog | grep -v grep >/dev/null 2>&1; do sleep 1; done
  while ps x | grep Rack | grep -v grep >/dev/null 2>&1; do sleep 1; done
  for p in `pgrep -u $USER R 2>/dev/null`; do kill -9 $p; done
}

