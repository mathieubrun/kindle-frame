#!/usr/bin/env bash

parts=(inner_frame blocker back)

for part in "${parts[@]}"
do
    openscad -D 'print=true' -D "part=\"$part\"" -o $part.stl kindle-frame.scad
done