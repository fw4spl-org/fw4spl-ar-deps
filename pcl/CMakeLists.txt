cmake_minimum_required(VERSION 2.8)

project(pclBuilder)

include(ExternalProject)

getCachedUrl(https://github.com/PointCloudLibrary/pcl/archive/085e13a04c1d6c0c2a65ae91ddb6f1d77a884693.tar.gz CACHED_URL)

include( ${CMAKE_SOURCE_DIR}/cmake/findBinpkgs/fw-boost.cmake )

find_package(ZLIB REQUIRED)

if(WIN32)
    set(OPENNI2_LIBRARY "OpenNI2.lib")
elseif(APPLE)
    set(OPENNI2_LIBRARY "libOpenNI2.dylib")
else()
    set(OPENNI2_LIBRARY "libOpenNI2.so")
endif()

set(PCL_CMAKE_ARGS      ${COMMON_CMAKE_ARGS}
                        -DBUILD_2d:BOOL=OFF
                        -DBUILD_apps:BOOL=OFF
                        -DBUILD_CUDA:BOOL=OFF
                        -DBUILD_OPENNI:BOOL=OFF
                        -DBUILD_OPENNI2:BOOL=ON
                        -DBUILD_DAVIDSDK:BOOL=OFF
                        -DBUILD_ENSENSO:BOOL=OFF
                        -DBUILD_examples:BOOL=OFF
                        -DBUILD_common:BOOL=ON
                        -DBUILD_features:BOOL=ON
                        -DBUILD_filters:BOOL=ON
                        -DBUILD_geometry:BOOL=ON
                        -DBUILD_io:BOOL=ON
                        -DBUILD_kdtree:BOOL=ON
                        -DBUILD_keypoints:BOOL=OFF
                        -DBUILD_ml:BOOL=OFF
                        -DBUILD_octree:BOOL=ON
                        -DBUILD_outofcore:BOOL=OFF
                        -DBUILD_recognition:BOOL=OFF
                        -DBUILD_registration:BOOL=OFF
                        -DBUILD_sample_consensus:BOOL=ON
                        -DBUILD_search:BOOL=ON
                        -DBUILD_segmentation:BOOL=OFF
                        -DBUILD_simulation:BOOL=OFF
                        -DBUILD_stereo:BOOL=OFF
                        -DBUILD_surface:BOOL=OFF
                        -DBUILD_surface_on_nurbs:BOOL=OFF
                        -DBUILD_tools:BOOL=OFF
                        -DBUILD_tracking:BOOL=OFF
                        -DBUILD_visualization:BOOL=OFF
                        -DBUILD_TESTS:BOOL=OFF
                        -DCMAKE_C_COMPILER:PATH=${CMAKE_C_COMPILER}
                        -DCMAKE_CXX_COMPILER:PATH=${CMAKE_CXX_COMPILER}
                        -DCMAKE_CXX_COMPILER:PATH=${CMAKE_CXX_COMPILER}
                        -DBoost_COMPILER:STRING=${Boost_COMPILER}
                        -DBOOST_ROOT:PATH=${CMAKE_INSTALL_PREFIX}
                        -DBOOST_INCLUDEDIR:PATH=${CMAKE_INSTALL_PREFIX}/include/boost-${BOOST_VERSION}
                        -DBoost_USE_DEBUG_PYTHON:BOOL=ON
                        -DBoost_USE_MULTITHREADED:BOOL=ON
                        -DBoost_USE_STATIC_LIBS:BOOL=OFF
                        -DPCL_BUILD_WITH_BOOST_DYNAMIC_LINKING_WIN32:BOOL=ON
                        -DOPENNI2_INCLUDE_DIRS:PATH=${CMAKE_INSTALL_PREFIX}/include/openni2
                        -DOPENNI2_LIBRARY:PATH=${CMAKE_INSTALL_PREFIX}/lib/openni2/${OPENNI2_LIBRARY}
                        -DFLANN_INCLUDE_DIR:PATH=${CMAKE_INSTALL_PREFIX}/include/flann
                        -DVTK_DIR:PATH=${CMAKE_INSTALL_PREFIX}/lib/
                        -DPCL_SHARED_LIBS:BOOL=ON
                        -DBUILD_WITH_DEBUG_INFO:BOOL=OFF
                        -DZLIB_INCLUDE_DIR:PATH=${ZLIB_INCLUDE_DIRS}
                        -DQT_QMAKE_EXECUTABLE:PATH=${CMAKE_INSTALL_PREFIX}/bin/qmake
)
    

ExternalProject_Add(
    pcl
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS zlib boost flann qt vtk eigen openni
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${PCL_CMAKE_ARGS}
)
