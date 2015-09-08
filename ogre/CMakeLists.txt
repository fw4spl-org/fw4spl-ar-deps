cmake_minimum_required(VERSION 3.0)

project(ogre)

include(ExternalProject)

set(CACHED_URL https://bitbucket.org/sinbad/ogre/get/ef3d24815985.tar.bz2)
set(OGRE_HASH 8e94504ea98f0ce01ae913190250eebd5432daf08e05aee2c9181f8f4865a8d4)

include( ${CMAKE_SOURCE_DIR}/cmake/findBinpkgs/fw-boost.cmake )

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
                    -DOGRE_BUILD_RENDERSYSTEM_GL3PLUS:BOOL=ON
                    -DOGRE_BUILD_DOCS:BOOL=OFF
                    -DOGRE_INSTALL_DOCS:BOOL=OFF
                    -DOGRE_BUILD_PLUGIN_CG:BOOL=OFF
                    -DOGRE_INSTALL_DEPENDENCIES:BOOL=OFF
                    -DOGRE_CONFIG_ENABLE_ZIP:BOOL=ON
                    -DOGRE_CONFIG_ENABLE_FREEIMAGE:BOOL=ON
                    -DOGRE_BUILD_RENDERSYSTEM_D3D9:BOOL=OFF
                    -DOGRE_BUILD_PLATFORM_APPLE_IOS:BOOL=OFF
                    -DBoost_COMPILER:STRING=${Boost_COMPILER}
                    -DBoost_USE_DEBUG_PYTHON:BOOL=TRUE
                    -DBOOST_ROOT:PATH=${CMAKE_INSTALL_PREFIX}
                    -DBOOST_INCLUDEDIR:PATH=${CMAKE_INSTALL_PREFIX}/include/boost-${BOOST_VERSION}
   )



if(WIN32)
    set(OGRE_CMAKE_ARGS ${OGRE_CMAKE_ARGS} -DOGRE_INSTALL_PDB:BOOL=OFF)
endif()

set(OGRE_PATCH_CMD ${CMAKE_COMMAND} -E copy_if_different "${OGRE_PATCH_DIR}/CMakeLists.txt" "<SOURCE_DIR>/CMakeLists.txt"
    COMMAND ${CMAKE_COMMAND} -E copy_if_different "${OGRE_PATCH_DIR}/PrecompiledHeader.cmake" "<SOURCE_DIR>/CMake/Utils/PrecompiledHeader.cmake"
)

if(APPLE)

    set(OGRE_PATCH_CMD
        ${PATCH_EXECUTABLE} -p1 -i ${OGRE_PATCH_DIR}/fix-1.9-HEAD.patch -d <SOURCE_DIR>
        COMMAND ${PATCH_EXECUTABLE} -p1 -i ${OGRE_PATCH_DIR}/ogre1.9.patch -d <SOURCE_DIR>
        COMMAND ${PATCH_EXECUTABLE} -p1 -i ${OGRE_PATCH_DIR}/OgreConfigTargets.patch -d <SOURCE_DIR>
    )
    list(APPEND OGRE_CMAKE_ARGS 
    -DCMAKE_OSX_ARCHITECTURES='x86_64'
)

endif()

ExternalProject_Add(
    ogre
    URL ${CACHED_URL}
    URL_HASH SHA256=${OGRE_HASH}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DOWNLOAD_NAME v1-10-0.tar.bz2
    DEPENDS zzip freeimage boost
    PATCH_COMMAND ${OGRE_PATCH_CMD}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${OGRE_CMAKE_ARGS}
    STEP_TARGETS CopyConfigFileToInstall
)

ExternalProject_Add_Step(ogre CopyConfigFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/cmake/fw-Ogre.cmake ${CMAKE_INSTALL_PREFIX}/fw-Ogre.cmake
    COMMENT "Install CMake helper file"
)
