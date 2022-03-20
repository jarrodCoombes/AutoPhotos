#!/bin/sh



cwd=$(pwd)

inotifywait -mr --timefmt '%m/%d/%y %H:%M' --format '%T %w %f' -e close_write /shares/Photos |
while read -r date time dir file; do
       changed_abs=${dir}${file}
       changed_rel=${changed_abs#"$cwd"/}

    if [[ "$file" =~ .*jpg$ ]]; then # Does the file end with .jpg?
       printf "\nFile $changed_abs was changed or created ( dir =$dir file=$file ) \n"
    else
	   printf "\nFile $changed_abs was changed or created ( dir =$dir file=$file ) but was not a jpg \n"
	fi

       
done