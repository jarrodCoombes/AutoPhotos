#!/bin/sh

version=0.1.2

printf "\n\n Version $version \n\n\n"

cwd=$(pwd)

#Check to make sure we're being run as root
if ! [ $(id -u) = 0 ]
  then printf "\nPlease run as root\n\n"
  exit
fi


inotifywait -mr --timefmt '%m/%d/%y %H:%M' --format '%T %w %f' -e close_write /shares/Photos --includei "\.jpg" |
while read -r date time dir file; do
       changed_abs=${dir}${file}
       small_dir=${dir}small
	   #changed_rel=${changed_abs#"$cwd"/}

       printf "\nFile $changed_abs was changed or created\n  dir=$dir \n  file=$file \n  small_dir=$small_dir \n"
	   
	
 
	if [ -d "$small_dir" -a ! -h "$small_dir" ]
	then
		echo "$small_dir found, nothing to do."
	else
		echo "Creating $small_dir"
		mkdir $small_dir
fi
       
done