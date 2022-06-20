#!/usr/bin/env sh

set -e

if [ -f /collaborators-backend/tmp/pids/server.pid ]; then
  rm /collaborators-backend/tmp/pids/server.pid
fi

bundle check --path vendor/bundle || bundle install --path vendor/bundle --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

exec "$@"
