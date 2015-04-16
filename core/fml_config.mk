FML_ARM_OPT_LEVEL ?= -O2
FML_THUMB_OPT_LEVEL ?= -Os

FML_USE_STRICT_ALIASING ?= true
FML_STRICT_ALIASING_WARNLEVEL ?= 2

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
	libc_bionic \
	libc_dns \
	libstlport \
	libziparchive \
	libandroid_runtime \
	libandroidfw \
	libpdfium \
	libpdfiumcore \
	libmedia \
	dnsmasq \
	clatd \
	libstagefright_webm \
	logwrapper \
	logd \
	libaudioflinger \
	libmediaplayerservice \
	libstagefright \
	ping \
	ping6 \
	libtee_client_api_driver \
	libdiskconfig \
	libvariablespeed \
	libjavacore \
	librtp_jni \
	libwilhelm \
	libdownmix \
	libldnhncr \
	libvisualizer \
	libstlport_static \
	tcpdump


endif
