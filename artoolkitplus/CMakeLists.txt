CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

PROJECT(artoolkitplusBuilder)

INCLUDE(ExternalProject)

SET(ARTKP_CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} 
                     -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX} 
                     -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                     -DBUILD_EXAMPLES:BOOL=NO
)


IF(CMAKE_BUILD_TYPE STREQUAL "Release")
    SET(ARTKP_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch/release)
ELSE()
    SET(ARTKP_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch/debug)
ENDIF()


SET(ARTKP_PATCH_CMD ${CMAKE_COMMAND} -E  copy_if_different "${ARTKP_PATCH_DIR}/CMakeLists.txt" "<SOURCE_DIR>/CMakeLists.txt")


GET_CACHED_URL(http://launchpad.net/artoolkitplus/trunk/2.2.1/+download/ARToolKitPlus-2.2.1.tar.bz2 CACHED_URL)

ExternalProject_Add(
    artoolkitplus
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    PATCH_COMMAND ${ARTKP_PATCH_CMD}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${ARTKP_CMAKE_ARGS}
    STEP_TARGETS CopyConfigFileToInstall
)

ExternalProject_Add_Step(artoolkitplus CopyConfigFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/cmake/findBinpkgs/FindArtoolkitplus.cmake ${CMAKE_INSTALL_PREFIX}/Findartoolkitplus.cmake
    COMMENT "Install configuration file"
)

