cmake_minimum_required(VERSION 2.8)

project(igstkAuroraBuilder)

include(ExternalProject)

getCachedUrl(https://github.com/schweitzer/AuroraTracker-IGSTK/archive/master.zip CACHED_URL)

set(IGSTKAURORA_CMAKE_ARGS 
                    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} 
                    -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX} 
                    -DBUILD_SHARED_LIBS:BOOL=ON
)

ExternalProject_Add(
    igstkAurora
    URL ${CACHED_URL}
    DEPENDS itk vtk
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${IGSTKAURORA_CMAKE_ARGS}
)
