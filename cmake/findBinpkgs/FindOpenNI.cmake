###############################################################################
# Find OpenNI
#
# This sets the following variables:
# OPENNI_FOUND - True if OPENNI was found.
# OPENNI_INCLUDE_DIRS - Directories containing the OPENNI include files.
# OPENNI_LIBRARIES - Libraries needed to use OPENNI.


find_package(PkgConfig QUIET)

# Find lib
find_library(OPENNI_LIBRARY 
	  NAMES OpenNI2
          PATH_SUFFIXES lib/openni2/
)

# Find include
find_path(OPENNI_INCLUDE_DIR 
	  NAMES OpenNI.h
          PATH_SUFFIXES include/openni2/
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenNI DEFAULT_MSG OPENNI_LIBRARY OPENNI_INCLUDE_DIR
)

mark_as_advanced(OPENNI_LIBRARY OPENNI_INCLUDE_DIR)



if(OPENNI_FOUND)
  # Add the include directories
  set(OPENNI_INCLUDE_DIRS ${OPENNI_INCLUDE_DIR})
  message(STATUS "OpenNI found (include: ${OPENNI_INCLUDE_DIRS}, lib: ${OPENNI_LIBRARIES})")
endif(OPENNI_FOUND)

