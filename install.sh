#!/bin/sh

ipath=/usr/local/bin/

#Check to make sure we're being run as root
if ! [ $(id -u) = 0 ]
  then printf "\nPlease run as root\n\n"
  exit
fi

printf "\nCopying autophoto.sh to $ipath \n"
cp autophoto.sh $ipath

printf "Making autophoto.sh executable\n"
chmod +x $ipath/autophoto.sh

printf "\nDone\n\n"

