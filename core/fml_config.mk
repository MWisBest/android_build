FML_ARM_OPT_LEVEL ?= -O3
FML_THUMB_OPT_LEVEL ?= -O3

FML_USE_STRICT_ALIASING ?= true
FML_STRICT_ALIASING_WARNLEVEL ?= 2

FML_ALIASING_FIXES ?= \
	bionic \
	external_stlport \
	frameworks_av \
	frameworks_base

FML_OPT_FALLBACK_FIXES ?= \
	frameworks_av

FML_MAIN_STRICT_ALIASING_FLAGS := -Wstrict-aliasing=2
FML_ARM_STRICT_ALIASING_FLAGS := -fstrict-aliasing
FML_THUMB_STRICT_ALIASING_FLAGS := -fno-strict-aliasing
FML_NO_STRICT_ALIASING_MODULES := waefjioewaf
FML_O2_FALLBACK_MODULES := waefjioewaf
FML_OS_FALLBACK_MODULES := waefjioewaf


#####################
# -O2 fallback list #
#####################
ifeq ($(FML_ARM_OPT_LEVEL),-O3)

###############################################################################
# device/moto/shamu, dumb issue in camera junk
ifneq (device_moto_shamu,$(filter device_moto_shamu,$(FML_OPT_FALLBACK_FIXES)))
FML_O2_FALLBACK_MODULES += \
	mm-qcamera-app \
	camera.msm8084
endif
###############################################################################
#######################################################################
# frameworks/av, important.
ifneq (frameworks_av,$(filter frameworks_av,$(FML_OPT_FALLBACK_FIXES)))
FML_O2_FALLBACK_MODULES += \
	libstagefright_amrwbenc \
	libaudioflinger
endif
#######################################################################

endif

#####################
# -Os fallback list #
#####################
ifeq ($(FML_THUMB_OPT_LEVEL),-O3)

#####################################################################################################
# external/bluetooth/bluedroid
# O3 has been demonstrated to be unreliable here on numerous occasions
# can't really pinpoint an exact problem, but considering bluedroid's origins it isn't surprising.
ifneq (external_bluetooth_bluedroid,$(filter external_bluetooth_bluedroid,$(FML_OPT_FALLBACK_FIXES)))
FML_OS_FALLBACK_MODULES += \
	bluetooth.default
endif
#####################################################################################################
#######################################################################
# frameworks/av, important and fixable.
ifneq (frameworks_av,$(filter frameworks_av,$(FML_OPT_FALLBACK_FIXES)))
FML_OS_FALLBACK_MODULES += \
	libstagefright_m4vh263dec
endif
#######################################################################

endif


ifeq ($(FML_USE_STRICT_ALIASING),true)

FML_MAIN_STRICT_ALIASING_FLAGS := \
	-Wstrict-aliasing=$(FML_STRICT_ALIASING_WARNLEVEL) \
	-Werror=strict-aliasing

FML_ARM_STRICT_ALIASING_FLAGS := -fstrict-aliasing
FML_THUMB_STRICT_ALIASING_FLAGS := -fstrict-aliasing


FML_NO_STRICT_ALIASING_MODULES += \
	libtee_client_api_driver \
	librtp_jni


#####################################################
# bionic, very important!
ifneq (bionic,$(filter bionic,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	libc_bionic \
	libc_dns
# libc_dns extends to these as well via includes:
FML_NO_STRICT_ALIASING_MODULES += \
	clatd \
	tcpdump
endif
#####################################################
###########################################################################
# device/moto/shamu, dumb issue in camera junk...
ifneq (device_moto_shamu,$(filter device_moto_shamu,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	camera.msm8084
endif
###########################################################################
#########################################################################
# external/dnsmasq, not really important.
ifneq (external_dnsmasq,$(filter external_dnsmasq,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	dnsmasq
endif
#########################################################################
#########################################################################
# external/iputils, not really important.
ifneq (external_iputils,$(filter external_iputils,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	ping \
	ping6
endif
#########################################################################
#######################################################################
# external/pdfium, not really important.
ifneq (external_pdfium,$(filter external_pdfium,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	libpdfium \
	libpdfiumcore
endif
#######################################################################
#########################################################################
# external/stlport, good to have fixed.
ifneq (external_stlport,$(filter external_stlport,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	libstlport \
	libstlport_static
endif
#########################################################################
###################################################################
# frameworks/av, important.
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
	libstagefright_webm \
	libvisualizer \
	libdownmix \
	libldnhncr
###################################################################
#######################################################################
# frameworks/base, very important!
ifneq (frameworks_base,$(filter frameworks_base,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	libandroid_runtime \
	libandroidfw
endif
#######################################################################
###################################################################
# frameworks/ex, nice to have fixed.
ifneq (frameworks_ex,$(filter frameworks_ex,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	libvariablespeed
endif
###################################################################
#############################################################################
# frameworks/wilhelm, good to have fixed.
ifneq (frameworks_wilhelm,$(filter frameworks_wilhelm,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	libwilhelm
endif
#############################################################################
###############################################################################
# hardware/qcom/audio, who cares it's qcom.
ifneq (hardware_qcom_audio,$(filter hardware_qcom_audio,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	libqcomvisualizer
endif
###############################################################################
###########################################################################
# hardware/ti/omap4, *would* be great to have fixed.
ifneq (hardware_ti_omap4,$(filter hardware_ti_omap4,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	libdomx
endif
###########################################################################
#######################################################
# libcore, *would* be great to have fixed.
# but it's a pretty bad violater :/
ifneq (libcore,$(filter libcore,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	libjavacore
endif
#######################################################
#########################################################################################
# packages/apps/DSPManager, meh. fuck Cyanogen Inc.
ifneq (packages_apps_DSPManager,$(filter packages_apps_DSPManager,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	libcyanogen-dsp
endif
#########################################################################################
###############################################################
# system_core, *would* be great to have fixed.
ifneq (system_core,$(filter system_core,$(FML_ALIASING_FIXES)))
FML_NO_STRICT_ALIASING_MODULES += \
	libdiskconfig \
	libziparchive \
	logd \
	logwrapper
endif
###############################################################



endif
