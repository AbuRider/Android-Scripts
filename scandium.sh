#!bin/bash

# repo init
repo init --depth=1 -u https://github.com/ScandiumOS-14/manifest -b 14 --git-lfs
echo "repo init succses...."

# sync
if /opt/crave/resync.sh || if 
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

git clone https://github.com/AbuRider/android_device_xiaomi_earth.git -b scandium device/xiaomi/earth || { echo "Failed to clone device tree"; }

git clone https://github.com/mt6768-dev/proprietary_vendor_xiaomi_earth.git -b lineage-22.2 vendor/xiaomi/earth || { echo "Failed to clone vendor tree"; }

git clone https://github.com/LineageOS/android_kernel_xiaomi_earth.git -b lineage-22.2 kernel/xiaomi/earth || { echo "Failed to clone kernel tree"; }

git clone https://github.com/LineageOS/android_hardware_xiaomi.git -b lineage-22.2 hardware/xiaomi || { echo "Failed to clone xiaomi stuffs"; }

git clone https://github.com/LineageOS/android_hardware_mediatek.git -b lineage-22.2 hardware/mediatek || { echo "Failed to clone mediatek hardwares"; }

git clone https://github.com/LineageOS/android_device_mediatek_sepolicy_vndr.git -b lineage-22.2 device/mediatek/sepolicy_vndr || { echo "Failed to sepolicy_vndr"; }

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
