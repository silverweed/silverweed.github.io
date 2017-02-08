#!/bin/bash
POSTNAME=$(dirname $(readlink -f $0))/_posts/$(date +%Y-%m-%d-$(tr ' ' '_' <<<$*)).md
cat >$POSTNAME <<EOF
---
title: $*
layout: single
---
EOF
[[ $? == 0 ]] && vim $POSTNAME
