cmake_minimum_required(VERSION 3.0)

project(InfiniTAMBuild)

include(ExternalProject)

set(CACHED_URL https://github.com/fw4spl-org/InfiniTAM/archive/v0.1.tar.gz)

ExternalProject_Add(
    infinitam
    DEPENDS realsense
    URL ${CACHED_URL}
    URL_HASH SHA256=0cd5bcfee396b357ef8fddaaeef9edbd58876eb873b2b2811323665373c5b7fd
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DOWNLOAD_NAME InfiniTAM-v0.1.tar.gz
    DEPENDS ${REALSENSE_DEPENDS}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${COMMON_CMAKE_ARGS} -DWITH_GLUT=OFF
)


