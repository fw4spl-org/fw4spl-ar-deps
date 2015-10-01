cmake_minimum_required(VERSION 3.0)

project(eigenBuilder)

include(ExternalProject)

set(CACHED_URL http://bitbucket.org/eigen/eigen/get/3.1.2.tar.gz)

set(EIGEN_CMAKE_ARGS    ${COMMON_CMAKE_ARGS}
                        -DBUILD_SHARED_LIBS:BOOL=ON
                        -DEIGEN_TEST_NOQT:BOOL=ON
                        -DBUILD_TESTING:BOOL=ON
)

set(EIGEN_PATCH_CMD "")

if(ANDROID)
    list(APPEND EIGEN_CMAKE_ARGS
        -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
        -DBUILD_TESTING:BOOL=OFF
    )
    
    set(EIGEN_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)
    set(EIGEN_SRC_DIR ${CMAKE_CURRENT_BINARY_DIR}/eigen-prefix/src/eigen)

    if (${CMAKE_HOST_WIN32})
        # Fixed compiler check (macro ei_get_compilerver)
        set(EIGEN_PATCH_CMD ${CMAKE_COMMAND} -E copy_if_different "${EIGEN_PATCH_DIR}/EigenTesting.cmake" "${EIGEN_SRC_DIR}/CMake/EigenTesting.cmake")
    else()
        set(EIGEN_PATCH_CMD "${PATCH_EXECUTABLE}" -p1 -i ${EIGEN_PATCH_DIR}/EigenTesting.diff -d <SOURCE_DIR>
            COMMAND "${PATCH_EXECUTABLE}" -p1 -i ${EIGEN_PATCH_DIR}/EigenConfigureTesting.diff -d <SOURCE_DIR>
        )
    endif()
endif()

set(EIGEN_SRC_DIR ${CMAKE_CURRENT_BINARY_DIR}/eigen-prefix/src/eigen)

ExternalProject_Add(
    eigen
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DOWNLOAD_NAME eigen_3.1.2.tar.gz
    PATCH_COMMAND ${EIGEN_PATCH_CMD}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${EIGEN_CMAKE_ARGS}
    STEP_TARGETS CopyConfigFileToInstall
)

ExternalProject_Add_Step(eigen CopyConfigFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/findBinpkgs/FindEigen.cmake ${CMAKE_INSTALL_PREFIX}/FindEigen.cmake
    COMMENT "Install configuration file"
)
