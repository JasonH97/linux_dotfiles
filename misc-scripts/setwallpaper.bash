#!/bin/bash

# set constants
SLEEP_TIME=3600 # 3600 seconds = 1 hour
WP_IMAGE_DIR="/home/$USER/Pictures/movie-stills/"

# parse command-line args
while getopts ":t:d:" opt; do
    case $opt in
        t) SLEEP_TIME="$OPTARG" ;;
        d) WP_IMAGE_DIR="$OPTARG" ;;
       \?) echo "Usage: $0 [-t Update_Frequency(seconds)] [-d Image_Directory]" ;;
    esac
done

# run endlessly
while [ 1 ]
do
    # grab wallpaper image options
    # only 2 '/' after file because WP_IMAGE_DIR starts with '/'
    WP_IMAGE="file://$WP_IMAGE_DIR$(ls ${WP_IMAGE_DIR}| sort -R | head -n1)"

    # update desktop background
    gsettings set org.gnome.desktop.background picture-uri-dark ${WP_IMAGE}
    gsettings set org.gnome.desktop.background picture-uri ${WP_IMAGE}

    # wait until changing again
    sleep ${SLEEP_TIME}
done
