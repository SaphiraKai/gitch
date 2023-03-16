#!/bin/bash
# Git Clone Helper

set -euo pipefail
export IFS=$'\n'

url_exists() {
    curl --head --fail --silent "$1" &>/dev/null
}

skip=false
sites=('')
orgs=('')

[ "${1:-}" = '-s' ] || [ "${1:-}" = '--skip-clone' ] && skip=true && shift

[ "${1:-}" != '' ] && repo="$1" || {
    echo 'error: please provide at least a repo name'
    exit 1
}

[ "${2:-}" != '' ] && {
    orgs=("$1")
    repo="$2"
}

[ "${3:-}" != '' ] && {
    sites=("$1")
    orgs=("$2")
    repo="$3"
}

[ -z "${orgs[@]}" ] && {
    [ -s $HOME/.config/gitch/orgs ] && orgs=($(cat $HOME/.config/gitch/orgs)) || {
        echo 'unable to determine org to use'
        exit 255
    }
}

[ -z "${sites[@]}" ] && [ -s $HOME/.config/gitch/sites ] && sites=($(cat $HOME/.config/gitch/sites)) || sites=("github.com")

url=''
[ "${#sites[@]}" = 1 ] && [ "${#orgs[@]}" = 1 ] && url="https://$sites/$orgs/$repo"

[ -z "$url" ] && {
    for site in ${sites[@]}; do
        for org in ${orgs[@]}; do
            url_exists "https://$site/$org/$repo" && {
                url="https://$site/$org/$repo"
                break 2
            }
        done
    done
}

[ "$url" != '' ] && {
    $skip && {
        url_exists "$url" || {
            echo 'error: only possible url is invalid'
            exit 127
        }
    }

    echo "$url"
    $skip || git clone "$url"
} || {
    echo 'error: unable to find repo under any site/org combination'
    exit 127
}
