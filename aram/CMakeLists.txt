cmake_minimum_required(VERSION 3.0)

project(aramBuilder)

include(ExternalProject)

set(ARAM_CMAKE_ARGS
    ${COMMON_CMAKE_ARGS}
    -DBUILD_SHARED_LIBS:BOOL=ON
)

set (CACHED_URL https://github.com/schweitzer/ARAM/archive/v1.0.tar.gz)

ExternalProject_Add(
    aram
    URL ${CACHED_URL}
    #URL_HASH SHA256=8acab29f6ed6046b52031976bc15238c3952209903749972cbd43417b8d4a4e1
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS opencv
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${ARAM_CMAKE_ARGS}
)

ExternalProject_Add_Step(aram CopyFindFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/aram-prefix/src/aram/cmake/FindARAM.cmake
                                     ${CMAKE_INSTALL_PREFIX}/FindARAM.cmake
    COMMENT "Install FindARAM file"
    DEPENDEES install
)
