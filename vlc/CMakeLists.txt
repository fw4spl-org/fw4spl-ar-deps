cmake_minimum_required(VERSION 3.0)

project(vlc)

include(ExternalProject)

find_path(VLC_INCLUDE_DIR vlc/vlc.h PATHS
    /usr/include
    /usr/local/include
    "$ENV{ProgramW6432}/VideoLAN/VLC/sdk/include"
)

find_library(VLC_LIBRARY NAMES vlc PATHS
    /usr/lib
    /usr/local/lib
    "$ENV{ProgramW6432}/VideoLAN/VLC/sdk/lib"
)

find_library(VLC_CORE_LIBRARY NAMES vlccore PATHS
    /usr/lib
    /usr/local/lib
    "$ENV{ProgramW6432}/VideoLAN/VLC/sdk/lib"
)

if(${VLC_INCLUDE_DIR} STREQUAL VLC_INCLUDE_DIR-NOTFOUND)
    message(FATAL_ERROR "Missing vlc headers on the system."
                        "You must install them, i.e. on Debian sudo apt-get install libvlc-dev.")
endif()

if(${VLC_LIBRARY} STREQUAL VLC_LIBRARY-NOTFOUND OR ${VLC_CORE_LIBRARY} STREQUAL VLC_CORE_LIBRARY-NOTFOUND)
    message(FATAL_ERROR "Missing vlc libraries on the system."
                        "You must install them, i.e. on Debian sudo apt-get install libvlc.")
endif()

string(FIND ${VLC_LIBRARY} "/" PATH_FILE_INDEX REVERSE)
string(SUBSTRING ${VLC_LIBRARY} 0 ${PATH_FILE_INDEX} PATH_DIR)

# We use cp command directly from a shell to be able to use a wildcard
# This is not the most elegant way but as we are only on Linux this is okish...
ExternalProject_Add(
    vlc
    DOWNLOAD_COMMAND echo "Nothing to download..."
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    CONFIGURE_COMMAND echo "Nothing to configure..."
    BUILD_COMMAND echo "Nothing to build..."
    INSTALL_COMMAND sh -c "cp ${VLC_LIBRARY}* ${CMAKE_INSTALL_PREFIX}/lib"
            COMMAND sh -c "cp ${VLC_CORE_LIBRARY}* ${CMAKE_INSTALL_PREFIX}/lib"
            COMMAND ${CMAKE_COMMAND} -E copy_directory ${PATH_DIR}/vlc ${CMAKE_INSTALL_PREFIX}/lib/vlc
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
)

ExternalProject_Add_Step(vlc CopyConfigFileToInstall
    COMMAND ${CMAKE_INSTALL_PREFIX}/lib/vlc/vlc-cache-gen ${CMAKE_INSTALL_PREFIX}/lib/vlc/plugins/
    COMMENT "Generate plugin cache"
    DEPENDEES install
)

# Create the uninstall log to allow uninstalling
string(REPLACE "${PATH_DIR}/" "" VLC_LIBRARY_NAME ${VLC_LIBRARY})
string(REPLACE "${PATH_DIR}/" "" VLC_CORE_LIBRARY_NAME ${VLC_CORE_LIBRARY})
string(APPEND VLC_INSTALL_FILES ${CMAKE_INSTALL_PREFIX}/lib/${VLC_LIBRARY_NAME} "\n" ${CMAKE_INSTALL_PREFIX}/lib/${VLC_CORE_LIBRARY_NAME} "\n")

file(GLOB_RECURSE VLC_PLUGIN_FILES ${CMAKE_INSTALL_PREFIX}/lib/vlc/*.*)

foreach(FILE ${VLC_PLUGIN_FILES})
    string(APPEND VLC_INSTALL_FILES ${FILE} "\n")
endforeach()

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/vlc-prefix/src/vlc-build/install_manifest.txt ${VLC_INSTALL_FILES})
