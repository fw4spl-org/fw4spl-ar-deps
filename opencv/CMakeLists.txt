cmake_minimum_required(VERSION 3.0)

project(opencvBuilder)

include(ExternalProject)

set(OPENCV_CMAKE_ARGS
    ${COMMON_CMAKE_ARGS}
    -DBUILD_DOCS:BOOL=OFF
    -DBUILD_TESTS:BOOL=OFF
    -DBUILD_PERF_TESTS:BOOL=OFF
    -DBUILD_SHARED_LIBS:BOOL=ON
    -DBUILD_WITH_DEBUG_INFO:BOOL=OFF

    -DWITH_JASPER:BOOL=OFF #jpeg2k support
    -DWITH_1394:BOOL=OFF
    -DWITH_OPENEXR:BOOL=OFF
    -DWITH_CUDA:BOOL=OFF
    -DWITH_OPENCL:BOOL=OFF

    -DWITH_JPEG:BOOL=ON
    -DWITH_PNG:BOOL=ON
    -DWITH_QT:BOOL=OFF
    -DWITH_VTK:BOOL=OFF
    -DWITH_OPENGL:BOOL=ON
    -DWITH_TBB:BOOL=OFF
    -DWITH_TIFF:BOOL=ON
    -DWITH_ZLIB:BOOL=ON

    -DBUILD_JPEG:BOOL=OFF
    -DBUILD_PNG:BOOL=OFF
    -DBUILD_TIFF:BOOL=OFF
    -DBUILD_ZLIB:BOOL=OFF
    -DBUILD_opencv_java:BOOL=OFF
    -DBUILD_opencv_python:BOOL=OFF
    # Doesn't compile with Clang >= 3.5
    -DBUILD_opencv_ts:BOOL=OFF
)

set(OPENCV_PATCH_CMD)
set(OPENCV_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)

if(WIN32)
    list(APPEND OPENCV_CMAKE_ARGS
        -DWITH_DSHOW:BOOL=ON
        -DWITH_MSMF:BOOL=OFF #required MSVC_2012+
        -DWITH_GSTREAMER:BOOL=OFF
        -DWITH_FFMPEG:BOOL=OFF
        )
elseif(NOT ANDROID) #linux
    if(APPLE)
        list(APPEND OPENCV_CMAKE_ARGS
            -DWITH_QUICKTIME:BOOL=OFF
            -DWITH_FFMPEG:BOOL=OFF
            -DBUILD_opencv_ts:BOOL=ON
            )
    else()
        list(APPEND OPENCV_CMAKE_ARGS
            #required ffmpeg or libav development packages: libavcodec-dev, libavformat-dev, libswscale-dev
            -DWITH_FFMPEG:BOOL=ON
            -DWITH_V4L:BOOL=ON
            -DWITH_GSTREAMER:BOOL=OFF
            )
    endif()

else() #ANDROID
    list(APPEND OPENCV_CMAKE_ARGS
        -DOPENCV_OTHER_INSTALL_PATH=share/OpenCV
    )
    list(APPEND OPENCV_PATCH_CMD "${PATCH_EXECUTABLE}" -p1 -i ${OPENCV_PATCH_DIR}/android.diff -d <SOURCE_DIR> )
endif()

#Dowload opencv-contrib repository

set(CACHED_URL https://github.com/Itseez/opencv/archive/3.0.0.zip)

set(EXTRA_DEPENDS)
if(NOT ANDROID)
    set(EXTRA_DEPENDS "tiff")
endif()

ExternalProject_Add(
    opencv
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DOWNLOAD_NAME opencv_3.0.0.zip
    DEPENDS jpeg libpng zlib ${EXTRA_DEPENDS}
    PATCH_COMMAND ${OPENCV_PATCH_CMD}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    BUILD_COMMAND ${BUILD_PARALLEL_COMMAND}
    CMAKE_ARGS ${OPENCV_CMAKE_ARGS}
)
