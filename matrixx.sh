#!/bin/bash
# crave run --no-patch -- "curl https://raw.githubusercontent.com/tillua467/Android-Scripts/refs/heads/main/script.sh | bash"

# Remove Unnecessary Files
echo "===================================="
echo "     Removing Unnecessary Files"
echo "===================================="

dirs_to_remove=(
  "vendor/xiaomi"
  "kernel/xiaomi"
  "device/xiaomi"
  "hardware/xiaomi"
  "out/target/product/*/*zip"
  "out/target/product/*/*txt"
  "out/target/product/*/boot.img"
  "out/target/product/*/recovery.img"
  "out/target/product/*/super*img"
)

for dir in "${dirs_to_remove[@]}"; do
  [ -e "$dir" ] && rm -rf "$dir"
done

echo "===================================="
echo "  Removing Unnecessary Files Done"
echo "===================================="

# Initialize repo
echo "=============================================="
echo "         Cloning Manifest..........."
echo "=============================================="
if ! repo init -u https://github.com/ProjectMatrixx/android.git -b 15.0 --git-lfs; then
  echo "Repo initialization failed."
fi
echo "=============================================="
echo "       Manifest Cloned successfully"
echo "=============================================="
# Sync
if ! /opt/crave/resync.sh || ! repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j$(nproc --all); then
  echo "Repo sync failed."
fi
echo "============="
echo " Sync success"
echo "============="

# Clone device trees and other dependencies
echo "=============================================="
echo "       Cloning Trees..........."
echo "=============================================="
rm -rf device/xiaomi

rm -rf vendor/xiaomi

rm -rf kernel/xiaomi

rm -rf hardware/xiaomi

rm -rf hardware/mediatek

rm -rf device/mediatek/sepolicy_vndr

git clone https://github.com/AbuRider/android_device_xiaomi_earth.git -b matrixx device/xiaomi/earth || { echo "Failed to clone device tree"; }

git clone https://github.com/mt6768-dev/proprietary_vendor_xiaomi_earth.git -b lineage-22.2 vendor/xiaomi/earth || { echo "Failed to clone vendor tree"; }

git clone https://github.com/LineageOS/android_kernel_xiaomi_earth.git -b lineage-22.2 kernel/xiaomi/earth || { echo "Failed to clone kernel tree"; }

git clone https://github.com/LineageOS/android_hardware_xiaomi.git -b lineage-22.2 hardware/xiaomi || { echo "Failed to clone xiaomi stuffs"; }

git clone https://github.com/LineageOS/android_hardware_mediatek.git -b lineage-22.2 hardware/mediatek || { echo "Failed to clone mediatek hardwares"; }

git clone https://github.com/LineageOS/android_device_mediatek_sepolicy_vndr.git -b lineage-22.2 device/mediatek/sepolicy_vndr || { echo "Failed to sepolicy_vndr"; }

/opt/crave/resync.sh

# Export Environment Variables
echo "======= Exporting........ ======"
export BUILD_USERNAME=rmdw
export BUILD_HOSTNAME=crave
export TZ=Asia/Jakarta
export ALLOW_MISSING_DEPENDENCIES=true
echo "======= Export Done ======"

# Set up build environment
echo "====== Starting Envsetup ======="
source build/envsetup.sh || { echo "Envsetup failed"; exit 1; }
echo "====== Envsetup Done ======="

# Build ROM
echo "===================================="
echo "  MATRIKSS BESTT, STARTING BUILD.."
echo "===================================="
. build/envsetup.sh
brunch earth 
