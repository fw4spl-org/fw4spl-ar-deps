cmake_minimum_required(VERSION 2.8)

project(freeGLUTBuilder)

include(ExternalProject)

getCachedUrl(https://github.com/dcnieho/FreeGLUT/archive/FG_3_0_0_RC2.tar.gz CACHED_URL)

set(FREEGLUT_CMAKE_ARGS ${COMMON_CMAKE_ARGS}
                      -DINSTALL_PDB:BOOL=OFF
                      -DFREEGLUT_BUILD_STATIC_LIBS:BOOL=OFF
                      -DFREEGLUT_REPLACE_GLUT:BOOL=ON
                      -DFREEGLUT_BUILD_DEMOS:BOOL=OFF
)

ExternalProject_Add(
    freeglut
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${FREEGLUT_CMAKE_ARGS}
)


