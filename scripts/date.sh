#!/usr/bin/env bash
fmt=$1
tz=$2

[ -z "$tz" ] && tz=UTC

TZ=$tz date "$fmt"
