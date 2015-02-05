cmake_minimum_required(VERSION 2.8)

project(geodesicBuilder)

include(ExternalProject)

getCachedUrl(https://github.com/jabooth/exactgeodesic/archive/b5c2cc4a59193e7cee6cd84c9378696e053b931a.tar.gz CACHED_URL)

ExternalProject_Add(
    geodesic
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_CURRENT_BINARY_DIR}/geodesic-prefix/src/geodesic" "${CMAKE_INSTALL_PREFIX}/include/geodesic"
    INSTALL_COMMAND ""
    STEP_TARGETS CopyConfigFileToInstall
)

ExternalProject_Add_Step(geodesic CopyConfigFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/findBinpkgs/fw-geodesic.cmake ${CMAKE_INSTALL_PREFIX}/fw-geodesic.cmake
    COMMENT "Install configuration file"
)
