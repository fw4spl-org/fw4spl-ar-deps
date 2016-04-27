cmake_minimum_required(VERSION 3.0)

project(vlfeatBuilder)

include(ExternalProject)

set(CACHED_URL https://github.com/schweitzer/vlfeat/archive/master.zip)
set(VLFEAT_SRC_DIR ${CMAKE_CURRENT_BINARY_DIR}/vlfeat-prefix/src/vlfeat)

set(${DEBUG} "")

if(${CMAKE_BUILD_TYPE} STREQUAL "Debug")
    set(${DEBUG} "debug")
endif()

if(UNIX)
include(vlfeat_linux.cmake)
elseif(WIN32)
include(vlfeat_windows.cmake)
endif()
