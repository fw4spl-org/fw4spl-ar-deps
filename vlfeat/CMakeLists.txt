cmake_minimum_required(VERSION 3.0)

project(vlfeatBuilder)

include(ExternalProject)

set(CACHED_URL https://github.com/fw4spl-org/vlfeat/archive/v0.9.21.tar.gz)
set(VLFEAT_HASH fe972ab657d550a1044df1a782b02f71d725d62e53970a63a98ecb1353dd011a)
set(VLFEAT_SRC_DIR ${CMAKE_CURRENT_BINARY_DIR}/vlfeat-prefix/src/vlfeat)

if(UNIX)
    include(vlfeat_linux.cmake)
elseif(WIN32)
    include(vlfeat_windows.cmake)
endif()
