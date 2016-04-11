cmake_minimum_required(VERSION 3.0)

project(ogre)

include(ExternalProject)

set(CACHED_URL https://bitbucket.org/fw4splorg/ogre-fw4spl/get/v1-10.tar.bz2)
set(OGRE_HASH 36ae20a359d7a1839ae02e83f6609bd6a6a6f20b3481427030b579a5d8e755e6)

include( ${CMAKE_SOURCE_DIR}/cmake/findBinpkgs/fw-boost.cmake )

set(OGRE_CMAKE_ARGS ${COMMON_CMAKE_ARGS}
                    -DBUILD_SHARED_LIBS:BOOL=ON
                    -DOIS_HOME:PATH=${CMAKE_INSTALL_PREFIX}
                    -DOGRE_USE_BOOST:BOOL=ON
                    -DOGRE_BUILD_SAMPLES:BOOL=OFF
                    -DOGRE_INSTALL_SAMPLES:BOOL=OFF
                    -DOGRE_INSTALL_SAMPLES_SOURCE:BOOL=OFF
                    -DOGRE_BUILD_TESTS:BOOL=OFF
                    -DOGRE_BUILD_TOOLS:BOOL=OFF
                    -DOGRE_INSTALL_TOOLS:BOOL=OFF
                    -DOGRE_COPY_DEPENDENCIES:BOOL=OFF
                    -DOGRE_BUILD_RENDERSYSTEM_GL:BOOL=OFF
                    -DOGRE_BUILD_RENDERSYSTEM_GL3PLUS:BOOL=ON
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
    list(APPEND OGRE_PATCH_CMD COMMAND ${CMAKE_COMMAND} -E copy_if_different "${OGRE_PATCH_DIR}/PrecompiledHeader.cmake" "<SOURCE_DIR>/CMake/Utils/PrecompiledHeader.cmake")
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
)

