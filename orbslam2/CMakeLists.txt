cmake_minimum_required(VERSION 3.0)

project(orbslam2Builder)

include(ExternalProject)

set(CACHED_URL https://github.com/fw4spl-org/ORB_SLAM2/archive/79eef1bb894b0aed6f098e47c3c91a612e550d76.tar.gz)
set(ORBSLAM2_CMAKE_ARGS ${COMMON_CMAKE_ARGS}
    -DPangolin_DIR=${CMAKE_INSTALL_PREFIX}
)

ExternalProject_Add(
    orbslam2
    URL ${CACHED_URL}
    URL_HASH SHA256=233443715f5afca1747f99ff6bf6fbcd9e736b6bfb28d9cd92c6219dbb820a7f
    DOWNLOAD_NAME orbslam2-0.1.tar.gz
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS opencv eigen pangolin
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${ORBSLAM2_CMAKE_ARGS} 
)
