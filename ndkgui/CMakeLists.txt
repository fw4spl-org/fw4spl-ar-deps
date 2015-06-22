cmake_minimum_required(VERSION 2.8)

project(ndkgui)

include(ExternalProject)

getCachedUrl(https://github.com/FredChamp/ndkGui/archive/c250c4aaf21f670b2fd07a1a7f37efa725ac8df9.tar.gz CACHED_URL)

set(NDKGUI_CMAKE_ARGS ${COMMON_CMAKE_ARGS})

ExternalProject_Add(
    ndkgui
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${NDKGUI_CMAKE_ARGS}
)
set(NDKGUI_SRC_DIR ${CMAKE_CURRENT_BINARY_DIR}/ndkgui-prefix/src/ndkgui)
ExternalProject_Add_Step(ndkgui copy_java_files
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${NDKGUI_SRC_DIR}/src  ${CMAKE_INSTALL_PREFIX}/src
    WORKING_DIRECTORY ${CMAKE_INSTALL_PREFIX}
    DEPENDEES install
    )