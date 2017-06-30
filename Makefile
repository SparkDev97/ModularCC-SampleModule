ARCHS = armv7 armv7s arm64
THEOS_DEVICE_IP = localhost
THEOS_DEVICE_PORT = 2022

SDKVERSION = 10.1
SYSROOT = $(THEOS)/sdks/iPhoneOS10.1.sdk

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ModularCCSampleModule
ModularCCSampleModule_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
