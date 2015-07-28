cmake_minimum_required(VERSION 3.0)

project(ndkgui)

include(ExternalProject)

set(CACHED_URL https://github.com/FredChamp/ndkGui/archive/fdaca972d10eb959199b089e6bc2b152de37c9fd.tar.gz)

set(NDKGUI_CMAKE_ARGS ${COMMON_CMAKE_ARGS})

ExternalProject_Add(
    ndkgui
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DOWNLOAD_NAME ndkGui.tar.gz
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${NDKGUI_CMAKE_ARGS}
)
set(NDKGUI_SRC_DIR ${CMAKE_CURRENT_BINARY_DIR}/ndkgui-prefix/src/ndkgui)
ExternalProject_Add_Step(ndkgui copy_java_files
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${NDKGUI_SRC_DIR}/src  ${CMAKE_INSTALL_PREFIX}/src
    WORKING_DIRECTORY ${CMAKE_INSTALL_PREFIX}
    DEPENDEES install
    )
