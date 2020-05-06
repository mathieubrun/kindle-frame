#!/bin/sh

cd "$(dirname "$0")"

shuf() { awk 'BEGIN{srand()}{print rand()"\t"$0}' "$@" | sort | cut -f2- ;}

/usr/sbin/eips -c
/usr/sbin/eips -c
/usr/sbin/eips -g $(find images -type f | shuf | head -1)