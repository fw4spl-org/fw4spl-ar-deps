cmake_minimum_required(VERSION 3.0)

project(orbslam2Builder)

include(ExternalProject)

set(CACHED_URL https://github.com/fw4spl-org/ORB_SLAM2/archive/5dd9ab18f96b47c6b7eb89890d1583484c5f4db7.tar.gz)
set(ORBSLAM2_CMAKE_ARGS ${COMMON_CMAKE_ARGS}
    -DPangolin_DIR=${CMAKE_INSTALL_PREFIX}
)

ExternalProject_Add(
    orbslam2
    URL ${CACHED_URL}
    URL_HASH SHA256=34086ca43282423ecdf2ff2414d50d32bcdc538ccb6209c2f8d6fb9c57ae5072
    DOWNLOAD_NAME orbslam2-0.1.tar.gz
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS opencv eigen pangolin
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${ORBSLAM2_CMAKE_ARGS} 
)
