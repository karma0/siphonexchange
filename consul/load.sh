#!/bin/bash

[ "${#}" -ge 1 ] && echo "Entering files into consul: ${@}" || {
  echo "Please specify file(s) to load: ${0} <file1> [<file2>...]"
  exit 1
}

for file in "${@}"; do
  cat $file | while read line; do
    consul kv put "$(echo $line|cut -d'|' -f1)" "$(echo $line|cut -d'|' -f2)"
  done
done

exit 0
