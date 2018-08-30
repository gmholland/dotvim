import os
import ycm_core

# These are the compilation flags that will be used in case there's no
# compilation database set (by default, one is not set).
# CHANGE THIS LIST OF FLAGS. YES, THIS IS THE DROID YOU HAVE BEEN LOOKING FOR.
flags = [
'-Wall',
'-Wundef',
'-Wstrict-prototypes',
'-Wno-trigraphs',
'-fno-strict-aliasing',
'-fno-common',
'-Werror-implicit-function-declaration',
'-Wno-format-security',
'-D__KERNEL__',
'-DMODULE',
'-x', 'c',
'-std=gnu89',
'-nostdinc',
'-I', '.',
]

# Set this to the root of the Linux tree
linux_src_dir = '/home/gmh7/RCL/fuse/dfuse/buildroot/output/build/linux-xilinx-v2016.4'

# Generated from printing $(LINUXINCLUDE) as defined in Linux Makefile
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

def AppendIncludeDirs(flags):
  for include_dir in include_dirs:
    flags.append('-I')
    flags.append(os.path.join(linux_src_dir, include_dir))


def AppendIncludeFiles(flags):
  for include_file in include_files:
    flags.append('-include')
    flags.append(os.path.join(linux_src_dir, include_file))


AppendIncludeDirs(flags)
AppendIncludeFiles(flags)

SOURCE_EXTENSIONS = [ '.c' ]
HEADER_EXTENSIONS = [ '.h' ]

def DirectoryOfFile(filename):
  return os.path.dirname( os.path.abspath( filename ) )


def MakeRelativePathsInFlagsAbsolute( flags, working_directory ):
  if not working_directory:
    return list( flags )
  new_flags = []
  make_next_absolute = False
  path_flags = [ '-isystem', '-I', '-iquote', '--sysroot=' ]
  for flag in flags:
    new_flag = flag

    if make_next_absolute:
      make_next_absolute = False
      if not flag.startswith( '/' ):
        new_flag = os.path.join( working_directory, flag )

    for path_flag in path_flags:
      if flag == path_flag:
        make_next_absolute = True
        break

      if flag.startswith( path_flag ):
        path = flag[ len( path_flag ): ]
        new_flag = path_flag + os.path.join( working_directory, path )
        break

    if new_flag:
      new_flags.append( new_flag )
  return new_flags


def IsHeaderFile( filename ):
  extension = os.path.splitext( filename )[ 1 ]
  return extension in HEADER_EXTENSIONS


# This is the entry point; this function is called by ycmd to produce flags for
# a file.
def FlagsForFile( filename, **kwargs ):
  relative_to = DirectoryOfFile(filename)
  final_flags = MakeRelativePathsInFlagsAbsolute( flags, relative_to )

  return {
    'flags': final_flags,
    'do_cache': True
  }
