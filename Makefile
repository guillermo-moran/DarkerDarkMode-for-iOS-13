export THEOS=/opt/theos
export ARCHS = arm64 arm64e

GO_EASY_ON_ME = 1

SDKVERSION = 13.2

THEOS_DEVICE_IP = 192.168.1.184

TWEAK_NAME = DarkerDarkMode
DarkerDarkMode_FILES = Tweak.xm
DarkerDarkMode_FRAMEWORKS = UIKit

include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
