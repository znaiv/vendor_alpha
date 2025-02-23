# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/alpha/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/alpha/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/alpha/prebuilt/common/bin/50-alpha.sh:$(TARGET_COPY_OUT_SYSTEM)/addon.d/50-alpha.sh

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/addon.d/50-alpha.sh

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.ota.allow_downgrade=true

ifneq ($(strip $(AB_OTA_PARTITIONS) $(AB_OTA_POSTINSTALL_CONFIG)),)
  PRODUCT_COPY_FILES += \
    vendor/alpha/prebuilt/common/bin/backuptool_ab.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.sh \
    vendor/alpha/prebuilt/common/bin/backuptool_ab.functions:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_ab.functions \
    vendor/alpha/prebuilt/common/bin/backuptool_postinstall.sh:$(TARGET_COPY_OUT_SYSTEM)/bin/backuptool_postinstall.sh

  PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/bin/backuptool_ab.sh \
    system/bin/backuptool_ab.functions \
    system/bin/backuptool_postinstall.sh
endif

# DeviceAsWebcam
ifeq ($(TARGET_BUILD_DEVICE_AS_WEBCAM), true)
  PRODUCT_PACKAGES += \
    DeviceAsWebcam

  PRODUCT_VENDOR_PROPERTIES += \
    ro.usb.uvc.enabled=true
endif

# Face Unlock
ifneq ($(TARGET_FACE_UNLOCK_SUPPORTED),false)
  PRODUCT_PACKAGES += \
    FaceUnlock

  PRODUCT_SYSTEM_EXT_PROPERTIES += \
    ro.face.sense_service=true

  PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.biometrics.face.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/android.hardware.biometrics.face.xml
endif

# GAPPS
ifeq ($(TARGET_BUILD_PACKAGE),4)
  $(call inherit-product, vendor/gapps/gapps.mk)
else ifeq ($(TARGET_BUILD_PACKAGE),3)
  BUILD_GMS_OVERLAYS_AND_PROPS := true
  $(call inherit-product, vendor/gms/products/gms.mk)
else
  ifeq ($(TARGET_BUILD_PACKAGE),2)
    $(call inherit-product, vendor/microg/product.mk)
  endif

  PRODUCT_PRODUCT_PROPERTIES += \
    setupwizard.theme=glif_v4 \
    setupwizard.feature.day_night_mode_enabled=true

  PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.setupwizard.enterprise_mode=1 \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.setupwizard.rotation_locked=true \
    ro.com.google.ime.theme_id=5 \
    ro.opa.eligible_device=true \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.network_required=false \
    ro.setupwizard.gservices_delay=-1 \
    ro.setupwizard.mode=OPTIONAL \
    setupwizard.feature.predeferred_enabled=false

  PRODUCT_PRODUCT_PROPERTIES += \
    ro.config.notification_sound=Argon.ogg \
    ro.config.alarm_alert=Hassium.ogg \
    ro.config.ringtone=Orion.ogg
endif
