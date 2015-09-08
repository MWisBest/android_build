# Configuration for Linux on ARM.
# Generating binaries for the ARMv7-a architecture and higher with NEON
#
ARCH_ARM_HAVE_ARMV7A            := true
ARCH_ARM_HAVE_VFP               := true
ARCH_ARM_HAVE_VFP_D32           := true
ARCH_ARM_HAVE_NEON              := true

# If only -mcpu is specified, random -march flags could end up overriding it.
# So, explicitly specify armv7-a to try and fix this where possible.
arch_variant_cflags := -march=armv7-a

ifneq (,$(filter cortex-a15 krait denver,$(TARGET_$(combo_2nd_arch_prefix)CPU_VARIANT)))
	arch_variant_cflags := -mcpu=cortex-a15 -mtune=cortex-a15
else
ifeq ($(strip $(TARGET_$(combo_2nd_arch_prefix)CPU_VARIANT)),cortex-a9)
	arch_variant_cflags += -mcpu=cortex-a9 -mtune=cortex-a9
else
ifeq ($(strip $(TARGET_$(combo_2nd_arch_prefix)CPU_VARIANT)),cortex-a8)
	arch_variant_cflags += -mcpu=cortex-a8 -mtune=cortex-a8
else
ifeq ($(strip $(TARGET_$(combo_2nd_arch_prefix)CPU_VARIANT)),cortex-a7)
	arch_variant_cflags += -mcpu=cortex-a7 -mtune=cortex-a7
endif
endif
endif
endif


arch_variant_cflags += \
	-mfloat-abi=softfp

ifeq ($(strip $(TARGET_$(combo_2nd_arch_prefix)FPU_VARIANT)),)
arch_variant_cflags += \
	-mfpu=neon
else
arch_variant_cflags += \
	-mfpu=$(TARGET_$(combo_2nd_arch_prefix)FPU_VARIANT)
ifeq ($(strip $(TARGET_$(combo_2nd_arch_prefix)FPU_VARIANT)),neon-fp16)
	ARCH_ARM_HAVE_NEON_FP16 := true
endif
endif


ifeq ($(strip $(TARGET_$(combo_2nd_arch_prefix)CPU_VARIANT)),cortex-a8)
arch_variant_ldflags := \
	-Wl,--fix-cortex-a8
else
arch_variant_ldflags := \
	-Wl,--no-fix-cortex-a8
endif
