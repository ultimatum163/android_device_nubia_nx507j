# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from NX507J device
$(call inherit-product, device/nubia/nx507j/nx507j.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

PRODUCT_NAME := cm_nx507j
PRODUCT_DEVICE := nx507j
PRODUCT_MANUFACTURER := Nubia
PRODUCT_MODEL := NX507J

PRODUCT_GMS_CLIENTID_BASE := android-zte

PRODUCT_BRAND := Nubia
TARGET_VENDOR := Nubia
TARGET_VENDOR_PRODUCT_NAME := NX507J
TARGET_VENDOR_DEVICE_NAME := NX507J
PRODUCT_BUILD_PROP_OVERRIDES += TARGET_DEVICE=NX507J PRODUCT_NAME=NX507J



