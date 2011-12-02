export LS_OPTIONS="--color"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lhrt'
alias mv='mv -v -b'
alias cp='cp -v -b'
backup() {
  cp -v -b "$1" "$1~"
}
function git_diff() {
  git diff --no-ext-diff -w "$@" | vim -R -
}

