#!/bin/sh

cwd=$(pwd)

inotifywait -mr --timefmt '%d/%m/%y %H:%M' --format '%T %w %f' -e close_write /tmp/test |
while read -r date time dir file; do
       changed_abs=${dir}${file}
       changed_rel=${changed_abs#"$cwd"/}

       # rsync --progress --relative -vrae 'ssh -p 22' "$changed_rel" usernam@example.com:/backup/root/dir && \
       echo "At ${time} on ${date}, file $changed_abs was backed up via rsync" # >&2
done