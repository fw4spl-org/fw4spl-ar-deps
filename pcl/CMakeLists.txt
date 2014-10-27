cmake_minimum_required(VERSION 2.8)

project(pclBuilder)

include(ExternalProject)

getCachedUrl(https://github.com/PointCloudLibrary/pcl/archive/master.tar.gz CACHED_URL)

include( ${CMAKE_INSTALL_PREFIX}/fw-boost.cmake )

find_package(Boost REQUIRED)
find_package(ZLIB REQUIRED)

set(PCL_CMAKE_ARGS      ${COMMON_CMAKE_ARGS}
                        -DBUILD_2d:BOOL=ON
                        -DBUILD_apps:BOOL=OFF
                        -DBUILD_CUDA:BOOL=OFF
                        -DBUILD_OPENNI:BOOL=OFF
                        -DBUILD_examples:BOOL=OFF
                        -DBUILD_common:BOOL=ON
                        -DBUILD_features:BOOL=ON
                        -DBUILD_filters:BOOL=ON
                        -DBUILD_geometry:BOOL=ON
                        -DBUILD_io:BOOL=ON
                        -DBUILD_kdtree:BOOL=ON
                        -DBUILD_keypoints:BOOL=ON
                        -DBUILD_ml:BOOL=ON
                        -DBUILD_octree:BOOL=ON
                        -DBUILD_outofcore:BOOL=ON
                        -DBUILD_recognition:BOOL=ON
                        -DBUILD_registration:BOOL=ON
                        -DBUILD_sample_consensus:BOOL=ON
                        -DBUILD_search:BOOL=ON
                        -DBUILD_segmentation:BOOL=ON
                        -DBUILD_simulation:BOOL=ON
                        -DBUILD_stereo:BOOL=ON
                        -DBUILD_surface:BOOL=ON
                        -DBUILD_surface_on_nurbs:BOOL=ON
                        -DBUILD_tools:BOOL=ON
                        -DBUILD_tracking:BOOL=ON
                        -DBUILD_visualization:BOOL=ON
                        -DBUILD_TESTS:BOOL=OFF
                        -DCMAKE_C_COMPILER:PATH=${CMAKE_C_COMPILER}
                        -DCMAKE_CXX_COMPILER:PATH=${CMAKE_CXX_COMPILER}
                        -DCMAKE_CXX_COMPILER:PATH=${CMAKE_CXX_COMPILER}
                        -DBoost_COMPILER:STRING=${Boost_COMPILER}

                        -DBOOST_LIBRARYDIR:PATH=${CMAKE_INSTALL_PREFIX}/lib
                        -DBOOST_ROOT:PATH=${CMAKE_INSTALL_PREFIX}
                        -DBOOST_INCLUDEDIR:PATH=${Boost_INCLUDE_DIRS}
                        -DBoost_USE_DEBUG_PYTHON:BOOL=ON
                        -DBoost_USE_MULTITHREADED:BOOL=ON
                        -DBoost_USE_STATIC_LIBS:BOOL=OFF
                        
                        -DFLANN_INCLUDE_DIR:PATH=${CMAKE_INSTALL_PREFIX}/include/flann
                        -DVTK_DIR:PATH=${CMAKE_INSTALL_PREFIX}/lib/
                        -DPCL_SHARED_LIBS:BOOL=ON
                        -DBUILD_WITH_DEBUG_INFO:BOOL=OFF
                        -DZLIB_INCLUDE_DIR:PATH=${ZLIB_INCLUDE_DIRS}
                        -DQT_QMAKE_EXECUTABLE:PATH=${CMAKE_INSTALL_PREFIX}/bin/qmake
)
set(PCL_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)

if(UNIX)
    #BUG due to gcc <4.8 and Qt5
    #(see https://github.com/PointCloudLibrary/pcl/issues/272 && http://www.pcl-users.org/installing-pcl-trunk-td4030028.html )
    set(PCL_PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${PCL_PATCH_DIR}/CMakeLists.txt ${CMAKE_CURRENT_BINARY_DIR}/pcl-prefix/src/pcl/CMakeLists.txt)
else()
    # Disabled foce use of Boost_USE_STATIC_LIBS=ON for win32
    set(PCL_PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${PCL_PATCH_DIR}/pcl_find_boost.cmake ${CMAKE_CURRENT_BINARY_DIR}/pcl-prefix/src/pcl/cmake/pcl_find_boost.cmake)
endif()

set(PCL_PATCH_COMMAND  ${PCL_PATCH_COMMAND} 
    COMMAND ${CMAKE_COMMAND} -E copy ${PCL_PATCH_DIR}/io/CMakeLists.txt ${CMAKE_CURRENT_BINARY_DIR}/pcl-prefix/src/pcl/io/CMakeLists.txt
    COMMAND ${CMAKE_COMMAND} -E copy ${PCL_PATCH_DIR}/tools/CMakeLists.txt ${CMAKE_CURRENT_BINARY_DIR}/pcl-prefix/src/pcl/tools/CMakeLists.txt)    
    

ExternalProject_Add(
    pcl
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS zlib boost flann qt vtk eigen
    PATCH_COMMAND ${PCL_PATCH_COMMAND} 
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${PCL_CMAKE_ARGS}
)
