#!/usr/bin/env bash

KINDLE_IP=192.168.15.244

scp scripts/init.sh root@$KINDLE_IP:/mnt/us/kite/onboot/init.sh
scp -r scripts/photo-frame root@$KINDLE_IP:/mnt/us/
ssh root@$KINDLE_IP < scripts/update_cron.sh