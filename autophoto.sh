#!/bin/sh

version=0.1.15

if [ "$1" = "-v" ]; then
	printf "AutoPhoto Version $version\n"
	exit 0
fi

target=resized        #Name of the sub directory for the resized images.
output_size=1920x1080 #Output resolution for the resized images.

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
    small_dir="${dir}${target}/"				#The targer directory in which the resized image will be put in.
    output_file="${small_dir}"1080-"${file}"	#The filename of the resized file.
	
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
			mkdir "$small_dir"
			chmod 777 "$small_dir"
		fi

		# printf "\nResizing file into the $small_dir folder\n"
		printf "\n  Converting: $changed_abs \n  Output Size:$output_size \n  Output File: $output_file\n" 
		convert "$changed_abs" -resize "$output_size" "$output_file"
		printf "\nDone\n\n"
	fi

		
done