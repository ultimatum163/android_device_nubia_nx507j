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

# inherit from the proprietary version
-include vendor/nubia/nx507j/BoardConfigVendor.mk

LOCAL_PATH := device/nubia/nx507j

PRODUCT_COPY_FILES := $(filter-out frameworks/base/data/keyboards/AVRCP.kl:system/usr/keylayout/AVRCP.kl \
	frameworks/base/data/keyboards/Generic.kl:system/usr/keylayout/Generic.kl \
	frameworks/base/data/keyboards/Generic.kcm:system/usr/keychars/Generic.kcm, $(PRODUCT_COPY_FILES))


# QCRIL
TARGET_RIL_VARIANT := caf
SIM_COUNT := 2
TARGET_GLOBAL_CFLAGS += -DANDROID_MULTI_SIM
TARGET_GLOBAL_CPPFLAGS += -DANDROID_MULTI_SIM
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD
COMMON_GLOBAL_CPPFLAGS += -DNO_SECURE_DISCARD
FEATURE_QCRIL_UIM_SAP_SERVER_MODE := true
PROTOBUF_SUPPORTED := true

# Assert
TARGET_OTA_ASSERT_DEVICE := NX507J,nx507j,cm_NX507J,cm_nx507j,NX507j,jNX507

# Partitions
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 25165824
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1610612736
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12738083840

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := MSM8974
TARGET_NO_BOOTLOADER := true
TARGET_NO_RADIOIMAGE := true

# Platform
TARGET_BOARD_PLATFORM := msm8974
TARGET_BOARD_PLATFORM_GPU := qcom-adreno330
USE_CLANG_PLATFORM_BUILD := true

# Architecture
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_VARIANT := krait
TARGET_USE_QCOM_BIONIC_OPTIMIZATION := true

# Krait optimizations
TARGET_USE_KRAIT_BIONIC_OPTIMIZATION:= true
TARGET_USE_KRAIT_PLD_SET := true
TARGET_KRAIT_BIONIC_PLDOFFS := 10
TARGET_KRAIT_BIONIC_PLDTHRESH := 10
TARGET_KRAIT_BIONIC_BBTHRESH := 64
TARGET_KRAIT_BIONIC_PLDSIZE := 64

# Kernel
BOARD_DTBTOOL_ARGS := --force-v2
BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.hardware=qcom user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3 androidboot.selinux=permissive
BOARD_KERNEL_SEPARATED_DT := true
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x02000000 --tags_offset 0x01E00000
TARGET_KERNEL_SOURCE := kernel/nubia/nx507j
TARGET_KERNEL_ARCH := arm
TARGET_KERNEL_CONFIG := cm-nx507j_defconfig
TARGET_ZTEMT_DTS := true

# Power
TARGET_POWERHAL_VARIANT := qcom

# Audio
BOARD_USES_ALSA_AUDIO := true
AUDIO_FEATURE_ENABLED_NEW_SAMPLE_RATE := true
AUDIO_FEATURE_ENABLED_MULTI_VOICE_SESSIONS := true
#AUDIO_FEATURE_ENABLED_FLUENCE := true
AUDIO_FEATURE_ENABLED_EXTERNAL_SPEAKER := true
AUDIO_FEATURE_ENABLED_USBAUDIO := true
AUDIO_FEATURE_LOW_LATENCY_PRIMARY := true
AUDIO_FEATURE_ENABLED_LOW_LATENCY_CAPTURE := true
#AUDIO_FEATURE_ENABLED_ANC_HEADSET := true
AUDIO_FEATURE_ENABLED_HWDEP_CAL := true
USE_CUSTOM_AUDIO_POLICY := 1

# FM
#QCOM_FM_ENABLED := true
#AUDIO_FEATURE_ENABLED_FM := true
AUDIO_FEATURE_ENABLED_FM_POWER_OPT := true

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(LOCAL_PATH)/bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := true
QCOM_BT_USE_SMD_TTY := true

# Enables Adreno RS driver
USE_OPENGL_RENDERER := true
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_ION := true
TARGET_USES_NEW_ION_API :=true
TARGET_USES_OVERLAY := true
OVERRIDE_RS_DRIVER := libRSDriver_adreno.so
HAVE_ADRENO_SOURCE:= false
VSYNC_EVENT_PHASE_OFFSET_NS := 7500000
SF_VSYNC_EVENT_PHASE_OFFSET_NS := 5000000
TARGET_USES_QCOM_BSP := true
BOARD_USES_OPENSSL_SYMBOLS := true
#TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true
TARGET_USE_COMPAT_GRALLOC_PERFORM := true

# Shader cache config options
# Maximum size of the  GLES Shaders that can be cached for reuse.
# Increase the size if shaders of size greater than 12KB are used.
MAX_EGL_CACHE_KEY_SIZE := 12*1024

# Maximum GLES shader cache size for each app to store the compiled shader
# binaries. Decrease the size if RAM or Flash Storage size is a limitation
# of the device.
MAX_EGL_CACHE_SIZE := 2048*1024

# Fonts
EXTENDED_FONT_FOOTPRINT := true

# Ant or qualcomm-uart ?
BOARD_ANT_WIRELESS_DEVICE := "vfs-prerelease"

# Camera
USE_DEVICE_SPECIFIC_CAMERA := true
COMMON_GLOBAL_CFLAGS += -DCAMERA_VENDOR_L_COMPAT

# RPC
TARGET_NO_RPC := true

# CMHW
TARGET_TAP_TO_WAKE_NODE := "/data/tp/easy_wakeup_gesture"
BOARD_USES_CYANOGEN_HARDWARE := true
BOARD_HARDWARE_CLASS := \
    $(LOCAL_PATH)/cmhw \
    hardware/cyanogen/cmhw

# QCNE
BOARD_USES_QCNE := true
TARGET_LDPRELOAD := libNimsWrap.so

# Init msm8974
TARGET_INIT_VENDOR_LIB := libinit_msm8974
TARGET_RECOVERY_DEVICE_MODULES := libinit_msm8974

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Charger
BOARD_CHARGER_SHOW_PERCENTAGE := true
BOARD_CHARGER_ENABLE_SUSPEND := true
#BOARD_CHARGER_DISABLE_INIT_BLANK := true
BACKLIGHT_PATH := /sys/class/leds/lcd-backlight/brightness

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072

# Qualcomm support
BOARD_USES_QCOM_HARDWARE := true
BOARD_USES_QC_TIME_SERVICES := true
USE_DEVICE_SPECIFIC_QCOM_PROPRIETARY:= true

# Wifi
BOARD_HAS_QCOM_WLAN := true
BOARD_HAS_QCOM_WLAN_SDK := true
BOARD_WLAN_DEVICE := qcwcn
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_qcwcn
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_qcwcn
WIFI_DRIVER_MODULE_PATH := "/system/lib/modules/wlan.ko"
WIFI_DRIVER_MODULE_NAME := "wlan"
WIFI_DRIVER_FW_PATH_STA := "sta"
WIFI_DRIVER_FW_PATH_AP := "ap"
TARGET_USES_WCNSS_CTRL := true
TARGET_USES_QCOM_WCNSS_QMI := true
TARGET_PROVIDES_WCNSS_QMI := true

# Recovery
#RECOVERY_VARIANT := twrp
ifneq ($(RECOVERY_VARIANT),twrp)
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/recovery/recovery.fstab
else
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/recovery/twrp.fstab
TW_THEME := portrait_hdpi
RECOVERY_GRAPHICS_FORCE_USE_LINELENGTH := true
TW_NO_USB_STORAGE := true
TW_INCLUDE_CRYPTO := true
TW_SCREEN_BLANK_ON_BOOT := true
BOARD_SUPPRESS_SECURE_ERASE := true
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
RECOVERY_SDCARD_ON_DATA := true
BOARD_HAS_NO_REAL_SDCARD := true
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
endif

#Disable memcpy_base.S optimization
TARGET_CPU_MEMCPY_BASE_OPT_DISABLE := true

# Enable dexpreopt to speed boot time
ifeq ($(HOST_OS),linux)
  ifeq ($(call match-word-in-list,$(TARGET_BUILD_VARIANT),user),true)
    ifeq ($(WITH_DEXPREOPT_BOOT_IMG_ONLY),)
      WITH_DEXPREOPT_BOOT_IMG_ONLY := true
    endif
  endif
endif

# SELinux
include device/qcom/sepolicy/sepolicy.mk
BOARD_SEPOLICY_DIRS += device/nubia/nx507j/sepolicy

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := $(LOCAL_PATH)
