cmake_minimum_required(VERSION 3.0)

project(aramBuilder)

include(ExternalProject)

set(ARAM_CMAKE_ARGS
    ${COMMON_CMAKE_ARGS}
    -DBUILD_SHARED_LIBS:BOOL=ON
)

set (CACHED_URL https://github.com/AltranResearchMedica/ARAM/archive/c147bbe8aff2fb5be63e1c6d3875c15bb3dab356.tar.gz)

ExternalProject_Add(
    aram
    URL ${CACHED_URL}
    URL_HASH SHA256=8acab29f6ed6046b52031976bc15238c3952209903749972cbd43417b8d4a4e1
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
