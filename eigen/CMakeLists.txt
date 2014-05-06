CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

PROJECT(eigenBuilder)

INCLUDE(ExternalProject)

GET_CACHED_URL(http://bitbucket.org/eigen/eigen/get/3.1.2.tar.gz CACHED_URL)

SET(EIGEN_CMAKE_ARGS    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} 
                        -DBUILD_SHARED_LIBS:BOOL=ON
                        -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                        -DBUILD_TESTING:BOOL=ON
                        -DEIGEN_TEST_NOQT:BOOL=ON
)

SET(EIGEN_SRC_DIR ${CMAKE_CURRENT_BINARY_DIR}/eigen-prefix/src/eigen)

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