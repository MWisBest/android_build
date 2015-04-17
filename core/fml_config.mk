FML_ARM_OPT_LEVEL ?= -O2
FML_THUMB_OPT_LEVEL ?= -Os

FML_USE_STRICT_ALIASING ?= true
FML_STRICT_ALIASING_WARNLEVEL ?= 2

FML_ALIASING_FIXES ?= \
	bionic \
	external_stlport \
	frameworks_av \
	frameworks_base

FML_MAIN_STRICT_ALIASING_FLAGS := -Wstrict-aliasing=2
FML_ARM_STRICT_ALIASING_FLAGS := -fstrict-aliasing
FML_THUMB_STRICT_ALIASING_FLAGS := -fno-strict-aliasing
FML_NO_STRICT_ALIASING_MODULES := waefjioewaf

ifeq ($(FML_USE_STRICT_ALIASING),true)

FML_MAIN_STRICT_ALIASING_FLAGS := \
	-Wstrict-aliasing=$(FML_STRICT_ALIASING_WARNLEVEL) \
	-Werror=strict-aliasing

FML_ARM_STRICT_ALIASING_FLAGS := -fstrict-aliasing
FML_THUMB_STRICT_ALIASING_FLAGS := -fstrict-aliasing


FML_NO_STRICT_ALIASING_MODULES := \
	libziparchive \
	libpdfium \
	libpdfiumcore \
	dnsmasq \
	libstagefright_webm \
	logwrapper \
	logd \
	ping \
	ping6 \
	libtee_client_api_driver \
	libdiskconfig \
	libvariablespeed \
	libjavacore \
	librtp_jni \
	libwilhelm


ifneq (bionic,$(filter bionic,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	libc_bionic \
	libc_dns

# libc_dns extends to these as well via includes from it:
FML_NO_STRICT_ALIASING_MODULES += \
	clatd \
	tcpdump
endif


ifneq (external_stlport,$(filter external_stlport,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	libstlport \
	libstlport_static
endif


ifneq (frameworks_av,$(filter frameworks_av,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	libaudioflinger \
	libmediaplayerservice \
	libstagefright
endif

#TODO:
#These belong under the fw_av umbrella but aren't fixed up yet.
#Listed in order of priority.
FML_NO_STRICT_ALIASING_MODULES += \
	libmedia \
	libvisualizer \
	libdownmix \
	libldnhncr \


ifneq (frameworks_base,$(filter frameworks_base,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	libandroid_runtime \
	libandroidfw
endif

endif

