cmake_minimum_required(VERSION 3.0)

project(realsense)

include(ExternalProject)

set(CACHED_URL https://github.com/fw4spl-org/librealsense/archive/v0.9.1.1.tar.gz)
    
set(REALSENSE_CMAKE_ARGS ${COMMON_CMAKE_ARGS}
                         -DBUILD_EXAMPLES=OFF
)
if(UNIX AND NOT APPLE)
    set(REALSENSE_DEPENDS libusb)
endif()

ExternalProject_Add(
    realsense
    URL ${CACHED_URL}
    URL_HASH SHA256=b137095c0ef53b7ed2f3d235eddb0992de86d0c69134f594c4acd3deda1d87ec
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DOWNLOAD_NAME librealsense-0.9.1.1.tar.gz
    DEPENDS ${REALSENSE_DEPENDS}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${REALSENSE_CMAKE_ARGS}
)


