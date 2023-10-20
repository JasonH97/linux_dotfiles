#!/bin/bash

while getopts ":u:a" opt; do
  case $opt in
    u|--url)
      raw_url=$OPTARG ;;
    a)
      audio=true ;;
    *)
      echo "Invalid option"
      exit 1 ;;
  esac
done

# Shift the options so that $1 and $2 point to the correct arguments
shift $((OPTIND - 1))

# Use Youtube to reliably parse playlist name and avoid 403 (invidious/piped)
playlist_url="https://www.youtube.com/$(echo $raw_url | awk -F'/' '{print $NF}')"
playlist_name=$(curl -s $playlist_url | grep -oP '(?<=<title>)(.*)(?= - YouTube</title>)' | sed 's/ /_/g')

# Determine which directory and command to use based on Audio/Video selection
if [ $audio == true ]; then
    download_directory="$HOME/Music/$playlist_name---$(echo $playlist_url | awk -F'=' '{print $NF}')"
    yt_command="yt-dlp -f bestaudio -o \"$download_directory/%(playlist_index)02d_%(title)s.%(ext)s\" \"$playlist_url\""
else
    download_directory="$HOME/Videos/$playlist_name---$(echo $playlist_url | awk -F'=' '{print $NF}')"
    yt_command="yt-dlp -o \"$download_directory/%(playlist_index)02d_%(title)s.%(ext)s\" \"$playlist_url\""
fi

# Create directory if not present and run command, report back success/failure
mkdir -p "$download_directory"
notify-send "Downloading..." "$playlist_name"
eval "$yt_command"
if [ $? -eq 0 ]; then
  notify-send "Download Complete" "$raw_url"
  exit 0
else
  notify-send "Download Failed" "$raw_url"
  exit 2
fi

