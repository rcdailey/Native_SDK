LOCAL_PATH := $(call my-dir)/../../../../../../../..
PVRSDKDIR := $(realpath $(LOCAL_PATH))

ASSETDIR := $(PVRSDKDIR)/Examples/Intermediate/UserClipPlanes/OGLES/Build/Android/assets

CPY := cp
SEPARATOR := /
ifeq ($(HOST_OS),windows)
CPY := copy
SEPARATOR := \\
endif

# Module OGLESUserClipPlanes
include $(CLEAR_VARS)

LOCAL_MODULE    := OGLESUserClipPlanes

### Add all source file names to be included in lib separated by a whitespace
LOCAL_SRC_FILES  := Examples/Intermediate/UserClipPlanes/OGLES/OGLESUserClipPlanes.cpp \
                    Shell/PVRShell.cpp \
                    Shell/API/KEGL/PVRShellAPI.cpp \
                    Shell/OS/Android/PVRShellOS.cpp

LOCAL_C_INCLUDES := $(PVRSDKDIR)/Shell \
                    $(PVRSDKDIR)/Shell/API/KEGL \
                    $(PVRSDKDIR)/Shell/OS/Android \
                    $(PVRSDKDIR)/Builds/Include \
                    $(PVRSDKDIR)/Tools \
                    $(PVRSDKDIR)/Tools/OGLES

LOCAL_CFLAGS := -DBUILD_OGLES

LOCAL_LDLIBS := -llog \
                -landroid \
                -lEGL \
                -lGLESv1_CM

LOCAL_STATIC_LIBRARIES := android_native_app_glue \
                          oglestools

include $(BUILD_SHARED_LIBRARY)

$(call import-module,android/native_app_glue)

### Copy our external files to the assets folder, but only do it for the first abi
ifeq ($(TARGET_ARCH_ABI),$(firstword $(NDK_APP_ABI)))

all:  \
	$(ASSETDIR)/Mesh.pod \
	$(ASSETDIR)/Granite.pvr

$(ASSETDIR):
	-mkdir "$(ASSETDIR)"

$(ASSETDIR)/Granite.pvr: $(PVRSDKDIR)/Examples/Intermediate/UserClipPlanes/OGLES/Granite.pvr $(ASSETDIR)
	$(CPY) $(subst /,$(SEPARATOR),"$<" "$(ASSETDIR)")

$(ASSETDIR)/Mesh.pod: $(PVRSDKDIR)/Examples/Intermediate/UserClipPlanes/OGLES/Mesh.pod $(ASSETDIR)
	$(CPY) $(subst /,$(SEPARATOR),"$<" "$(ASSETDIR)")

endif

