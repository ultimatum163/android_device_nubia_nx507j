#
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# inherit from the proprietary version
-include vendor/nubia/nx507j/BoardConfigVendor.mk

LOCAL_PATH := device/nubia/nx507j

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := krait
TARGET_USE_QCOM_BIONIC_OPTIMIZATION := true
#ARCH_ARM_HAVE_ARMV7A := true
#ARCH_ARM_HAVE_NEON := true
#ARCH_ARM_HAVE_TLS_REGISTER := true
#ARCH_ARM_HAVE_VFP := true

# Krait optimizations
TARGET_KRAIT_BIONIC_PLDOFFS := 10
TARGET_KRAIT_BIONIC_PLDTHRESH := 10
TARGET_KRAIT_BIONIC_BBTHRESH := 64
TARGET_KRAIT_BIONIC_PLDSIZE := 64
TARGET_USE_KRAIT_PLD_SET := true
TARGET_USE_KRAIT_BIONIC_OPTIMIZATION := true

# Disable memcpy_base.S optimization
TARGET_CPU_MEMCPY_BASE_OPT_DISABLE := true

# Flags
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD
COMMON_GLOBAL_CFLAGS += -DQCOM_MEDIA_DISABLE_BUFFER_SIZE_CHECK
COMMON_GLOBAL_CFLAGS += -D__ARM_USE_PLD -D__ARM_CACHE_LINE_SIZE=64
#TARGET_GLOBAL_CFLAGS += -mfpu=neon-vfpv4 -mfloat-abi=softfp
#TARGET_GLOBAL_CPPFLAGS += -mfpu=neon-vfpv4 -mfloat-abi=softfp

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8974
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Platform
TARGET_BOARD_PLATFORM := msm8974
TARGET_BOARD_PLATFORM_GPU := qcom-adreno330

# Kernel
BOARD_CUSTOM_BOOTIMG_MK := $(LOCAL_PATH)/mkbootimg.mk
BOARD_KERNEL_CMDLINE := console=null androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_SEPARATED_DT := true
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x02000000 --tags_offset 0x01E00000
TARGET_KERNEL_ARCH := arm
TARGET_KERNEL_SOURCE := kernel/nubia/nx507j
TARGET_KERNEL_CONFIG := cm-nx507j_defconfig
TARGET_ZTEMT_DTS := true

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216           # 16MB
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 25165824       # 24MB
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1610612736       # 1.5GB
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12738083840    # 11.86GB
BOARD_FLASH_BLOCK_SIZE := 131072

# Qualcomm
BOARD_USES_QCOM_HARDWARE := true
BOARD_USES_QC_TIME_SERVICES := true
USE_DEVICE_SPECIFIC_QCOM_PROPRIETARY:= true

# Audio
BOARD_USES_ALSA_AUDIO := true
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true
AUDIO_FEATURE_LOW_LATENCY_PRIMARY := true
AUDIO_FEATURE_ENABLED_ANC_HEADSET := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := true

# Ant or qualcomm-uart ?
BOARD_ANT_WIRELESS_DEVICE := "vfs-prerelease"
#BOARD_ANT_WIRELESS_DEVICE := "qualcomm-smd"

# Camera
USE_DEVICE_SPECIFIC_CAMERA := true
TARGET_PROVIDES_CAMERA_HAL := true

# GPS
BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := $(TARGET_BOARD_PLATFORM)
TARGET_NO_RPC := true

# CMHW
BOARD_HARDWARE_CLASS := $(LOCAL_PATH)/cmhw/

# Encryption
TARGET_HW_DISK_ENCRYPTION := true

# FM
QCOM_FM_ENABLED := true
AUDIO_FEATURE_ENABLED_FM := true

# Fonts
EXTENDED_FONT_FOOTPRINT := true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Charger
BOARD_CHARGER_SHOW_PERCENTAGE := true

# Power
TARGET_POWERHAL_VARIANT := qcom

# QCRIL
SIM_COUNT := 2
TARGET_RIL_VARIANT := caf
TARGET_GLOBAL_CFLAGS += -DANDROID_MULTI_SIM
TARGET_GLOBAL_CPPFLAGS += -DANDROID_MULTI_SIM

# Enables Adreno RS driver
BOARD_EGL_CFG := $(LOCAL_PATH)/etc/egl.cfg
USE_OPENGL_RENDERER := true
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_ION := true
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so
HAVE_ADRENO_SOURCE := false
VSYNC_EVENT_PHASE_OFFSET_NS := 7500000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 5000000
TARGET_USES_QCOM_BSP := true
#NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
#TARGET_GRALLOC_USES_ASHMEM := false
#TARGET_USE_ION_COMPAT := true

# Shader cache config options
# Maximum size of the  GLES Shaders that can be cached for reuse.
# Increase the size if shaders of size greater than 12KB are used.
MAX_EGL_CACHE_KEY_SIZE := 12*1024

# Maximum GLES shader cache size for each app to store the compiled shader
# binaries. Decrease the size if RAM or Flash Storage size is a limitation
# of the device.
MAX_EGL_CACHE_SIZE := 2048*1024

# Wifi
TARGET_USES_WCNSS_CTRL := true
BOARD_HAS_QCOM_WLAN := true
BOARD_WLAN_DEVICE := qcwcn
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_qcwcn
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_qcwcn
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/wlan.ko"
WIFI_DRIVER_MODULE_NAME := "wlan"
WPA_SUPPLICANT_VERSION := VER_0_8_X

# Assert
TARGET_OTA_ASSERT_DEVICE := NX507J,nx507j,z7mini

# Recovery
BOARD_RECOVERY_SWIPE := true
BOARD_SUPPRESS_EMMC_WIPE := true
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/recovery/recovery.fstab
BOARD_VENDOR := zte-qcom
#TARGET_SPECIFIC_HEADER_PATH := device/nubia/nx507j/include

# Preload Boot Animation
TARGET_BOOTANIMATION_PRELOAD := true

# SELinux
include device/qcom/sepolicy/sepolicy.mk

BOARD_SEPOLICY_DIRS += \
    $(LOCAL_PATH)/sepolicy

# Dexopt
WITH_DEXPREOPT := true
WITH_DEXPREOPT_BOOT_IMG_ONLY := false

# Release
TARGET_BUILD_TYPE := release
#TARGET_BUILD_VARIANT := user

# Buildinfo
BUILD_NUMBER := $(shell date +%Y%m%d)

# Linaro
KERNEL_TOOLCHAIN := $(ANDROID_BUILD_TOP)/prebuilts/gcc/linux-x86/arm/arm-linux-gnueabihf-4.9-linaro/bin
KERNEL_TOOLCHAIN_PREFIX := arm-cortex_a15-linux-gnueabihf-
TARGET_TOOLCHAIN_ROOT := $(ANDROID_BUILD_TOP)/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9-linaro
TARGET_TOOLS_PREFIX := $(TARGET_TOOLCHAIN_ROOT)/bin/arm-linux-androideabi-

# Filter
PRODUCT_COPY_FILES := $(filter-out frameworks/base/data/keyboards/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
    frameworks/base/data/keyboards/Generic.kl:system/usr/keylayout/Generic.kl \
    frameworks/base/data/keyboards/Generic.kcm:system/usr/keychars/Generic.kcm, $(PRODUCT_COPY_FILES))

# Clean
include device/nubia/nx507j/lite.mk

