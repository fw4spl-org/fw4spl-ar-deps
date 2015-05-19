###############################################################################
# Find OpenNI
#
# This sets the following variables:
# OPENNI_FOUND - True if OPENNI was found.
# OPENNI_INCLUDE_DIRS - Directories containing the OPENNI include files.
# OPENNI_LIBRARIES - Libraries needed to use OPENNI.

find_package(PkgConfig QUIET)

# Find lib
find_library(OPENNI2_LIBRARY
    NAMES OpenNI2
    PATH_SUFFIXES lib/openni2/
)

# Find include
find_path(OPENNI2_INCLUDE_DIR
    NAMES OpenNI.h
    PATH_SUFFIXES include/openni2/
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(OpenNI DEFAULT_MSG OPENNI2_LIBRARY OPENNI2_INCLUDE_DIR
)

mark_as_advanced(OPENNI2_LIBRARY OPENNI2_INCLUDE_DIR)



if(OPENNI_FOUND)
# Add the include directories
    set(OPENNI2_INCLUDE_DIRS ${OPENNI2_INCLUDE_DIR})
    message(STATUS "OpenNI found (include: ${OPENNI2_INCLUDE_DIRS}, lib: ${OPENNI2_LIBRARIES})")
endif()
