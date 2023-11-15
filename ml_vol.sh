#!/bin/sh

interval=3 # customize this

# Set the variable stump_pid using one of these two lines.  Which line you use
# depends on whether you run the large StumpWM executable that bundles SBCL, or
# if you simply start SBCL and load StumpWM.  If you are using the FreeBSD
# StumpWM package, use the second line.

stump_pid="$(pgrep -a -n stumpwm)"
#stump_pid="$(pgrep -anf -U "$(id -u)" "sbcl .*(stumpwm:stumpwm)")"

# while stumpwm is still running
while kill -0 "$stump_pid" > /dev/null 2>&1; do
    vol=$(mixer -o vol.volume | sed -e 's/vol\.volume=[0-9.]*://')
    printf "%1.2f\n" "$vol"
    sleep "$interval"
done
