#!/bin/sh

usage() {
	printf "Usage: %s <SEARCH TERM>\n" "${0}" >&2
	exit 1
}

# check: no args
[ -z "${*}" ] && usage

url='https://1337x.to'
curl_cmd='curl --proto '=https' --tlsv1.2 -SLfs'

query=$(printf '%s' "${*}" | tr ' ' '+')
movie=$(${curl_cmd} "${url}/search/${query}/1/" | grep -Eo "torrent/[0-9]{7}/[a-zA-Z0-9?%-]*/" | fzf --algo=v2 --cycle -i)
magnet=$(${curl_cmd} "${url}/${movie}" | grep -Eo "magnet:\?xt=urn:btih:[a-zA-Z0-9]*" | head -n 1)

peerflix -l -k "${magnet}"
