cmake_minimum_required(VERSION 2.8)

project(eigenBuilder)

include(ExternalProject)

getCachedUrl(http://bitbucket.org/eigen/eigen/get/3.1.2.tar.gz CACHED_URL)

set(EIGEN_CMAKE_ARGS    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} 
                        -DBUILD_SHARED_LIBS:BOOL=ON
                        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                        -DBUILD_TESTING:BOOL=ON
                        -DEIGEN_TEST_NOQT:BOOL=ON
)

set(EIGEN_SRC_DIR ${CMAKE_CURRENT_BINARY_DIR}/eigen-prefix/src/eigen)

ExternalProject_Add(
    eigen
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${EIGEN_CMAKE_ARGS}
    STEP_TARGETS CopyConfigFileToInstall
)

ExternalProject_Add_Step(eigen CopyConfigFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/findBinpkgs/FindEigen.cmake ${CMAKE_INSTALL_PREFIX}/FindEigen.cmake
    COMMENT "Install configuration file"
)