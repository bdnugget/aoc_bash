#!/usr/bin/env bash
set -Eeuo pipefail

trap 'printf "SHIEEEET at line %d: %s\n" "$LINENO" "$BASH_COMMAND" >&2' ERR

# Advent of Code day 01

main() {
  local dial=50
  local count_exact_zero=0
  local count_passed_zero=0
  local prev dir num line

  while IFS= read -r line; do
      prev=$dial
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

      # count zero hits (for part 1)
      if (( dial == 0 )); then
        ((count_exact_zero+=1))
      fi

      # check if we passed 0 (for part 2)
      if [[ "$dir" == L ]]; then
          # moving left: crossed 0 if new dial < prev
          if (( dial > prev )); then
              ((count_passed_zero+=1))
          fi
      else
      # moving right: crossed 0 if new dial < prev
          if (( dial < prev )); then
              ((count_passed_zero+=1))
          fi
      fi

  #done < example.txt
  done < input.txt

  printf "P1 Exact zero: %d\nP2 Dial passed zero: %d\n" "$count_exact_zero" "$count_passed_zero"
}

main "$@"
