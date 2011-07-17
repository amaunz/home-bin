. $HOME/.bash_hosts >/dev/null 2>&1
. $HOME/.bash_ot  >/dev/null 2>&1

alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lhrt'
alias mv='mv -v'
alias cp='cp -v'
alias mktexclean='find \( -name "*.aux" -o -name "*.log" -o -name "*.blg" -o -name "*.bak" -name "*.idx" -o -name "*.out" -o -name "*.idx" -o -name "*.backup" -o -name "*~" \) -exec rm -r {} \;'
alias w3m='w3m -F'
alias xtightvncviewer='xtightvncviewer -compresslevel 9'
