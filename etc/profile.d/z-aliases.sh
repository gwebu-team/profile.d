if [ "${BASH_SOURCE-}" = "$0" ]; then
    echo -e "You must source this script:\n\tsource $0" >&2
    exit 33
fi

# show hidden files and directories
alias l.='ls -d .[^.]* ..?* --color=tty 2>/dev/null'

# long format with ISO dates
alias lll='ls -Al "--time-style=+%Y-%m-%d %H:%M:%S %4Z"'

# color less (restricted)
alias less='less -R'

# color ip route
alias ip='ip --color=auto'
