#!/bin/sh

usage() {
    printf "Usage: %s <search term>\n" "${0}" >&2
    exit 1
}

# check: no args
[ -z "$*" ] && usage

query=$(printf '%s' "$*" | tr ' ' '+')
movie=$(curl -s "https://1337x.to/search/${query}/1/" | grep -Eo "torrent/[0-9]{7}/[a-zA-Z0-9?%-]*/" | head -n 1)
magnet=$(curl -s "https://1337x.to/${movie}" | grep -Po "magnet:\?xt=urn:btih:[a-zA-Z0-9]*" | head -n 1)

peerflix -l -k "${magnet}"
