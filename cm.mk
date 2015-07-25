$(call inherit-product, device/zte/nx507j/full_nx507j.mk)

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=3 \
    dalvik.vm.dexopt-flags=m=y \
    ro.product.locale.language=zh \
    ro.product.locale.region=CN \
    persist.sys.timezone=Asia/Shanghai

