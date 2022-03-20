#!/bin/sh


git fetch origin main
git reset --hard origin/main

cp autophoto.sh /usr/local/bin/
chmod +x /usr/local/bin/autophoto.sh

