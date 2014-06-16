cmake_minimum_required(VERSION 2.8)

project(bulletBuilder)

include(ExternalProject)

set(BULLET_CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} 
                      -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                      -DBUILD_CPU_DEMOS:BOOL=OFF
                      -DBUILD_DEMOS:BOOL=OFF
                      -DBUILD_EXTRAS:BOOL=OFF
                      -DBUILD_MINICL_OPENCL_DEMOS:BOOL=OFF
                      -DUSE_GLUT:BOOL=OFF
                      -DINSTALL_LIBS:BOOL=ON
)

if(UNIX)
    list(APPEND BULLET_CMAKE_ARGS -DBUILD_SHARED_LIBS:BOOL=ON)
else(UNIX)
    list(APPEND BULLET_CMAKE_ARGS 
                -DCMAKE_DEBUG_POSTFIX:STRING=
                -DCMAKE_MINSIZEREL_POSTFIX:STRING=
    )
endif(UNIX)

getCachedUrl(http://bullet.googlecode.com/files/bullet-2.82-r2704.tgz CACHED_URL)

ExternalProject_Add(
    bullet
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${BULLET_CMAKE_ARGS}
    STEP_TARGETS CopyConfigFileToInstall
)

ExternalProject_Add_Step(bullet CopyConfigFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/findBinpkgs/FindBullet.cmake ${CMAKE_INSTALL_PREFIX}/FindBullet.cmake
    COMMENT "Install configuration file"
)
