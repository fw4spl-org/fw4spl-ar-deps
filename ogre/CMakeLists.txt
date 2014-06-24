cmake_minimum_required(VERSION 2.8)

project(ogre)

include(ExternalProject)

getCachedUrl(https://bitbucket.org/sinbad/ogre/get/v1-9-0.tar.bz2 CACHED_URL)

set(OGRE_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)
set(OGRE_CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} 
                    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                    -DBUILD_SHARED_LIBS:BOOL=ON
                    -DZLIB_ROOT=${CMAKE_INSTALL_PREFIX}
                    -DOIS_HOME:PATH=${DEP_OIS}
                    -DOGRE_USE_BOOST:BOOL=ON
                    -DOGRE_BUILD_SAMPLES:BOOL=OFF
                    -DOGRE_INSTALL_SAMPLES:BOOL=OFF
                    -DOGRE_INSTALL_SAMPLES_SOURCE:BOOL=OFF
                    -DOGRE_BUILD_TESTS:BOOL=OFF
                    -DOGRE_BUILD_TOOLS:BOOL=OFF
                    -DOGRE_INSTALL_TOOLS:BOOL=OFF
                    -DOGRE_COPY_DEPENDENCIES:BOOL=OFF
                    -DOGRE_BUILD_RENDERSYSTEM_GL:BOOL=ON
                    -DOGRE_BUILD_DOCS:BOOL=OFF
                    -DOGRE_INSTALL_DOCS:BOOL=OFF
                    -DOGRE_BUILD_PLUGIN_CG:BOOL=OFF
                    -DOGRE_INSTALL_DEPENDENCIES:BOOL=OFF
                    -DOGRE_CONFIG_ENABLE_ZIP:BOOL=ON
   )


ExternalProject_Add(
    ogre
    URL ${CACHED_URL}
    URL_HASH SHA256=3072df52b2bed2a1b52e969f140ae9a4373ec931029d3eaa032e7c609a91ef82
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS ois zzip
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${OGRE_CMAKE_ARGS}
    STEP_TARGETS CopyConfigFileToInstall
)

ExternalProject_Add_Step(ogre CopyConfigFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/cmake/fw-Ogre.cmake ${CMAKE_INSTALL_PREFIX}/fw-Ogre.cmake
    COMMENT "Install CMake helper file"
)

