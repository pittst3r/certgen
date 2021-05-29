#!/bin/sh

set -e

get_sandbox_path()
{
  echo /tmp/test/sandbox
}

before_each()
{
  mkdir -p $(get_sandbox_path)
  cd $(get_sandbox_path)
}

after_each()
{
  cd /
  rm -rf $(get_sandbox_path)
}

error_message()
{
  echo "Completed $count tests before failing"
}

count=0

echo "Running tests"
trap "error_message" EXIT

for f in /tmp/test/*_test.sh; do
  before_each
  sh "$f"
  after_each
  count=$(expr $count + 1)
done

echo "Completed $count tests"
