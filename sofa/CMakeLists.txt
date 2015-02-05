cmake_minimum_required(VERSION 2.8)

project(sofaBuilder)

include(ExternalProject)

include( ${CMAKE_SOURCE_DIR}/cmake/findBinpkgs/fw-boost.cmake )

set(SOFA_CMAKE_ARGS ${COMMON_CMAKE_ARGS}
                    -DBoost_COMPILER:STRING=${Boost_COMPILER}
                    -DBoost_USE_DEBUG_PYTHON:BOOL=TRUE
                    -DBOOST_ROOT:PATH=${CMAKE_INSTALL_PREFIX}
                    -DBOOST_INCLUDEDIR:PATH=${CMAKE_INSTALL_PREFIX}/include/boost-${BOOST_VERSION})

# Sorry...
getCachedUrl(https://gforge.inria.fr/git/sofa/sofa.git CACHED_URL)


# Getting fixed rev with working compilations in all plateforms (except Mac)
set(SOFA_REV 49e371eb4f2961b84ff7d29176276bfc6e9d3900)

set(SOFA_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)
set(SOFA_PATCH_CMD ${CMAKE_COMMAND} -E  copy_if_different "${SOFA_PATCH_DIR}/custom_options.cmake" "<SOURCE_DIR>/cmake/custom_options.cmake")

ExternalProject_Add(
    sofa
    GIT_REPOSITORY ${CACHED_URL}
    GIT_TAG ${SOFA_REV}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS boost libpng
    PATCH_COMMAND ${SOFA_PATCH_CMD}
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E chdir <BINARY_DIR> cmake <SOURCE_DIR> ${SOFA_CMAKE_ARGS} && cmake <BINARY_DIR>
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    INSTALL_COMMAND ${CMAKE_COMMAND} -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX} -DSOURCE_DIR:PATH=<SOURCE_DIR> -P ${CMAKE_CURRENT_SOURCE_DIR}/install.cmake
)

ExternalProject_Add_Step(sofa CopyConfigFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${SOFA_PATCH_DIR}/FindSOFA.cmake ${CMAKE_INSTALL_PREFIX}/FindSOFA.cmake
    DEPENDEES install
    COMMENT "Install configuration file"
)

