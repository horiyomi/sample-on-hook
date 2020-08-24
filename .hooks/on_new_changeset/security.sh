#!/usr/bin/env bash

cmd_name="bandit"
if ! type "$cmd_name" > /dev/null; then
  pip3 install bandit
fi

out=$(bandit -r ../../)
exit_status=$?
out=$(echo "$out" | python -c 'import json,sys; print(json.dumps(sys.stdin.read()))')
out="${out%\"}"
out="${out#\"}"
out=$(echo "$out" | base64)

if [ $exit_status -eq 1 ]; then
  echo "{\"id\": \"python-security\", \"output\": \"base64:${out}\", \"score\": -1}"
else
  echo "{\"id\": \"python-security\", \"output\": \"base64:${out}\", \"score\": 1}"
fi
