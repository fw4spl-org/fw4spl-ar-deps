cmake_minimum_required(VERSION 2.8)

project(openniBuilder)

include(ExternalProject)

getCachedUrl(https://github.com/MingEnsiie/OpenNI2/releases/download/v2.2.0-debian-fork/OpenNI2-2.2.0-debian-fork.tar CACHED_URL)

if(WIN32)
    ExternalProject_Add(
            openni
            URL ${CACHED_URL}
            DOWNLOAD_DIR ${ARCHIVE_DIR}
            BUILD_IN_SOURCE 1
            CONFIGURE_COMMAND ""
            BUILD_COMMAND devenv OpenNI.sln /build ${CMAKE_BUILD_TYPE}
            INSTALL_COMMAND ""
            STEP_TARGETS CopyConfigFileToInstall
    )
    ExternalProject_Add_Step(
            openni INSTALL_OPENNI
            COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/Config/ ${CMAKE_INSTALL_PREFIX}/lib/openni2/
            COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/Bin/x64-${CMAKE_BUILD_TYPE}/OpenNI2/ ${CMAKE_INSTALL_PREFIX}/lib/openni2/OpenNI2
            COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/Bin/x64-${CMAKE_BUILD_TYPE}/OpenNI2.lib ${CMAKE_INSTALL_PREFIX}/lib/openni2/OpenNI2.lib
            COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/Include ${CMAKE_INSTALL_PREFIX}/include/openni2
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
            DEPENDEES install
    )
else()
    # Building Prerequisites:
    # - LibUSB 1.0.x
    #     sudo apt-get install libusb-1.0-0-dev
    # - LibUDEV
    #     sudo apt-get install libudev-dev
    # - FreeGLUT3
    #     sudo apt-get install freeglut3-dev
    # - JDK 6.0-0
    #     sudo apt-get install openjdk-6-jdk
        
    ExternalProject_Add(
            openni
            URL ${CACHED_URL}
            DOWNLOAD_DIR ${ARCHIVE_DIR}
            BUILD_IN_SOURCE 1
            CONFIGURE_COMMAND ""
            BUILD_COMMAND ${MAKE} CFG=${CMAKE_BUILD_TYPE} -f <SOURCE_DIR>/Makefile core
            INSTALL_COMMAND ""
            STEP_TARGETS CopyConfigFileToInstall
    )
    
    ExternalProject_Add_Step(openni INSTALL_OPENNI
            COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/Config/ ${CMAKE_INSTALL_PREFIX}/lib/openni2/
            COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/Bin/x64-${CMAKE_BUILD_TYPE}/OpenNI2/ ${CMAKE_INSTALL_PREFIX}/lib/openni2/OpenNI2
            COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/Bin/x64-${CMAKE_BUILD_TYPE}/libOpenNI2.so ${CMAKE_INSTALL_PREFIX}/lib/openni2/libOpenNI2.so
            COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/Include ${CMAKE_INSTALL_PREFIX}/include/openni2
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
            DEPENDEES install
    )
endif()

ExternalProject_Add_Step(openni CopyFindFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/findBinpkgs/FindOpenNI.cmake 
                                    ${CMAKE_INSTALL_PREFIX}/FindOpenNI.cmake
    COMMENT "Install FindOpenNI file"
    DEPENDEES install
)


