#!/usr/bin/env bash

if ! grep -q "photo-frame" /etc/crontab/root; then
    mntroot rw
    echo "0 6,12,18 * * * /mnt/us/photo-frame/display.sh" >> /etc/crontab/root
    mntroot ro
    /etc/init.d/cron restart
fi

cat /etc/crontab/root