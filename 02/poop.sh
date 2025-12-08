#!/usr/bin/env bash
set -Eeuo pipefail
trap 'echo "SHIEEEET at line $LINENO" >&2' ERR

main() {
    local line
    local sum=0
    # line=$(< example.txt)
    line=$(< input.txt)

    IFS=',' read -ra ranges <<< "$line"

    for r in "${ranges[@]}"; do
        IFS='-' read -r start end <<< "$r"

        for ((i=start; i<=end; i++)); do
            if (( ${#i} % 2 == 0 )); then
                left="${i:0:${#i}/2}"
                right="${i:${#i}/2}"

                if [[ "$left" == "$right" ]]; then
                    echo "Match: $i"
                    ((sum+=$i))
                fi
            fi
        done
    done
    
    echo "Sum: $sum"
}

main "$@"
