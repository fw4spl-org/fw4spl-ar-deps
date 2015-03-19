cmake_minimum_required(VERSION 2.8)

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
    -DWITH_OPENCL:BOOL=OFF;
                       
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
    # Doesn't compile with Clang >= 3.5
    -DBUILD_opencv_ts:BOOL=OFF
)

set(OPENCV_PATCH_CMD)
set(OPENCV_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)

# Have to replace all the following "set" by list(APPEND ...) or not ? 
if(WIN32)
    list(APPEND OPENCV_CMAKE_ARGS
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
elseif(NOT ANDROID) #linux
    include(${ArBinPkgs_SOURCE_DIR}/cmake/utils/patch.cmake)
    
    set(OPENCV_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)  
    list(APPEND OPENCV_CMAKE_ARGS
        #required ffmpeg or libav development packages: libavcodec-dev, libavformat-dev, libswscale-dev
        -DWITH_FFMPEG:BOOL=ON
        -DWITH_V4L:BOOL=ON
        -DWITH_GSTREAMER:BOOL=OFF
        )
    # Only needed for Clang >= 3.5 because of  -Wtautological-pointer-compare 
    # but it doesn't hurt for the other compiler
    set(OPENCV_PATCH_CMD "${PATCH_EXECUTABLE}" -p0 -i ${OPENCV_PATCH_DIR}/calibfilter.cpp.diff -d <SOURCE_DIR>
    )
else()
     set(OPENCV_PATCH_CMD ${CMAKE_COMMAND} -E copy_if_different "${OPENCV_PATCH_DIR}/CMakeLists.txt" "<SOURCE_DIR>/CMakeLists.txt")
endif()


getCachedUrl(http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/2.4.10/opencv-2.4.10.zip CACHED_URL)

set(EXTRA_DEPENDS)
if(NOT ANDROID)
    set(EXTRA_DEPENDS "tiff")
endif()

ExternalProject_Add(
    opencv
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS jpeg libpng zlib ${EXTRA_DEPENDS}
    PATCH_COMMAND ${OPENCV_PATCH_CMD}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${OPENCV_CMAKE_ARGS}
)
