#!/bin/bash
# Jus de Patate - 2020 - jusdepatate@protonmail.com (github:jusdepatate)
# Script that changes your wallpaper to a random Wallhaven image
# Everything started with this command: `curl -s https://wallhaven.cc/random | sed -n 's/.*class="preview" href="https:\/\/wallhaven.cc\/w\/\([^"]*\).*/\1/p' | head -n1 && echo`
# Explained: curl has argument `s` so we don't have the shitty loading bar, sed tries to output all link with class "preview" and goes to wallhaven.cc/w/, head gives only the first line, `echo` is empty so that we have a new line.

fatal() {
	echo -e "$*"
	exit 1
}

id=$(curl -s https://wallhaven.cc/random | sed -n 's/.*class="preview" href="https:\/\/wallhaven.cc\/w\/\([^"]*\).*/\1/p' | head -n1 || fatal "Couldn't get random image id")
# gives the id of a random Wallhaven image
miniid=$(echo $id | cut -c1-2)
# first 2 letters of the id to build the url

png="https://w.wallhaven.cc/full/$miniid/wallhaven-$id.png"
jpg="https://w.wallhaven.cc/full/$miniid/wallhaven-$id.jpg"
# build probable URLs

if curl -Is $png | head -n1 | grep "404" > /dev/null || fatal "Couldn't check if $png gives 404 or not"; then
	url=$jpg
	type="jpg"
elif curl -Is $jpg | head -n1 | grep "404" > /dev/null || fatal "Couldn't check if $jpg gives 404 or not"; then
	url=$png
	type="png"
fi
# test probable URLs, final url will be $url
file="$HOME/Images/wallhaven/$id.$type"
folder="$HOME/Images/wallhaven/"

if [ ! -d "$folder" ]; then
	mkdir "$folder"
fi

touch "$file" || fatal "Couldn't create file $file"
curl -s "$url" > "$file" || fatal "Couldn't download $url"
echo "Image saved in $file"

# Use this setting only on MATE as this line will work only on MATE
if [[ "$1" = "--wallpaper" ]] || [[ "$1" == "-w" ]]; then
	gsettings set org.mate.background picture-filename "$file" || fatal "Couldn't set wallpaper, are you using MATE ?"
	echo "Wallpaper set to $file ($url)"
fi
