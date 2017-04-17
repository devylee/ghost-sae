#!/bin/bash
set -e

rsync -r "$GHOST_SOURCE/content/" "$GHOST_CONTENT/"

if [[ "$*" == npm*start* ]] && [ "$(id -u)" = '0' ]; then
	chown -R ghost:ghost "$GHOST_CONTENT"
    exec gosu ghost "$@"
fi

exec "$@"
