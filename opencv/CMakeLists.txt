cmake_minimum_required(VERSION 2.8)

project(opencvBuilder)

include(ExternalProject)

set(OPENCV_CMAKE_ARGS 
    -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} 
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DBUILD_DOCS:BOOL=OFF
    -DBUILD_TESTS:BOOL=OFF
    -DBUILD_PERF_TESTS:BOOL=OFF
    -DBUILD_SHARED_LIBS:BOOL=ON
    -DBUILD_WITH_DEBUG_INFO:BOOL=OFF
    
    -DWITH_JASPER:BOOL=OFF #jpeg2k support
    -DWITH_1394:BOOL=OFF
    -DWITH_OPENEXR:BOOL=OFF
    -DWITH_CUDA:BOOL=OFF
                       
    -DWITH_JPEG:BOOL=ON
    -DWITH_PNG:BOOL=ON
    -DWITH_QT:BOOL=OFF
    -DWITH_OPENGL:BOOL=ON
    -DWITH_TBB:BOOL=OFF
    -DWITH_TIFF:BOOL=ON
    -DWITH_ZLIB:BOOL=ON

    -DBUILD_JPEG:BOOL=OFF
    -DBUILD_PNG:BOOL=OFF
    -DBUILD_TIFF:BOOL=OFF
    -DBUILD_ZLIB:BOOL=OFF
    -DBUILD_opencv_java:BOOL=OFF
)

# Have to replace all the following "set" by list(APPEND ...) or not ? 
if(WIN32)
    set(OPENCV_CMAKE_ARGS ${OPENCV_CMAKE_ARGS}
        -DWITH_DSHOW:BOOL=ON
        -DWITH_MSMF:BOOL=OFF #required MSVC_2012+
        -DWITH_GSTREAMER:BOOL=OFF
        -DWITH_FFMPEG:BOOL=OFF
        )
elseif(APPLE)
    list(APPEND OPENCV_CMAKE_ARGS
        -DWITH_QUICKTIME:BOOL=OFF
        -DWITH_FFMPEG:BOOL=ON
        )
else(ANDROID)
    list(APPEND OPENCV_CMAKE_ARGS
        -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
        -DBUILD_JPEG:BOOL=OFF
        -DBUILD_PNG:BOOL=OFF
        -DBUILD_TIFF:BOOL=OFF
        -DBUILD_ZLIB:BOOL=OFF
    )
    
    set(OPENCV_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)  
    set(OPENCV_PATCH_CMD ${CMAKE_COMMAND} -E  copy_if_different "${OPENCV_PATCH_DIR}/CMakeLists.txt" "<SOURCE_DIR>/CMakeLists.txt"
        COMMAND ${CMAKE_COMMAND} -E  copy_if_different "${OPENCV_PATCH_DIR}/data/CMakeLists.txt" "<SOURCE_DIR>/data/CMakeLists.txt"
        )
    
else()
    set(OPENCV_CMAKE_ARGS ${OPENCV_CMAKE_ARGS}
        #required ffmpeg or libav development packages: libavcodec-dev, libavformat-dev, libswscale-dev
        -DWITH_FFMPEG:BOOL=ON
        -DWITH_V4L:BOOL=ON
        -DWITH_GSTREAMER:BOOL=OFF
        )
endif()

getCachedUrl(https://github.com/Itseez/opencv/archive/2.4.8.tar.gz CACHED_URL)


if(ANDROID)
ExternalProject_Add(
    opencv
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS jpeg libpng zlib
    PATCH_COMMAND ${OPENCV_PATCH_CMD}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${OPENCV_CMAKE_ARGS}
)
else()
    ExternalProject_Add(
        opencv
        URL ${CACHED_URL}
        DOWNLOAD_DIR ${ARCHIVE_DIR}
        DEPENDS jpeg tiff libpng zlib
        INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
        CMAKE_ARGS ${OPENCV_CMAKE_ARGS}
    )
endif()
