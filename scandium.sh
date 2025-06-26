#!/bin/bash

# repo init
repo init --depth=1 -u https://github.com/ScandiumOS-14/manifest.git -b 14 --git-lfs
echo "repo init succses...."

# sync
/opt/crave/resync.sh || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
echo "sync succsessfull...."

# cloning trees bg
echo "cloning pohon perangkat...."
echo "==========================="

git clone https://github.com/AbuRider/android_device_xiaomi_earth.git -b scandium device/xiaomi/earth

git clone https://github.com/mt6768-dev/proprietary_vendor_xiaomi_earth.git -b lineage-21 vendor/xiaomi/earth

git clone https://github.com/LineageOS/android_kernel_xiaomi_earth.git -b lineage-21 kernel/xiaomi/earth

git clone https://github.com/LineageOS/android_device_mediatek_sepolicy_vndr.git -b lineage-21 device/mediatek/sepolicy_vndr

/opt/crave/resync.sh

# kalender kontol
#rm -rf packages/apps/Calendar
#git clone https://github.com/LineageOS/android_packages_apps_Etar.git -b lineage-21 packages/apps/Calendar

# export
export BUILD_USERNAME=rmdw
export BUILD_HOSTNAME=crave
export TZ=Asia/Jakarta
export ALLOW_MISSING_DEPENDENCIES=true
export DISABLE_STUB_VALIDATION=true 
echo "export done...."

# start build !
. build/envsetup.sh
lunch scandium_earth-ap2a-userdebug

# start compile
make bacon
