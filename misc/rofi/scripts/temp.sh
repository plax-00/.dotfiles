#!/usr/bin/env bash

set -e

[[ -n "$1" ]] || exit 0

raw_temp="${1:0:-1}"

case "${1: -1}" in
    "C"|"c")
        out_unit="°F"
        tempC="${raw_temp//[[:space:]]/}"
        out="$(bc <<< "scale = 2; $tempC * 1.8 + 32")"
    ;;
    "F"|"f")
        out_unit="°C"
        tempF="${raw_temp//[[:space:]]/}"
        out="$(bc <<< "scale = 2; ($tempF - 32) / 1.8")"
    ;;
    *) exit 0 ;;
esac

notify-send -e -t 2000 -- "$out $out_unit"
