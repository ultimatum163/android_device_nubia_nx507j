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

# Release name
PRODUCT_RELEASE_NAME := nx507j
PRODUCT_NAME := cm_nx507j

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from nx507j device
$(call inherit-product, device/nubia/nx507j/nx507j.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := nx507j
PRODUCT_BRAND := nubia
PRODUCT_MODEL := NX507J
PRODUCT_MANUFACTURER := nubia

# Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=NX507J \
    TARGET_DEVICE=NX507J \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    BUILD_FINGERPRINT="nubia/NX507J/NX507J:5.0/LRX21M/nubia07071848:user/release-keys" \
    PRIVATE_BUILD_DESC="NX507J-user 5.0 LRX21M eng.nubia.20150707.184633 release-keys"

# Languages
PRODUCT_DEFAULT_LANGUAGE := zh
PRODUCT_DEFAULT_REGION := CN
PRODUCT_LOCALES := zh_CN zh_TW en_US

# CM Buildtype
CM_BUILDTYPE := NIGHTLY

