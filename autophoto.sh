#!/bin/sh



cwd=$(pwd)

inotifywait -mr --timefmt '%m/%d/%y %H:%M' --format '%T %w %f' -e close_write /shares/Photos --exclude "\.jpg" |
while read -r date time dir file; do
       changed_abs=${dir}${file}
       changed_rel=${changed_abs#"$cwd"/}

       printf "\nFile $changed_abs was changed or created ( dir =$dir file=$file ) \n"
       
done