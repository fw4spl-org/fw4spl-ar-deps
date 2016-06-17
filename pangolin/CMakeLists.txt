cmake_minimum_required(VERSION 3.0)

project(pangolinBuilder)

include(ExternalProject)

set(CACHED_URL https://github.com/stevenlovegrove/Pangolin/archive/v0.3.tar.gz)

set(PANGOLIN_CMAKE_ARGS ${COMMON_CMAKE_ARGS}
    -DBUILD_SHARED_LIBS=True
    -DCPP11_NO_BOOST=True
    -DBUILD_PANGOLIN_VIDEO=True
    -DBUILD_PANGOLIN_GUI=True
    -DBUILD_EXAMPLES=False
    -DBUILD_EXTERN_GLEW=False
    -DBUILD_EXTERN_LIBJPEG=False
    -DBUILD_EXTERN_LIBPNG=False
)

if(UNIX AND NOT APPLE)
    set(PANGOLIN_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)
    set(PANGOLIN_PATCH_CMD "${PATCH_EXECUTABLE}" -p1 -i ${PANGOLIN_PATCH_DIR}/CMakeLists.diff -d <SOURCE_DIR>)
endif()

ExternalProject_Add(pangolin
    URL ${CACHED_URL}
    URL_HASH SHA256=8881c1102671ea99c241b273474ca7a5b3377fbde9c7d376253424c36d8ed678
    DOWNLOAD_NAME pangolin-0.3.tar.gz
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    PATCH_COMMAND ${PANGOLIN_PATCH_CMD}
    DEPENDS glew python eigen jpeg libpng
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${PANGOLIN_CMAKE_ARGS}
)

if(WIN32)
    ExternalProject_Add_Step(pangolin pangolinExportInstall
        COMMAND ${CMAKE_COMMAND} -E copy "${CMAKE_CURRENT_BINARY_DIR}/Pangolin-prefix/src/Pangolin-build/src/include/pangolin/pangolin_export.h"
                "${CMAKE_INSTALL_PREFIX}/include/pangolin/pangolin_export.h"
        COMMENT "Install pangolin_export"
        DEPENDEES install)
endif()
