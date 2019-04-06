# The pitools submodule contains the cross compiler for 64-bit hosts
tooldir:=$(OCPI_CDK_DIR)/../project-registry/qs.raspi/pitools/arm-bcm2708/arm-linux-gnueabihf/bin

# Configure the OpenCPI compile flags
OcpiCrossCompile=$(tooldir)/arm-linux-gnueabihf-
OcpiCFlags+=-mfpu=vfpv3-d16 -mfloat-abi=hard -march=armv7-a
OcpiCXXFlags+=-mfpu=vfpv3-d16 -mfloat-abi=hard -march=armv7-a
OcpiStaticProgramFlags=-rdynamic
#OcpiKernelDir=release/kernel-headers
OcpiPlatformOs=linux
OcpiPlatformOsVersion=pi3
OcpiPlatformArch=arm
