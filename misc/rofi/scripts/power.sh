#!/usr/bin/env bash

set_opt() {
    echo -en "\0$1\x1f$2\n"
}

set_opt keep-selection

suspend="   Suspend"
logout=" 󰍃  Logout"
reboot="   Reboot"
shutdown="   Shutdown"

list() {
    echo "$suspend"
    echo "$logout"
    echo "$reboot"
    echo "$shutdown"
}

case "$1" in
    "") list ;;
    "$suspend") systemctl suspend ;;
    "$logout") uwsm stop ;;
    "$reboot") systemctl reboot ;;
    "$shutdown") systemctl poweroff --now ;;
    *) exit 0 ;;
esac
