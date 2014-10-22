cmake_minimum_required(VERSION 2.8)

project(ogre)

include(ExternalProject)

getCachedUrl(https://bitbucket.org/sinbad/ogre/get/v1-9-0.tar.bz2 CACHED_URL)

set(OGRE_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)
set(OGRE_CMAKE_ARGS ${COMMON_CMAKE_ARGS}
                    -DBUILD_SHARED_LIBS:BOOL=ON
                    -DZLIB_ROOT=${CMAKE_INSTALL_PREFIX}
                    -DOIS_HOME:PATH=${CMAKE_INSTALL_PREFIX}
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
                    -DOGRE_CONFIG_ENABLE_FREEIMAGE:BOOL=ON
   )
if(WIN32)
    set(OGRE_CMAKE_ARGS ${OGRE_CMAKE_ARGS} -DOGRE_INSTALL_PDB:BOOL=OFF)
endif()

ExternalProject_Add(
    ogre
    URL ${CACHED_URL}
    URL_HASH SHA256=3072df52b2bed2a1b52e969f140ae9a4373ec931029d3eaa032e7c609a91ef82
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS ois zzip freeimage
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${OGRE_CMAKE_ARGS}
    STEP_TARGETS CopyConfigFileToInstall
)

if(WIN32)
    ExternalProject_Add_Step(ogre PatchCMake
        COMMAND ${CMAKE_COMMAND} -DINPUT_FILE:PATH=<SOURCE_DIR>/CMake/Utils/PrecompiledHeader.cmake
                                 -DSEARCH:STRING=MSVC
                                 -DREPLACEMENT_TEXT:STRING=MSVC_IDE
                                 -P ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/patch.cmake
        DEPENDEES download 
        COMMENT "Patch PrecompiledHeader.cmake"
    )
endif()

ExternalProject_Add_Step(ogre CopyConfigFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/cmake/fw-Ogre.cmake ${CMAKE_INSTALL_PREFIX}/fw-Ogre.cmake
    COMMENT "Install CMake helper file"
)

