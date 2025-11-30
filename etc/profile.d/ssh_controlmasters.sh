if [ "${BASH_SOURCE-}" = "$0" ]; then
    echo -e "You must source this script:\n\tsource $0" >&2
    exit 33
fi

# SSH Control Masters tools (setup controlmasters to be in ~/.ssh/c).
alias ssh_controlmasters_ls='(cd ~/.ssh/c; ls -A 2>/dev/null || echo "-- No control masters --")'
# shellcheck disable=SC2154
alias ssh_controlmasters_check='(cd ~/.ssh/c; [ "$(ls -A)" ] && for i in *; do echo -n "$i: "; ssh -O check "${i%:*}" -p "${i##*:}"; done)'
# shellcheck disable=SC2154
alias ssh_controlmasters_stop='(cd ~/.ssh/c; [ "$(ls -A)" ] && for i in *; do echo -n "$i: "; ssh -O stop "${i%:*}" -p "${i##*:}"; done)'
