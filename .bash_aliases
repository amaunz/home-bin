export LS_OPTIONS="--color"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lhrt'
alias mv='mv -v --backup=numbered'
alias cp='cp -v --backup=numbered'
alias vless='vim -u /usr/share/vim/vimcurrent/macros/less.vim'
backup_file() {
  cp -v --backup=numbered "$1" "$1~"
}
function git_diff() {
  git diff --no-ext-diff -w "$@" | vim -R -
}

alias mktexclean='find -maxdepth 1 -type f -not -name "*tex" -and -not -name "*bib" -and -not -name "*eps" -exec mv {} /tmp \;'

# Colorize man pages
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}
 
