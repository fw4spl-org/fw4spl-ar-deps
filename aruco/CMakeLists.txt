cmake_minimum_required(VERSION 2.8)

project(arucoBuilder)

include(ExternalProject)

getCachedUrl(http://sourceforge.net/projects/aruco/files/1.3.0/aruco-1.3.0.tgz/download CACHED_URL)


set(ARUCO_PATCH_CMD)
set(ARUCO_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)

set(ARUCO_CMAKE_ARGS    ${COMMON_CMAKE_ARGS}
                        -DBUILD_SHARED_LIBS:BOOL=ON
                        -DINSTALL_DOC:BOOL=OFF
                        -DBUILD_UTILS:BOOL=OFF
)

#OpenMP
find_package(OpenMP)
if(OPENMP_FOUND)
    list(APPEND ARUCO_CMAKE_ARGS
         -DENABLE_OPENMP=ON
         )
endif()

if(ANDROID)
    list(APPEND ARUCO_CMAKE_ARGS
         -DOpenCV_LIB_DIR="${CMAKE_INSTALL_PREFIX}/lib"
         )
         set(ARUCO_PATCH_CMD "${PATCH_EXECUTABLE}" -p1 -i ${ARUCO_PATCH_DIR}/android/android.diff -d <SOURCE_DIR> )
endif()

ExternalProject_Add(
    aruco
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS opencv
    PATCH_COMMAND ${ARUCO_PATCH_CMD}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${ARUCO_CMAKE_ARGS}
    STEP_TARGETS CopyConfigFileToInstall
)

ExternalProject_Add_Step(aruco CopyConfigFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_INSTALL_PREFIX}/lib/cmake/Findaruco.cmake ${CMAKE_INSTALL_PREFIX}/Findaruco.cmake
    COMMENT "Install Findaruco.cmake"
    DEPENDEES install
)
