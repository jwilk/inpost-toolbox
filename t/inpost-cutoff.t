#!/usr/bin/env bash

# Copyright © 2021-2022 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u

base="${0%/*}/.."
prog="$base/inpost-cutoff"

echo 1..1
if [ -z "${JWILK_INPOST_TOOLBOX_NETWORK_TESTING-}" ]
then
    echo '# set JWILK_INPOST_TOOLBOX_NETWORK_TESTING=1 to enable network tests' >&2
    echo not ok 1
    exit 1
fi

t_diff()
{
    n=$1
    out=$2
    exp=$3
    diff=$(diff -u <(printf '%s' "$exp") <(printf '%s' "$out")) || true
    if [ -z "$diff" ]
    then
        echo "ok $n"
    else
        sed -e 's/^/# /' <<< "$diff"
        echo "not ok $n"
    fi
}

out=$("$prog" '28-133')
exp='14:00'
t_diff 1 "$out" "$exp"

# vim:ts=4 sts=4 sw=4 et ft=sh
