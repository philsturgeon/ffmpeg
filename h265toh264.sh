set -e

INPUT="$1"

find "$INPUT" -type f -iname "*x265*mkv" -not -iname "*converted.h264.mkv" -print0 | while IFS= read -r -d $'\0' file; do
    echo "Pesky $file is off to the chopping block."
    tmpfile="./progress/${file##*/}.ts"
    destfile="${file%.mkv}.converted.h264.mkv"
    ffmpeg -i "$file" -threads 0 -sn -c:a copy -c:v libx264 -map 0:v:0 -map 0:a:0 "$tmpfile" -stats -y < /dev/null
    mv "$tmpfile" "$destfile"
    rm "$file"
    echo "YAY WE DID IT: $destfile"

    sleep 3
done


# find flvs/ -type f -name '*.flv' -exec sh -c '
# for flvsfile; do
#     file=${flvsfile#flvs/}
#     < /dev/null ffmpeg -i "$flvsfile" -vcodec libx264 -vprofile high \
#         -preset slow -b:v 500k -maxrate 500k -bufsize 1000k \
#         -threads 0 -acodec libfaac -ab 128k \
#         "mp4s/${file%flv}"mp4
#     printf %s\\n "$flvsfile MP4 done." >> "$logfile"
# done
# ' _ {} +
