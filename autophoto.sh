#!/bin/sh

version=0.1

printf "\n\n Version $version \n\n\n"

cwd=$(pwd)

inotifywait -mr --timefmt '%m/%d/%y %H:%M' --format '%T %w %f' -e close_write /shares/Photos --includei "\.jpg" |
while read -r date time dir file; do
       changed_abs=${dir}${file}
       small_dir=${dir}/small
	   #changed_rel=${changed_abs#"$cwd"/}

       printf "\nFile $changed_abs was changed or created\n  dir=$dir \n  file=$file \n  small_dir=$small_dir \n"
	   mkdir $
       
done