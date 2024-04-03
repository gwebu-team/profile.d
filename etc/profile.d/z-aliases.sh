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
if ip -V | grep '^ip utility, iproute2-.*, libbpf' &>/dev/null; then
    # EL 8+ - "ip utility, iproute2-6.2.0, libbpf 0.5.0"
    alias ip='ip --color=auto'
else
    # EL 7 - "ip utility, iproute2-ss170501"
    alias ip='ip -c'
fi
