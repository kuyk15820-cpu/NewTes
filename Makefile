export TARGET := iphone:clang:16.5:14.0
export INSTALL_TARGET_PROCESSES = decrypt
export THEOS_PACKAGE_SCHEME = rootless

include $(THEOS)/makefiles/common.mk

SUBPROJECTS += deps/SSZipArchive deps/MBProgressHUD
include $(THEOS_MAKE_PATH)/aggregate.mk

APPLICATION_NAME = decrypt

decrypt_FILES = $(shell find . -path "*/.theos/*" -prune -o -path "./deps/SSZipArchive/*" -prune -o -path "./deps/MBProgressHUD/*" -prune -o -path "./deps/OpaKernel/*" -prune -o \( -name "*.m" -o -name "*.mm" -o -name "*.c" -o -name "*.cpp" \) -print)

decrypt_FRAMEWORKS = UIKit CoreGraphics MobileCoreServices Security IOSurface IOKit
decrypt_PRIVATE_FRAMEWORKS = AppServerSupport RunningBoardServices

decrypt_CFLAGS = -fobjc-arc -I./include -I./deps -I./deps/OpaKernel

decrypt_LDFLAGS += -F$(THEOS_OBJ_DIR)
decrypt_LDFLAGS += -Wl,-rpath,@executable_path/Frameworks

decrypt_LDFLAGS += -L./deps/OpaKernel -lOpaKernel

decrypt_EXTRA_FRAMEWORKS += SSZipArchive MBProgressHUD

decrypt_OBJCFLAGS = -include shared.h
decrypt_CODESIGN_FLAGS = -Sdecrypt.entitlements

internal-stage::
	echo "Moving Frameworks into app bundle and stripping developer headers..."
	mkdir -p $(THEOS_STAGING_DIR)/Applications/decrypt.app/Frameworks
	
	cp -a $(THEOS_STAGING_DIR)/Library/Frameworks/SSZipArchive.framework \
	      $(THEOS_STAGING_DIR)/Applications/decrypt.app/Frameworks
	cp -a $(THEOS_STAGING_DIR)/Library/Frameworks/MBProgressHUD.framework \
	      $(THEOS_STAGING_DIR)/Applications/decrypt.app/Frameworks
	
	rm -rf $(THEOS_STAGING_DIR)/Applications/decrypt.app/Frameworks/SSZipArchive.framework/Headers
	rm -rf $(THEOS_STAGING_DIR)/Applications/decrypt.app/Frameworks/MBProgressHUD.framework/Headers
	      
	rm -rf $(THEOS_STAGING_DIR)/Library

include $(THEOS_MAKE_PATH)/application.mk

after-stage::
	echo "Building .tipa..."
	$(ECHO_NOTHING)rm -rf Payload$(ECHO_END)
	$(ECHO_NOTHING)rm -f decrypt.tipa$(ECHO_END)
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Payload$(ECHO_END)
	$(ECHO_NOTHING)cp -a $(THEOS_STAGING_DIR)/Applications/* $(THEOS_STAGING_DIR)/Payload$(ECHO_END)
	$(ECHO_NOTHING)mv $(THEOS_STAGING_DIR)/Payload .$(ECHO_END)
	$(ECHO_NOTHING)zip -q -r decrypt.tipa Payload$(ECHO_END)
	$(ECHO_NOTHING)rm -rf Payload$(ECHO_END)