#!/usr/bin/env bash

mkdir -p ./scripts/photo-frame/images
mogrify -path ./scripts/photo-frame/images -resize '^x600' -grayscale Rec709Luma -auto-orient -colorize '50%' -format png ./images/*.jpg
