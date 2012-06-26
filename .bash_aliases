# harden mv and cp against data loss
alias mv='mv -v --backup=numbered'
alias cp='cp -v --backup=numbered'

# pager implemented by vim
alias lessv='vim -u /usr/share/vim/vimcurrent/macros/less.vim'

# ls with color support
alias ls='ls --color=auto'
alias l='ls --color=auto -lhrt'
alias lc='ls --color=always -lhrt'

# grep with color support
alias grep='grep --color=auto'
alias grepc='grep --color=always'

# convenient backup of files. Additioally use -T for directories.
backup_file() {
  cp -v --backup=numbered "$1" "$1~"
}

# git diff wrapper
function git_diff() {
  git diff --no-ext-diff -w "$@" | vim -R -
}

# Clean up a Latex source directory (current directory)
mktexclean {
  find -maxdepth 1 -type f -name "*.toc" -or -name "*.out" -or -name "*.log" -or -name "*.aux" -or -name "*.bbl" -or -name "*.blg" | while read f; do mv $f /tmp; done
}

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
 
