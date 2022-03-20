#!/bin/sh

version=0.1.7

printf "\n\n Version $version \n\n\n"

cwd=$(pwd)
target=resized

#Check to make sure we're being run as root
if ! [ $(id -u) = 0 ]
  then printf "\nPlease run as root\n\n"
  exit
fi


inotifywait -mr --timefmt '%m/%d/%y %H:%M' --format '%T %w %f' -e create,close_write /shares/Photos --includei "\.jpg|\.jpeg" |
while read -r date time dir file; do
    changed_abs=${dir}${file}
    small_dir=${dir}${target}/
	
    printf "\nFile $changed_abs was changed or created\n  dir=$dir \n  file=$file \n  small_dir=$small_dir \n"
      
	if [ -d "$small_dir" -a ! -h "$small_dir" ]
	then
		echo "$small_dir found, nothing to do."
	else
		echo "Creating $small_dir"
		mkdir $small_dir
		chmod 777 $small_dir
	fi
	
	if [ "$dir" = "$small_dir" ]; then
		printf "\nFile is in the $small_dir folder, nothing to do\n"
	else
		printf "\nResizing file into the $small_dir folder\n"
	fi
		
done