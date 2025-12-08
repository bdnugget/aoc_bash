#!/usr/bin/env bash
set -Eeuo pipefail
trap 'echo "SHIEEEET at line $LINENO" >&2' ERR

main() {
    local line
    line=$(< example.txt)

    IFS=',' read -ra ranges <<< "$line"

    for r in "${ranges[@]}"; do
        IFS='-' read -r start end <<< "$r"

        for ((i=start; i<=end; i++)); do
            echo "$i"
        done
    done
}

main "$@"
