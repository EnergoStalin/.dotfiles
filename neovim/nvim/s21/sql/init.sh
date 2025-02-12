#!/bin/env sh

for i in `seq -f "%02g" 0 $N`; do
  mkdir -p ex$i
  touch ex$i/day`printf "%02d" $DN`_ex$i.sql
done
