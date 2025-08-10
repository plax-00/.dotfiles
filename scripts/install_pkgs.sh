#!/usr/bin/env bash

_mktemp () {
    mktemp -t "install_pkgs.tmp.XXXXXXXXXX"
}

pkgs="$(_mktemp)"
conflicting="$(_mktemp)"
non_conflicting="$(_mktemp)"
trap "rm -f $pkgs $conflicting $non_conflicting" EXIT

sed '/^\s*#.*/d' ~/.dotfiles/pkglist.txt | sort > "$pkgs"
comm -12 "$pkgs" <(paru -Qi | grep Conflicts | cut -d ' ' -f 5 | sed '/^None$/d' | sort) > "$conflicting"
comm -23 "$pkgs" "$conflicting" > "$non_conflicting"

paru --noconfirm --needed -S - < "$non_conflicting"
