EDITOR=mcedit
export EDITOR

HISTSIZE=20480
export HISTSIZE

if [ -x /usr/bin/fzf ]; then
    FZF_DEFAULT_OPTS="--history-size=$HISTSIZE"
    export FZF_DEFAULT_OPTS
fi
