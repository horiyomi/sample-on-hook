#!/usr/bin/env bash
out=$(python ../../main.py 2>&1)
exit_status=$?

out=$(echo "$out" | python -c 'import json,sys; print(json.dumps(sys.stdin.read()))')
out="${out%\"}"
out="${out#\"}"

if [ $exit_status -eq 1 ]; then
  echo "{\"id\": \"python-unit-test\", \"output\": \"${out}\", \"score\": -1}"
else
  echo "{\"id\": \"python-unit-test\", \"output\": \"${out}\", \"score\": 1}"
fi