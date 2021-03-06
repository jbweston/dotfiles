# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# notify, useful for long-running commands
alias notify='tput bel'
alias tiga='tig --all'
alias tigs='tig status'
alias ledger='ledger -f /home/jbw/priv/finance/accounts/main.ldg --start-of-week=6 --sort date' #--historical --exchange €'
alias hledger='hledger -f ~/priv/finance/accounts/main.ldg'
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

gpg-unknown-keys() {
    gpg --list-sigs | grep 'not found' | tr -s ' ' | rev | cut -d' ' -f6 | rev
}

alias t='topydo -t ~/priv/admin/todo/todo.txt -d ~/priv/admin/todo/done.txt'
alias tc='t columns -l .config/todo.cfg'
