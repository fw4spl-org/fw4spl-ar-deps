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
    DEPENDS itk vtk
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DOWNLOAD_NAME AuroraTracker-IGSTK.zip
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${IGSTKAURORA_CMAKE_ARGS}
)
