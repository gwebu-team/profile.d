if [ "${BASH_SOURCE-}" = "$0" ]; then
    echo -e "You must source this script:\n\tsource $0" >&2
    exit 33
fi

TIME_STYLE=long-iso
export TIME_STYLE
