cmake_minimum_required(VERSION 2.8)

project(aramBuilder)

include(ExternalProject)

set(ARAM_CMAKE_ARGS 
    ${COMMON_CMAKE_ARGS}
    -DBUILD_SHARED_LIBS:BOOL=ON
)

getCachedUrl(https://github.com/greenjava/ARAM/archive/86d2a03746f953358d323b8a3ce9c3a5d2d640f1.tar.gz CACHED_URL)

ExternalProject_Add(
    aram
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS opencv
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${ARAM_CMAKE_ARGS}
    STEP_TARGETS CopyFindFileToInstall
)

ExternalProject_Add_Step(aram CopyFindFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/aram-prefix/src/ARAM/cmake/FindARAM.cmake 
                                     ${CMAKE_INSTALL_PREFIX}/FindARAM.cmake
    COMMENT "Install FindARAM file"
    DEPENDEES install
)

