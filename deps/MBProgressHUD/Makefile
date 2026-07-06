include $(THEOS)/makefiles/common.mk

FRAMEWORK_NAME = MBProgressHUD

MBProgressHUD_FILES = $(shell find . -path "*/.theos/*" -prune -o \( -name "*.m" -o -name "*.c" \) -print)
MBProgressHUD_PUBLIC_HEADERS = MBProgressHUD.h
MBProgressHUD_INSTALL_PATH = /Library/Frameworks

MBProgressHUD_FRAMEWORKS = UIKit CoreGraphics

MBProgressHUD_CFLAGS = -fobjc-arc

MBProgressHUD_CFLAGS += -Wno-deprecated-declarations
MBProgressHUD_CFLAGS += -Wno-unused-but-set-variable

MBProgressHUD_STRIP = 1

include $(THEOS_MAKE_PATH)/framework.mk