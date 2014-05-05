#!/bin/bash
set -e

upstream='https://github.com/coreos/go-systemd.git'

if ! git remote | grep -q upstream; then
	( set -x; git remote add upstream "$upstream" )
fi
