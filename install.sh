#!/bin/sh

ipath=/usr/local/bin/

#Check to make sure we're being run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

printf "\nCopying autophoto.sh to $ipath \n"
cp autophoto.sh $ipath

printf "Making autophoto.sh executable\n"
chmod +x $ipath/autophoto.sh

printf "\nDone\n\n".

