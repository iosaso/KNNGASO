export THEOS=/opt/theos/
export THEOS_DEVICE_IP=192.168.1.2



include $(THEOS)/makefiles/common.mk




# THEOS_DEVICE_IP = 192.168.2.29
# THEOS_DEVICE_IP = 192.168.3.143
# THEOS_DEVICE_IP = 192.168.2.177
# THEOS_DEVICE_IP = 192.168.2.149
# THEOS_DEVICE_IP = 192.168.2.219
# THEOS_DEVICE_IP = 192.168.3.130
# THEOS_DEVICE_IP = 192.168.3.226
# THEOS_DEVICE_IP = 192.168.2.149
# THEOS_DEVICE_IP = 192.168.3.224
# THEOS_DEVICE_IP = 192.168.3.232
# THEOS_DEVICE_IP = 192.168.1.23
# THEOS_DEVICE_IP = 192.168.1.18
THEOS_DEVICE_IP = 192.168.1.104


TWEAK_NAME = NGASO

NGASO_FILES = Tweak.xm

# 注入点
NGASO_FILES += ASO/DecantingPoint.m
# 10的弹出框拦截 采用触碰的方式
NGASO_FILES += ASO/AlertManager/AlertManageByUsedVersionTenUp.m

# 项目
NGASO_FILES += ASO/SBViewManager.m
NGASO_FILES += ASO/GeneralUtil.m
NGASO_FILES += ASO/AlertManager.m
NGASO_FILES += ASO/AsoManager.m
NGASO_FILES += ASO/AsoBase.m
NGASO_FILES += ASO/ProcessCmd.m
NGASO_FILES += ASO/NetServer.m
NGASO_FILES += ASO/ProcessMsgsnd.m
NGASO_FILES += ASO/CFNotificManager.m
NGASO_FILES += ASO/OCRManager.m
NGASO_FILES += ASO/TimerManager.m
NGASO_FILES += ASO/ASBase.m
NGASO_FILES += ASO/ASManager.m
NGASO_FILES += ASO/SBBase.m
NGASO_FILES += ASO/SBManager.m
NGASO_FILES += ASO/ITManager.m
NGASO_FILES += ASO/ScanningController.m


# RAS加密  AES加密
NGASO_FILES += ASO/Security/RSAEncryptor.m
NGASO_FILES += ASO/Security/LanAES.m
NGASO_FILES += ASO/Security/NSString+Security.m
NGASO_FILES += ASO/Security/NSData+Security.m
NGASO_FILES += ASO/Security/GTMBase64/GTMBase64.m
NGASO_FILES += ASO/Security/SecurityUtil.m
NGASO_FILES += ASO/Security/NSString+MD5.m
NGASO_FILES += ASO/Security/NSData+AES.m
NGASO_FILES += ASO/Security/CWAESEncryptData.m




# NGASO_FILES += ASO/Security/CocoaSecurityResult.m



# 二维码扫描
# NGASO_FILES += ASO/Scanning/Category/UIImage+ImageSize.m
# NGASO_FILES += ASO/Scanning/SGQRCodeAlbumManager.m
# NGASO_FILES += ASO/Scanning/SGQRCodeGenerateManager.m
# NGASO_FILES += ASO/Scanning/SGQRCodeHelperTool.m
# NGASO_FILES += ASO/Scanning/SGQRCodeScanManager.m
# NGASO_FILES += ASO/Scanning/SGQRCodeScanningView.m

# Circle头文件
NGASO_FILES += ASO/circle/SSTCircleButton.m
NGASO_FILES += ASO/circle/SSTCircleImageView.m
NGASO_FILES += ASO/circle/SSTCircleView.m
NGASO_FILES += ASO/circle/SSTCircleWrapperView.m

# 改码的未见
NGASO_FILES += ASO/ChangeCode/ChangeCode.m
# NGASO_FILES += ASO/ChangeCode/UIDevice+Extensions.mm

NGASO_FRAMEWORKS = Foundation UIKit CoreFoundation CoreGraphics MobileCoreServices IOKit  CoreTelephony

NGASO_CFLAGS    = -F /Users/apple/Documents/NGASO/lib  -Wno-ignored-attributes -Wno-unused-variable -Wno-unused-function

# NGASO_LDFLAGS = -lDestopTouch -L /Users/admin/Documents/NGASO/
NGASO_LDFLAGS   =  -lz -L. -v -force_load ./libcapstone.a  -L  /Users/apple/Documents/NGASO/
# 链接FrameWork
NGASO_LDFLAGS  += -F /Users/apple/Documents/NGASO/lib  -framework PTFakeTouch -miphoneos-version-min=6.0 -rpath /Users/apple/Documents/NGASO/lib


include $(THEOS_MAKE_PATH)/tweak.mk


# 几维安全
# TARGET_CC   =   /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang   -fla=99 -kce-xfla=5 -kce-xbcf=99
# TARGET_CXX  =   /usr/bin/clang++
# TARGET_LD   =   /usr/bin/clang++

# TARGET_CC   =   /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang   -fla=99
# TARGET_CXX  =   /Users/admin/Documents/File/kiwisec-obfucate-commandline-1.3.1.20171219/wrapper/clang++
# TARGET_LD   =   /Users/admin/Documents/File/kiwisec-obfucate-commandline-1.3.1.20171219/wrapper/clang++




# 逻辑混淆
# TARGET_CC = /Users/admin/Documents/build/bin/clang
# TARGET_CXX = /Users/admin/Documents/build/bin/clang++
# TARGET_LD = /Users/admin/Documents/build/bin/clang++
# _THEOS_TARGET_CFLAGS += -mllvm  -fla
# _THEOS_TARGET_CFLAGS += -mllvm  -sub
# _THEOS_TARGET_CFLAGS += -mllvm  -bcf
# _THEOS_TARGET_CFLAGS += -mllvm  -sobf


# 字符串混淆


# 方法名混淆


after-install::
	install.exec "killall -9 SpringBoard"
