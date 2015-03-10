#!/bin/sh

interval=3
stump_pid=`pgrep -a -n stumpwm`
vol_cmd="/usr/sbin/mixer -s vol | sed 's/vol [0-9]*://'"

# while stumpwm is still running
while kill -0 $stump_pid > /dev/null 2>&1; do
    echo `eval ${vol_cmd}`
    sleep ${interval}
done
