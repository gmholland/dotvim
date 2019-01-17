flags = [
  '-x', 'c++',
  '-std=gnu++14',
  '-Wall',
  '-Wextra',
  # OpenMPI includes
  '-I', '/usr/lib/openmpi/include',
]

def Settings(**kwargs):
  return {
    'flags' : flags,
  }
