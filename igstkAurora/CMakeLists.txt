cmake_minimum_required(VERSION 3.0)

project(igstkAuroraBuilder)

include(ExternalProject)

set(CACHED_URL https://github.com/schweitzer/AuroraTracker-IGSTK/archive/master.zip)

set(IGSTKAURORA_CMAKE_ARGS  ${COMMON_CMAKE_ARGS}
                            -DBUILD_SHARED_LIBS:BOOL=ON
)

ExternalProject_Add(
    igstkAurora
    URL ${CACHED_URL}
    URL_HASH SHA256=9c2bf709a6a85458d6801f9309e7a3879b87a94febe8415e32eb4c57448407bd
    DEPENDS itk vtk
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DOWNLOAD_NAME AuroraTracker-IGSTK.zip
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${IGSTKAURORA_CMAKE_ARGS}
)
