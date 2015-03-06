cmake_minimum_required(VERSION 2.8)

project(sofaBuilder)

include(ExternalProject)

include( ${CMAKE_SOURCE_DIR}/cmake/findBinpkgs/fw-boost.cmake )

set(SOFA_CMAKE_ARGS ${COMMON_CMAKE_ARGS}
                    -DBoost_COMPILER:STRING=${Boost_COMPILER}
                    -DBoost_USE_DEBUG_PYTHON:BOOL=TRUE
                    -DBOOST_ROOT:PATH=${CMAKE_INSTALL_PREFIX}
                    -DBOOST_INCLUDEDIR:PATH=${CMAKE_INSTALL_PREFIX}/include/boost-${BOOST_VERSION}
                    -DSOFAADVANCED_INSTALL_INCLUDE_DIR:PATH=${CMAKE_INSTALL_PREFIX}/include/sofa
                    -DSOFABASE_INSTALL_INCLUDE_DIR:PATH=${CMAKE_INSTALL_PREFIX}/include/sofa
                    -DSOFACOMMON_INSTALL_INCLUDE_DIR:PATH=${CMAKE_INSTALL_PREFIX}/include/sofa
                    -DSOFAFRAMEWORK_INSTALL_INCLUDE_DIR:PATH=${CMAKE_INSTALL_PREFIX}/include/sofa
                    -DSOFAGENERAL_INSTALL_INCLUDE_DIR:PATH=${CMAKE_INSTALL_PREFIX}/include/sofa
                    -DSOFAGUI_INSTALL_INCLUDE_DIR:PATH=${CMAKE_INSTALL_PREFIX}/include/sofa
                    -DSOFAMISC_INSTALL_INCLUDE_DIR:PATH=${CMAKE_INSTALL_PREFIX}/include/sofa
                    -DSOFASIMULATION_INSTALL_INCLUDE_DIR:PATH=${CMAKE_INSTALL_PREFIX}/include/sofa
)

getCachedUrl(https://gforge.inria.fr/git/sofa/sofa.git CACHED_URL)


# Getting fixed rev with working compilations in all plateforms (except Mac)
set(SOFA_REV aae029836ef1d2cf829222f16adb0eceef4f60a7)

include(${ArBinPkgs_SOURCE_DIR}/cmake/utils/patch.cmake)

set(SOFA_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)
set(SOFA_PATCH_CMD ${CMAKE_COMMAND} -E remove_directory "<SOURCE_DIR>/extlibs/miniBoost/"
                   COMMAND "${PATCH_EXECUTABLE}" -p1 -i ${SOFA_PATCH_DIR}/sofa.patch -d <SOURCE_DIR>
)

set(DEPENDENCIES
    zlib
    eigen
    boost
    libpng
    glew
)

if(NOT APPLE)
    list(APPEND DEPENDENCIES
        freeglut
    )
else()
    list(APPEND SOFA_CMAKE_ARGS 
        -DGLUT_glut_LIBRARY=/System/Library/Frameworks/GLUT.framework/GLUT
    )
endif()

ExternalProject_Add(
    sofa
    GIT_REPOSITORY ${CACHED_URL}
    GIT_TAG ${SOFA_REV}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    PATCH_COMMAND ${SOFA_PATCH_CMD}
    DEPENDS ${DEPENDENCIES}
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -E chdir <BINARY_DIR> ${CMAKE_COMMAND} <SOURCE_DIR> -G ${CMAKE_GENERATOR} ${SOFA_CMAKE_ARGS} && ${CMAKE_COMMAND} <BINARY_DIR> -G ${CMAKE_GENERATOR}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
)

if(UNIX AND CMAKE_BUILD_TYPE STREQUAL "Debug")
    ExternalProject_Add_Step(sofa RENAME_TINYXML
        COMMAND ${CMAKE_COMMAND} -E create_symlink libtinyxml_d.so.2.6.2 libtinyxml.so.2.6.2
        WORKING_DIRECTORY ${CMAKE_INSTALL_PREFIX}/lib
        DEPENDEES install
        )
endif()
