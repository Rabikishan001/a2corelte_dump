#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from a2corelte device
$(call inherit-product, device/samsung/a2corelte/device.mk)

PRODUCT_DEVICE := a2corelte
PRODUCT_NAME := omni_a2corelte
PRODUCT_BRAND := samsung
PRODUCT_MODEL := SM-A260G
PRODUCT_MANUFACTURER := samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung-ss

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="a2coreltedd-user 8.1.0 OPR6 A260GDDSCAUJ1 release-keys"

BUILD_FINGERPRINT := samsung/a2coreltedd/a2corelte:8.1.0/OPR6/A260GDDSCAUJ1:user/release-keys
