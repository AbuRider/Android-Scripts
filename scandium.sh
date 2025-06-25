#!bin/bash

# repo init
repo init --depth=1 -u https://github.com/ScandiumOS-14/manifest -b 14 --git-lfs
echo "repo init succses...."

# sync
/opt/crave/resync.sh || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all)
echo "sync succsessfull...."

# cloning trees bg
echo "cloning pohon perangkat...."
echo "==========================="

rm -rf device/xiaomi
rm -rf vendor/xiaomi
rm -rf kernel/xiaomi
rm -rf hardware/xiaomi
rm -rf hardware/mediatek
rm -rf device/mediatek/sepolicy_vndr

git clone https://github.com/AbuRider/android_device_xiaomi_earth.git -b scandium device/xiaomi/earth

git clone https://github.com/mt6768-dev/proprietary_vendor_xiaomi_earth.git -b lineage-21 vendor/xiaomi/earth

git clone https://github.com/LineageOS/android_kernel_xiaomi_earth.git -b lineage-21 kernel/xiaomi/earth

git clone https://github.com/LineageOS/android_hardware_xiaomi.git -b lineage-21 hardware/xiaomi

git clone https://github.com/LineageOS/android_hardware_mediatek.git -b lineage-21 hardware/mediatek

git clone https://github.com/LineageOS/android_device_mediatek_sepolicy_vndr.git -b lineage-21 device/mediatek/sepolicy_vndr

/opt/crave/resync.sh

# export
export BUILD_USERNAME=rmdw
export BUILD_HOSTNAME=crave
export TZ=Asia/Jakarta
export ALLOW_MISSING_DEPENDENCIES=true
echo "export done...."

. build/envsetup.sh
lunch scandium_earth-ap2a-userdebug
make bacon
