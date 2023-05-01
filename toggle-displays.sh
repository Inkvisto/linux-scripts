#!/bin/sh
# toggle-displays.sh script
#
# Toggles between internal and external 1080P display modes
#

# This is the version for Ubuntu 20.04.6 Focal Fossa on the ASUS-TUF-GAMING-A17
# eDP-1-0 = laptop | HDMI-A-1-0 = External Display
# ##########################################################
# author: Larry Bushey
# docs: https://goinglinux.com/articles/SwitchScreens_en.htm


mode="$(xrandr -q|grep -A1 "HDMI-A-1-0 connected"| tail -1 |awk '{ print $1 }')"
if [ -n "$mode" ]; then
    # External display is connected
    primary="$(xrandr|grep "eDP-1-0 connected primary")"
       if [ -n "$primary" ]; then
          # Laptop display is connected. Shut it off and make external display 1080P.
          xrandr --output HDMI-A-1-0 --mode 1920x1080 --primary
          xrandr --output eDP-1-0 --off
          notify-send --icon=/usr/share/icons/Humanity/apps/48/gnome-display-properties.svg "External 1080p" "Time to chill or eat, yeap, i like it"
       else
          # External display is connected
          # Laptop display is not connected. Set both monitors to 1080P.
          xrandr --output HDMI-A-1-0 --mode 1920x1080
          xrandr --output eDP-1-0 --mode 1920x1080
          # Set external display to the right of the laptop monitor and make laptop monitor primary
          xrandr --output HDMI-A-1-0 --left-of eDP-1-0
          xrandr --output eDP-1-0 --primary
          notify-send --icon=/usr/share/icons/Humanity/apps/48/gnome-display-properties.svg "Dual 1080P" "Have a nice day, and try your best :)"
       fi
else
    # External display is not connected.
    # Set laptop display to 1080P.
    xrandr --output eDP-1-0 --mode 1920x1080 --primary
    xrandr --output HDMI-A-1-0 --off
    notify-send --icon=/usr/share/icons/Humanity/apps/48/gnome-display-properties.svg "Laptop 1080" "External monitor is not connected :("
fi
