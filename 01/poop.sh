#!/usr/bin/env bash
set -Eeuo pipefail

trap 'printf "SHIEEEET at line %d: %s\n" "$LINENO" "$BASH_COMMAND" >&2' ERR

# Advent of Code day 01

main() {
  local dial=50
  local count_exact_zero=0
  local count_passed_zero=0
  local prev dir num line crossings

  while IFS= read -r line; do
      prev=$dial
      dir="${line:0:1}"
      num="${line:1}"

      # apply rotation and count zero crossings before modulo wrap
      if [[ "$dir" == L ]]; then
        if (( prev == 0 )); then
          crossings=$(( num / 100 ))
        else
          crossings=$(( (num - prev + 100) / 100 ))
        fi
        dial=$(( dial - num ))
      else
        crossings=$(( (prev + num) / 100 ))
        dial=$(( dial + num ))
      fi

      # wrap into 0–99
      dial=$(( (dial % 100 + 100) % 100 ))

      # count zero hits (for part 1)
      if (( dial == 0 )); then
        count_exact_zero=$(( count_exact_zero + 1 ))
      fi

      # count how many times we passed 0 (for part 2)
      count_passed_zero=$(( count_passed_zero + crossings ))

  #done < example.txt
  done < input.txt

  printf "P1 Exact zero: %d\nP2 Dial passed zero: %d\n" "$count_exact_zero" "$count_passed_zero"
}

main "$@"
