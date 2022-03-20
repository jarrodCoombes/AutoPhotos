#!/bin/sh

version=0.1.10

printf "\n\n Version $version \n\n\n"

cwd=$(pwd)
target=resized
output_size=1920x1080

#Check to make sure we're being run as root
if ! [ $(id -u) = 0 ]
  then printf "\nPlease run as root\n\n"
  exit
fi


inotifywait -mr --timefmt '%m/%d/%y %H:%M' --format '%T %w %f' -e close_write /shares/Photos --includei "\.jpg|\.jpeg" |
while read -r date time dir file; do
    changed_abs=${dir}${file}
    small_dir=${dir}${target}/
	output_file=${small_dir}1080-${file}
	
    printf "\nFile $changed_abs was changed or created\n  dir=$dir \n  file=$file \n  small_dir=$small_dir \n"

    # Check to make sure the file is not allready in $small_dir    
    if [ "$(echo ${dir} | awk '{print $(NF-1)}' FS=/)" = "$target" ]; then
		printf "\nFile is in the $small_dir folder, nothing to do.\n"
	else
		#Check to see if $small_dir exists or not
		if [ -d "$small_dir" -a ! -h "$small_dir" ]; then
			printf "\nFolder $small_dir found, no need to create it.\n"
		else
			printf "\nCreating $small_dir \n"
			mkdir $small_dir
			chmod 777 $small_dir
		fi

		printf "\nResizing file into the $small_dir folder\n"
		# Code to resize image goes here
		printf "\n  Converting: $changed_abs \n  Output Size:$output_size \n  Output File: $output_file\n" 
		convert $changed_abs -resize $output_size $output_file
		printf "\nDone\n\n"
	fi

		
done