#!/bin/sh

version=0.1.19

if [ "$1" = "-v" ]; then
	printf "AutoPhoto Version $version\n"
	exit 0
fi

output_size=1280x960 #Output resolution for the resized images.

#Check to make sure we're being run as root
if ! [ $(id -u) = 0 ]
  then printf "\nPlease run as root\n\n"
  exit 1
fi

inotifywait -mr --timefmt '%m/%d/%y %H:%M' --format '%T %w%f' -e close_write --exclude '/resized(/.*)?$' /shares/Photos |
    grep --line-buffered -Ei '/[^/]*\.(jpg|jpeg)$' |
while read -r date time changed_abs; do

    [ -d "$changed_abs" ] && continue # a directory looking like a picture filename was written to: skip this event

    dir="${changed_abs%/*}/"  					#The full path of the folder the file is in.
    file="${changed_abs##*/}" 					#The file name of the file
    resized_dir="${dir}resized/"				#The target directory in which the resized image will be put in.
    output_file="${resized_dir}"1080-"${file}"	#The filename of the resized file.
	
    printf "\nFile $changed_abs was changed or created\n  dir=$dir \n  file=$file \n  resized_dir=$resized_dir \n"

	#Check to see if $resized_dir exists if not then create it.
	if [ -d "$resized_dir" -a ! -h "$resized_dir" ]; then
		printf "\nFolder $resized_dir found, no need to create it.\n"
	else
		printf "\nCreating $resized_dir \n"
		mkdir "$resized_dir"
		chmod 777 "$resized_dir"
	fi

	# printf "\nResizing file into the $resized_dir folder\n"
	printf "\n  Converting: $changed_abs \n  Output Size:$output_size \n  Output File: $output_file\n" 
	convert "$changed_abs" -resize "$output_size" "$output_file"
	printf "\nDone\n\n"
		
done