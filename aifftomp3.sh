set -e

INPUT="$1"

ffmpeg -i "${INPUT}" -b:a 320000 "${INPUT%.*}.mp3" "${INPUT%.*}.wav"
