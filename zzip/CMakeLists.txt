cmake_minimum_required(VERSION 2.8)

project(zzip)

include(ExternalProject)

set(ZZIP_VERSION 0.13.62)

getCachedUrl(http://freefr.dl.sourceforge.net/project/zziplib/zziplib13/${ZZIP_VERSION}/zziplib-${ZZIP_VERSION}.tar.bz2 CACHED_URL)

set(ZZIP_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)
set(ZZIP_CMAKE_ARGS ${COMMON_CMAKE_ARGS}
                    -DBUILD_SHARED_LIBS:BOOL=ON
)

set(ZZIP_PATCH_CMD ${CMAKE_COMMAND} -E copy_if_different "${ZZIP_PATCH_DIR}/CMakeLists.txt" "<SOURCE_DIR>/CMakeLists.txt")

if(APPLE)
list(APPEND ZZIP_PATCH_CMD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different "${ZZIP_PATCH_DIR}/fetch.h" "<SOURCE_DIR>/zzip/fetch.h")
endif()

ExternalProject_Add(
    zzip
    URL ${CACHED_URL}
    URL_HASH SHA256=a1b8033f1a1fd6385f4820b01ee32d8eca818409235d22caf5119e0078c7525b
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS zlib
    PATCH_COMMAND ${ZZIP_PATCH_CMD}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${ZZIP_CMAKE_ARGS}
    STEP_TARGETS CopyConfigFileToInstall
)

