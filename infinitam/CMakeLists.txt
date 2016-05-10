cmake_minimum_required(VERSION 3.0)

project(InfiniTAMBuild)

include(ExternalProject)

set(CACHED_URL https://github.com/fw4spl-org/InfiniTAM/archive/v0.1.tar.gz)

ExternalProject_Add(
    infinitam
    DEPENDS realsense
    URL ${CACHED_URL}
    URL_HASH SHA256=6a5e690018fb8a33599e5bd9ce309836085c4887a6274c9db830ae59482578ab
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DOWNLOAD_NAME InfiniTAM-v0.1.tar.gz
    DEPENDS ${REALSENSE_DEPENDS}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${COMMON_CMAKE_ARGS} -DWITH_GLUT=OFF
)


