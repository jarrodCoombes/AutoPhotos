#!/bin/sh



cwd=$(pwd)

inotifywait -mr --timefmt '%m/%d/%y %H:%M' --format '%T %w %f' -e close_write /shares/Photos |
while read -r date time dir file; do
       changed_abs=${dir}${file}
       changed_rel=${changed_abs#"$cwd"/}

       # rsync --progress --relative -vrae 'ssh -p 22' "$changed_rel" usernam@example.com:/backup/root/dir && \
       printf "\nAt ${time} on ${date}, file $changed_abs was changed or created ( dir =$dir file=$file ) \n"
done