#!/bin/sh
# Stolen from https://apple.stackexchange.com/questions/222917/how-do-i-use-ffmpeg-to-convert-audible-files
set -e

INPUT="$1"
KEY="$2"

ffmpeg -activation_bytes ${KEY} -i ${INPUT} -vn -c:a copy "${INPUT%.*}.m4a";
