import os.path as p

DIR_OF_THIS_SCRIPT = p.abspath(p.dirname(__file__ ))

# Set this to the root of the Linux source tree
LINUX_SRC_DIR = '/home/gmh7/RCL/cfuse/buildroot/output/build/linux-xilinx-v2016.4'

# Default compiler flags
flags = [
  # Kernel related
  '-nostdinc',
  '-x', 'c',
  '-std=gnu89',
  '-Wall',
  '-Wundef',
  '-Wstrict-prototypes',
  '-Wno-trigraphs',
  '-fno-strict-aliasing',
  '-fno-common',
  '-Werror-implicit-function-declaration',
  '-Wno-format-security',
  '-D__KERNEL__',
  # Kernel module related
  '-DMODULE',
  # ARM related
  '-isystem', '/home/gmh7/RCL/cfuse/buildroot/output/host/opt/ext-toolchain/lib/gcc/arm-linux-gnueabihf/5.3.1/include',
  '-D__LINUX_ARM_ARCH__=7',
  '-target', 'armv7a-unknown-linux-gnueabihf',
  # Project specific
]

# Includes from the Linux source tree
# Generated from printing $(LINUXINCLUDE) and $(USERINCLUDE) variables from the
# top-level Linux Makefile
include_dirs = [
  'arch/arm/include',
  'arch/arm/include/generated',
  'arch/arm/include/generated/uapi',
  'arch/arm/include/uapi',
  'include',
  'include/generated/uapi',
  'include/uapi',
]

include_files = [
  'include/linux/kconfig.h'
]

# This is the entry point; this function is called by ycmd to produce flags for
# a file.
def Settings(**kwargs):
  for include_dir in include_dirs:
    flags.append('-isystem')
    flags.append(p.join(LINUX_SRC_DIR, include_dir))

  for include_file in include_files:
    flags.append('-include')
    flags.append(p.join(LINUX_SRC_DIR, include_file))

  return {
    'flags': flags,
    'include_paths_relative_to_dir': DIR_OF_THIS_SCRIPT
  }
