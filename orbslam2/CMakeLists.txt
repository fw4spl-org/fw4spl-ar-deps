cmake_minimum_required(VERSION 3.0)

project(orbslam2Builder)

include(ExternalProject)

set(CACHED_URL https://github.com/fw4spl-org/ORB_SLAM2/archive/dcafeef997771ef404f47f5675871c7e465b1a2f.tar.gz)
set(ORBSLAM2_CMAKE_ARGS ${COMMON_CMAKE_ARGS}
    -DPangolin_DIR=${CMAKE_INSTALL_PREFIX}
)

ExternalProject_Add(
    orbslam2
    URL ${CACHED_URL}
    URL_HASH SHA256=e581e4b160f9e2d2414409904a3d4abc2ee08dc44716e283e5aed59e7b1bf77c
    DOWNLOAD_NAME orbslam2-0.1.tar.gz
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS opencv eigen pangolin
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${ORBSLAM2_CMAKE_ARGS} 
)

