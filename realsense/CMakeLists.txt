cmake_minimum_required(VERSION 3.0)

project(realsense)

include(ExternalProject)

set(CACHED_URL https://github.com/fw4spl-org/librealsense/archive/v0.9.1.1.tar.gz)
    
set(REALSENSE_CMAKE_ARGS ${COMMON_CMAKE_ARGS}
                         -DBUILD_EXAMPLES=OFF
)
if(UNIX)
    set(REALSENSE_DEPENDS libusb)
endif()

ExternalProject_Add(
    realsense
    URL ${CACHED_URL}
    URL_HASH SHA256=2d46d5dd34c828f356af6a09fe3fe182845d389f074e85c50f5c81cccf14beaf
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DOWNLOAD_NAME librealsense-0.9.1.1.tar.gz
    DEPENDS ${REALSENSE_DEPENDS}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${REALSENSE_CMAKE_ARGS}
)


