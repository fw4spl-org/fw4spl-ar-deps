cmake_minimum_required(VERSION 3.0)

project(ndkgui)

include(ExternalProject)

set(CACHED_URL https://github.com/FredChamp/ndkGui/archive/fdaca972d10eb959199b089e6bc2b152de37c9fd.tar.gz)

set(NDKGUI_CMAKE_ARGS ${COMMON_CMAKE_ARGS})

ExternalProject_Add(
    ndkgui
    URL ${CACHED_URL}
    URL_HASH SHA256=a93d7021e24a7ad2204d1e39eb76cac2c2e0c484b1bad836435548c1e2191223
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
