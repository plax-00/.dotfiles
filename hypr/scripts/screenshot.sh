#!/usr/bin/env bash

set -e
trap 'cleanup' EXIT

full=$(mktemp -t screenshot.XXXXXX)
thumb=$(mktemp -t screenshot.XXXXXX)

cleanup() {
    rm -rf "$full" "$thumb"
    if [[ ! $(pidof slurp) ]]; then
        pkill hyprpicker || true
    fi
}

select_region() {
    hyprpicker -rz &
    hyprctl keyword layerrule "noanim,selection"
    hyprctl keyword layerrule "order -1,selection"

    grim -g "$(slurp)" "$full"
    pkill hyprpicker || true
}


if [[ "$1" = "select" ]]; then
    select_region
else
    grim "$full"
fi

wl-copy < "$full"
magick "$full" -thumbnail '400x400>' "$thumb"

action=$(notify-send -t 5000 -A Edit -A Save -i $thumb "Screenshot taken" "Copied to clipboard")
case "$action" in
    0) swappy -f "$full"
    ;;
    1) cp "$full" "$HOME/Pictures/Screenshots/$(date '+%Y%m%d-%H%M%S')-screenshot.png"
    ;;
    *)
    ;;
esac
