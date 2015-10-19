cmake_minimum_required(VERSION 3.0)

project(tango)

include(ExternalProject)

set(CACHED_URL https://owncloud.u-strasbg.fr/index.php/s/iQaSYt6vmBSPrKZ/download)


ExternalProject_Add(
    tango
    URL ${CACHED_URL}
    URL_HASH SHA1=ec9251a74bcd40043cb79aff5dd6ddf7c4b5efa6
    DOWNLOAD_NAME tango_api.zip
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    INSTALL_COMMAND ""
)

ExternalProject_Add_Step(tango copy_files
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_BINARY_DIR}/tango-prefix/src/tango/libtango_client_api.so  ${CMAKE_INSTALL_PREFIX}/lib/libtango_client_api.so 
    COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_CURRENT_BINARY_DIR}/tango-prefix/src/tango/tango_client_api.h   ${CMAKE_INSTALL_PREFIX}/include/tango_client_api.h
    WORKING_DIRECTORY ${CMAKE_INSTALL_PREFIX}
    DEPENDEES install
    )
