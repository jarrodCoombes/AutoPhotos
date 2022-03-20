#!/bin/sh

git fetch origin main
git reset --hard origin/main

cp autophoto.sh /user/local/bin/
chmod +x /user/local/bin/autophoto.sh

