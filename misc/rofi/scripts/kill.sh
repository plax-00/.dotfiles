#!/usr/bin/env bash

set_opt() {
    echo -en "\0$1\x1f$2\n"
}

set_opt prompt kill

if [[ -z "$1" ]]; then
    ps -e -o pid,cmd --no-headers --sort=-%mem | grep -v '\d* \[.*\]'
else
    pid="$(echo "$1" | sed -e 's/^\s*//' | cut -d ' ' -f 1)"
    [[ -n "$pid" ]] && (kill "$pid" || notify-send "kill $pid failed" -t 5000)
fi
