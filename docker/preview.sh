#!/usr/bin/env sh
set -eu

# A container can reuse the PID stored by an earlier preview container. Remove
# only Quarto's generated preview lock before starting a new server.
rm -f /work/.quarto/preview/lock

exec quarto preview "$@"

