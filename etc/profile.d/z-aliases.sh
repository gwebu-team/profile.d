if [ "${BASH_SOURCE-}" = "$0" ]; then
    echo -e "You must source this script:\n\tsource $0" >&2
    exit 33
fi

# show hidden files and directories
alias l.='ls -d .[^.]* ..?* --color=tty 2>/dev/null'

if ! which ll >/dev/null 2>&1; then
    alias ll='ls -l --color=auto'
fi

# color less (restricted)
alias less='less -R'

if [[ "$OSTYPE" != darwin* ]]; then
    # long format with ISO dates
    alias lll='ls --color=auto -Al "--time-style=+%Y-%m-%d %H:%M:%S GMT%z"'

    # if there is iproute installed
    if command -v ip > /dev/null; then
        # color ip route
        if ip -V | grep '^ip utility, iproute2-.*, libbpf' &>/dev/null; then
            # EL 8+ - "ip utility, iproute2-6.2.0, libbpf 0.5.0"
            alias ip='ip --color=auto'
        else
            # EL 7 - "ip utility, iproute2-ss170501"
            alias ip='ip -c'
        fi
    fi
else
    # MacOS aliases
    alias ll='ls --color=auto -l'
    alias lll='ls --color=auto -Al -D "%Y-%m-%d %H:%M:%S GMT%z"'
fi
