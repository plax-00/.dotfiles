#!/usr/bin/env bash

set_opt() {
    echo -en "\0$1\x1f$2\n"
}
set_opt use-hot-keys true
set_opt keep-selection true
set_opt keep-filter true

set_sigterm() {
    set_opt prompt sigterm
    set_opt theme 'prompt { text-color: inherit; }'
    set_opt data SIGTERM
}

set_sigkill() {
    set_opt prompt sigkill
    set_opt theme 'prompt { text-color: red; }'
    set_opt data SIGKILL
}

proc_list() {
    LIBPROC_HIDE_KERNEL=1 ps -e -o pid,cmd --no-headers --sort=-%mem | sed "/$$/d"
}

case "$ROFI_RETV" in
    1)
        pid="$(sed -e 's/^\s*//' <<< "$1" | cut -d ' ' -f 1)"
        [[ -n "$pid" ]] \
            && (kill -s "$ROFI_DATA" "$pid" || notify-send "$ROFI_DATA $pid failed" -t 5000)
    ;;
    0|10)
        [[ "$ROFI_DATA" = "SIGTERM" ]] && set_sigkill || set_sigterm
        proc_list
    ;;
esac
