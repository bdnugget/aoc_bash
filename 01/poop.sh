#!/bin/env bash
set -Eeuo pipefail

trap 'echo "SHIEEEET at line ${LINENO}" >&2' ERR

# Advent of Code day 01

main() {
  dial=50
  count=0

  while read -r line; do
      dir="${line:0:1}"
      num="${line:1}"

      # apply rotation
      if [[ "$dir" == L ]]; then
          dial=$(( dial - num ))
      else
          dial=$(( dial + num ))
      fi

      # wrap into 0–99
      dial=$(( (dial % 100 + 100) % 100 ))

      # count zero hits
      if (( dial == 0 )); then
          ((count++))
      fi
  done < example.txt

  printf "%d\n" "$count"
}

main "$@"
