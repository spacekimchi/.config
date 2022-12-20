localhost$ cat /home/fedora/.xsession
#!/bin/sh

/usr/bin/xset b off
/usr/bin/xsetroot -solid darkslategrey
# speed of keyboard repeat
xset r rate 300 50

# compositioner for transparency alpha setting
xcompmgr &

# move monitor positions
xrandr --output DP-1 --auto --left-of DP-2

# If feh was installed, this can be uncommented.
~/.fehbg &
# If xautolocal was installed, this can be uncommented.
#/usr/bin/xautolock -locker /usr/local/bin/slock -detectsleep -secure -time 10 &
/usr/local/bin/slstatus &
/usr/local/bin/dwm

