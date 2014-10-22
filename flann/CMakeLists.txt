cmake_minimum_required(VERSION 2.8)

project(flannBuilder)

include(ExternalProject)

getCachedUrl(http://people.cs.ubc.ca/~mariusm/uploads/FLANN/flann-1.8.4-src.zip CACHED_URL)

set(FLANN_CMAKE_ARGS    ${COMMON_CMAKE_ARGS}
                        -DBUILD_C_BINDINGS:BOOL=OFF
                        -DBUILD_MATLAB_BINDINGS:BOOL=OFF
                        -DBUILD_PYTHON_BINDINGS:BOOL=OFF
)

# Patch to disabled tests and examples (compilation error on win32)
set(FLANN_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)

ExternalProject_Add(
    flann
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${FLANN_CMAKE_ARGS}
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${FLANN_PATCH_DIR}/CMakeLists.txt ${CMAKE_CURRENT_BINARY_DIR}/flann-prefix/src/flann/CMakeLists.txt 
)
