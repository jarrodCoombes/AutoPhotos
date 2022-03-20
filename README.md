# AutoPhotos

## Requirements

-inotifywait version 3.20.2.2 or later
-imagemagick version 6


### Install inotifywait from source  
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
Note: This requires a C compiler to work (for Debian based distros run `sudo apt install build-essential`

### Install Imagemagick

For Debian/Ubuntu
```
apt install imagemagick
```