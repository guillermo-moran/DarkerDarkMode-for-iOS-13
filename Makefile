export ARCHS = arm64 arm64e
export TARGET := iphone::latest:13.0
ADDITIONAL_CFLAGS = -DTHEOS_LEAN_AND_MEAN
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = DarkerDarkMode
DarkerDarkMode_FILES = Tweak.x
DarkerDarkMode_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk