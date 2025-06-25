#!bin/bash

# repo init
repo init --depth=1 -u https://github.com/ScandiumOS-14/manifest -b 14 --git-lfs
echo "repo init succses...."

# sync
/opt/crave/resync.sh || 
echo "sync succsessfull...."

# cloning trees bg







# export
export BUILD_USERNAME=
export BUILD_HOSTNAME=
export ALLOW_MISSING_DEPENDENCIES=
echo "export done...."

# start build enviroment
source build/envsetup.sh

# start build 
echo "build will be start now...."
. build/envsetup.sh
lunch scandium_earth-ap2a-userdebug
make bacon
