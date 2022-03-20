# AutoPhotos

## Requirements

inotifywait version 3.2 or later


## Install inotifywait from source  
```
mkdir /tmp/inotify-tools
cd /tmp/inotify-tools/
wget https://github.com/inotify-tools/inotify-tools/releases/download/3.20.2.2/inotify-tools-3.20.2.2.tar.gz
tar xzvf inotify-tools-3.20.2.2.tar.gz
cd inotify-tools-3.20.2.2
./configure --prefix=/usr --libdir=/lib64
make
make install
```