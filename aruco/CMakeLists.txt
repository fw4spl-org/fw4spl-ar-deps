cmake_minimum_required(VERSION 2.8)

project(arucoBuilder)

include(ExternalProject)

getCachedUrl(https://github.com/greenjava/aruco/archive/1.2.4a.tar.gz CACHED_URL)

set(ARUCO_CMAKE_ARGS    ${COMMON_CMAKE_ARGS}
                        -DBUILD_SHARED_LIBS:BOOL=ON
                        -DINSTALL_DOC:BOOL=OFF
                        -DBUILD_UTILS:BOOL=OFF
)
if(ANDROID)
    list(APPEND ARUCO_CMAKE_ARGS -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
         -DOpenCV_LIB_DIR="${CMAKE_INSTALL_PREFIX}/lib"        
         )
    set(PATCH_CMD ${CMAKE_COMMAND} -E copy_if_different "${CMAKE_CURRENT_SOURCE_DIR}/patch/android/CMakeLists.txt" "<SOURCE_DIR>/trunk/CMakeLists.txt")
else()
    set(PATCH_CMD "")
endif()

set(ARUCO_SRC_DIR ${CMAKE_CURRENT_BINARY_DIR}/aruco-prefix/src/aruco/trunk)

ExternalProject_Add(
    aruco
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS opencv
    PATCH_COMMAND ${PATCH_CMD}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CONFIGURE_COMMAND ${CMAKE_COMMAND} -G ${CMAKE_GENERATOR} ${ARUCO_CMAKE_ARGS} ${ARUCO_SRC_DIR}
    BUILD_COMMAND ${MAKE} ${ARUCO_SRC_DIR}
)

