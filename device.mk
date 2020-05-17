#
# Copyright (C) 2009 The Android Open Source Project
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
#

# This is a build configuration for a full-featured build of the
# Open-Source part of the tree. It's geared toward a US-centric
# build of the emulator, but all those aspects can be overridden
# in inherited configurations.

PRODUCT_PACKAGES := \
    libfwdlockengine \
    libWnnEngDic \
    libwnndict \
    WAPPushManager

ifneq ($(TARGET_EXCLUDE_LIVEWALLPAPERS), true)
PRODUCT_PACKAGES += \
    Galaxy4 \
    HoloSpiralWallpaper \
    LiveWallpapers \
    LiveWallpapersPicker \
    MagicSmokeWallpapers \
    NoiseField \
    PhaseBeam \
    PhotoTable
else
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    PhotoTable
endif

ifeq ($(AOSP_SOUND_CONFIG),true)
# Additional settings used in all AOSP builds
PRODUCT_PROPERTY_OVERRIDES := \
    ro.config.ringtone=Ring_Synth_04.ogg \
    ro.config.notification_sound=pixiedust.ogg
endif

# Put en_US first in the list, so make it default.
PRODUCT_LOCALES := zh_CN

# Get some sounds
$(call inherit-product-if-exists, frameworks/base/data/sounds/AllAudio.mk)

# Get the TTS language packs
$(call inherit-product-if-exists, external/svox/pico/lang/all_pico_languages.mk)

# Get a list of languages.
$(call inherit-product, $(SRC_TARGET_DIR)/product/locales_full.mk)

# Get everything else from the parent package
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_no_telephony.mk)

# prebuilt kernel
TARGET_PREBUILT_KERNEL := device/EEBBK/H5000/kernel

# Charger
PRODUCT_PACKAGES += \
   charger_res_images \
   charger

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/fstab.mt8167:root/fstab.mt8167 \
    $(LOCAL_PATH)/recovery/init.recovery.mt8167.rc:root/init.recovery.mt8167.rc \
    $(LOCAL_PATH)/recovery/init.recovery.service.rc:root/init.recovery.service.rc \
    $(LOCAL_PATH)/recovery/ueventd.mt8167.rc:root/ueventd.mt8167.rc

$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
