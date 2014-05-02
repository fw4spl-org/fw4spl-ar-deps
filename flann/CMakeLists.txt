CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

PROJECT(flannBuilder)

INCLUDE(ExternalProject)

GET_CACHED_URL(http://people.cs.ubc.ca/~mariusm/uploads/FLANN/flann-1.8.4-src.zip CACHED_URL)

SET(FLANN_CMAKE_ARGS    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} 
                        -DBUILD_C_BINDINGS:BOOL=OFF
                        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
)


ExternalProject_Add(
    flann
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${FLANN_CMAKE_ARGS}
)
