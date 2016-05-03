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
    URL_HASH SHA256=238a61e1938340c4929f2d9af6db36c22c86a589a351f054c6ff5f4fab0c951b
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DOWNLOAD_NAME librealsense-0.9.1.1.tar.gz
    DEPENDS ${REALSENSE_DEPENDS}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${REALSENSE_CMAKE_ARGS}
)


