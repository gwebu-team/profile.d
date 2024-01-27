#!/bin/bash

# DESCRIPTION
# ===========
# An attempt to seize industrial… ops, I ment an attempt to make my
# bash prompt nicer and save all my bash history ordered by date with
# exit codes for later review… Commands starting with space are not saved
# because mc floods the logs otherwise.

# LICENSE:
#   Released under GNU GPL v 2+. You should've received it with your GNU/Linux
#   system. You can visit https://opensource.org/license/gpl-2-0/ or
#   alternatively write to the Free Software Foundation, Inc.,
#   59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

# z-ps-twtty-7.sh - Nice bash prompt and history archiver
#   by Doncho Gunchev <dgunchev@gmail.com>, 2024-01-27 15:58 EET
#   Show PIPESTATUS instead of just $?. Cleanup.
#   Detect if BASH_COMMAND is an array (bash 5.1 NEWS) or just a string.
#   Mark 'login' and 'logout's properly.
#   I have 15+ years of bash history now, since 2009…
#
# ps-twtty-7.sh - Nice bash prompt and history archiver
#   by Doncho Gunchev <dgunchev@gmail.com>, 2020-10-11 14:46 EET
#   Integrate better with vte.sh, just name this in a way to sort after it.
#   See https://bugzilla.redhat.com/show_bug.cgi?id=1183192

# ps-twtty-7.sh - Nice bash prompt and history archiver
#   by Doncho Gunchev <dgunchev@gmail.com>, 2015-08-03 13:00 EET
#   Change the root prompt colors

# ps-twtty-7.sh - Nice bash prompt and history archiver
#   by Doncho N. Gunchev <dgunchev@gmail.com>, 2011-11-10 12:12 EET
#   fixed some variable quoting

# ps-twtty-7.sh - Nice bash prompt and history archiver
#   by Doncho N. Gunchev <dgunchev@gmail.com>, 2008-09-30 07:00 EEST

# BASED ON
# termwide prompt with tty number by Giles, 1998-11-02
#   - https://tldp.org/HOWTO/Bash-Prompt-HOWTO/x869.html
# and
# .bashrc_history.sh by Yaroslav Halchenko, 2005-03-10
#   - http://www.onerussian.com/Linux/bash_history.phtml
#   - https://debian-administration.org/article/175/BASH_history_forever.

if [ "$PS1" ] ; then # interactive shell detection

# Log the logout event.
function prompt_command_exit() {
    trap - EXIT
    local now=$(date --rfc-3339=ns)
    local HistFile
    HistFile="$HOME/bash_history/$(date '+%Y-%m/%Y-%m-%d')"
    mkdir -p "${HistFile%/*}"
    echo -e "# Logout,$USER@${HOSTNAME}:$PWD,$(tty),${SSH_CLIENT:-local},login=${my_LoginTime:-$now},now=$now\nlogout" >> "$HistFile"
}

# Executed before each prompt. Fill the variables needed by PS1 here.
function prompt_command() {
    local now=$(date --rfc-3339=ns)

    # Manage the history
    local HistFile="$HOME/bash_history/$(date '+%Y-%m/%Y-%m-%d')"
    mkdir -p "${HistFile%/*}"

    if [ -z "$my_LoginTime" ]; then
        my_LoginTime="$now"
    fi

    # Calculate the width of the prompt:
    my_TTY="$(tty)"
    my_TTY="${my_TTY:5}" # cut the '/dev' part -> tty/1, pts/2...
    my_PWD="${PWD}"
    # Add all the accessories below ...
    my_D="$(date '+%Y-%m-%d %H:%M:%S')"
    # This is for string size calculations only.
    local prompt="--($my_D, Err ${my_P[*]}, $my_TTY)---($PWD)--"
    local fill_size=0
    [ -z "${COLUMNS}" ] && COLUMNS=$(tput cols)
    ((fill_size=COLUMNS-${#prompt}))
    my_FILL=""
    if [ "$fill_size" -gt 0 ]; then
        my_FILL="────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────"
        while [ "$fill_size" -gt ${#my_FILL} ]; do
            my_FILL="${my_FILL}${my_FILL}${my_FILL}${my_FILL}"
        done
        my_FILL="${my_FILL::$fill_size}"
    fi

    if [ "$fill_size" -lt 0 ]; then
        my_PWD="…${my_PWD:1-$fill_size}"
    fi

    local OldCmdNo="$CmdNo"  # See if we got new command later.
    local Cmd="$(history 1)"
    CmdNo="${Cmd:0:7}"
    if [[ -z "$OldCmdNo" ]]; then
        Cmd="login"
    else
        Cmd="${Cmd:7}"
    fi
    if [ "$OldCmdNo" != "$CmdNo" ]; then # Only save new commands, not empty lines or Ctrl+C.
        echo -e "# PIPESTATUS=${my_P[*]},$USER@${HOSTNAME}:$PWD,$(tty),${SSH_CLIENT:-local},login=$my_LoginTime,now=$now\n$Cmd" >> "$HistFile"
    fi
}

function twtty {
    # The special "\[" and "\]" are telling bash that the text enclosed will not move the caret.
    local GRAY='\[\033[1;30m\]'
    local LIGHT_GRAY='\[\033[0;37m\]'
    local WHITE='\[\033[1;37m\]'
    local NO_COLOUR='\[\033[0m\]'

    local LIGHT_BLUE='\[\033[1;34m\]'
    local YELLOW='\[\033[1;33m\]'

    local RED='\[\033[0;31m\]'
    local LIGHT_RED='\[\033[1;31m\]'

    local GREEN='\[\033[0;32m\]'
    local LIGHT_GREEN='\[\033[1;32m\]'

    if [ "${UID}" -ne '0' ]; then
        # Normal user colors
        local C1="${GREEN}"
        local C2="${LIGHT_GREEN}"
        local C3="${WHITE}"
    else
        # root user colors
        local C1="${LIGHT_RED}"
        local C2="${YELLOW}"
        local C3="${WHITE}"
    fi

    case "$TERM" in
        xterm*)
            TITLEBAR='\[\033]0;\u@\h:\w\007\]'
            ;;
        *)
            TITLEBAR=''
            ;;
    esac

    export PS1="$TITLEBAR\
${C1}┌${C2}─(\
${C1}\${my_D}${C2}, ${C1}Err ${C3}\${my_P[*]}${C2}, ${C3}\${my_TTY}\
${C2})─${C1}─\${my_FILL}${C2}─(\
${C1}\${my_PWD}\
${C2})─${C1}─\
${NO_COLOUR}\n\
${C1}└${C2}─(\
${C1}\${USER}${C2}@${C1}\${HOSTNAME%%.*}\
${C2})${C3}\$${NO_COLOUR} "

    export PS2="${C2}─${C1}─${C1}─${NO_COLOUR} \[\033[K\]"

    local P='my_P=("${PIPESTATUS[@]}");prompt_command'
    if declare -p PROMPT_COMMAND &>/dev/null; then
        local re='^declare -a '
        if [[ "$(declare -p PROMPT_COMMAND)" =~ $re ]]; then # Array, supported since bash 5.1
            PROMPT_COMMAND=("$P" "${PROMPT_COMMAND[@]}")
        else  # String
            PROMPT_COMMAND="$P;${PROMPT_COMMAND}"
        fi
    else
        PROMPT_COMMAND="$P"
    fi
    unset P

    trap prompt_command_exit EXIT
    shopt -s cmdhist histappend
    export HISTCONTROL='ignorespace'  # ':erasedups' would prevent logging duplicate commands.
    export HISTIGNORE='history:history *'
}

# Secure bash history
if [ ! -d "$HOME/bash_history" ]; then
    mkdir -m 0700 "$HOME/bash_history"
fi

# call and unset
twtty; unset twtty

fi
