cmake_minimum_required(VERSION 2.8)

project(ois)

include(ExternalProject)

getCachedUrl(http://freefr.dl.sourceforge.net/project/wgois/Source%20Release/1.3/ois_v1-3.tar.gz CACHED_URL)

set(OIS_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)
set(OIS_CMAKE_ARGS ${COMMON_CMAKE_ARGS}
                   -DBUILD_SHARED_LIBS:BOOL=ON
               )
               
set(OIS_PATCH_CMD 
    ${CMAKE_COMMAND} -E copy_if_different ${OIS_PATCH_DIR}/CMakeLists.txt <SOURCE_DIR>/CMakeLists.txt
)

if(APPLE)
    list(APPEND OIS_PATCH_CMD 
            COMMAND ${PATCH_EXECUTABLE} -p1 -i ${OIS_PATCH_DIR}/osx_fix.patch -d <SOURCE_DIR>
    )
endif()

ExternalProject_Add(
    ois
    URL ${CACHED_URL}
    URL_HASH SHA256=50fa76d827e119a80e2c86a5196ac4354e556f80b0a4fa440f69e1057b37faa1
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    PATCH_COMMAND ${OIS_PATCH_CMD}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${OIS_CMAKE_ARGS}
    STEP_TARGETS CopyConfigFileToInstall
)

