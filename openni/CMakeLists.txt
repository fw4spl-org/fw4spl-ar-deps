cmake_minimum_required(VERSION 2.8)

project(openniBuilder)

include(ExternalProject)

if(WIN32)
    # get archive on commit 70da8eb: Upgrade all VS projects to MSVC12 (Visual Studio 2013). 
    getCachedUrl(https://github.com/occipital/OpenNI2/archive/70da8eb798048a7c5baa5ae20672b5a2dc6cc7fe.tar.gz CACHED_URL)
    ExternalProject_Add(
            openni
            URL ${CACHED_URL}
            DOWNLOAD_DIR ${ARCHIVE_DIR}
            BUILD_IN_SOURCE 1
            CONFIGURE_COMMAND ""
            BUILD_COMMAND devenv OpenNI.sln /project OpenNI /build ${CMAKE_BUILD_TYPE}
            INSTALL_COMMAND ""
            STEP_TARGETS CopyConfigFileToInstall
    )
    ExternalProject_Add_Step(
            openni INSTALL_OPENNI
            COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/Config/ ${CMAKE_INSTALL_PREFIX}/lib/openni2/
            COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/Bin/x64-${CMAKE_BUILD_TYPE}/OpenNI2/ ${CMAKE_INSTALL_PREFIX}/lib/openni2/OpenNI2
            COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/Bin/x64-${CMAKE_BUILD_TYPE}/OpenNI2.lib ${CMAKE_INSTALL_PREFIX}/lib/openni2/OpenNI2.lib
            COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/Bin/x64-${CMAKE_BUILD_TYPE}/OpenNI2.dll ${CMAKE_INSTALL_PREFIX}/bin/OpenNI2.dll
            COMMAND ${CMAKE_COMMAND} -E copy_directory <SOURCE_DIR>/Include ${CMAKE_INSTALL_PREFIX}/include/openni2
            WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
            DEPENDEES install
    )
else()
    getCachedUrl(https://github.com/occipital/OpenNI2/archive/v2.2.0-debian.tar.gz CACHED_URL)
    # Building Prerequisites:
    # - LibUSB 1.0.x
    #     sudo apt-get install libusb-1.0-0-dev
    # - LibUDEV
    #     sudo apt-get install libudev-dev


    #Patch the Makefile to create a minimal target with only OpenNI lib and drivers (it remove also dependencies to jdk and freeglut)
    set(ONI_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patches)
    set(ONI_PATCH_COMMAND ${CMAKE_COMMAND} -E copy ${ONI_PATCH_DIR}/Makefile ${CMAKE_CURRENT_BINARY_DIR}/openni-prefix/src/openni/Makefile)
        
    ExternalProject_Add(
            openni
            URL ${CACHED_URL}
            DOWNLOAD_DIR ${ARCHIVE_DIR}
            PATCH_COMMAND ${ONI_PATCH_COMMAND} 
            BUILD_IN_SOURCE 1
            CONFIGURE_COMMAND ""
            BUILD_COMMAND ${MAKE} CFG=${CMAKE_BUILD_TYPE} -f <SOURCE_DIR>/Makefile minimum
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


