if [ "${BASH_SOURCE-}" = "$0" ]; then
    echo -e "You must source this script:\n\tsource $0" >&2
    exit 33
fi

EDITOR=mcedit
export EDITOR

HISTSIZE=20480
export HISTSIZE

if [ -x /usr/bin/fzf ]; then
    FZF_DEFAULT_OPTS="--history-size=$HISTSIZE"
    export FZF_DEFAULT_OPTS
fi
