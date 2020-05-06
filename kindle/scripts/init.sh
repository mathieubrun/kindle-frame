#!/bin/sh

# disable UI
/etc/init.d/framework stop
# disable power saving
/etc/init.d/powerd stop

# display one image
/mnt/us/photo-frame/display.sh