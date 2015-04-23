cmake_minimum_required(VERSION 2.8)

project(ArBinPkgs)

option(ENABLE_EXPERIMENTAL_DEPS "Set to ON to build experimentals libraries" OFF)

##Desktop Deps##
if(NOT ANDROID)
    list(APPEND SUBDIRECTORIES opencv)
    list(APPEND SUBDIRECTORIES aruco)
    list(APPEND SUBDIRECTORIES eigen)
    list(APPEND SUBDIRECTORIES flann)
    list(APPEND SUBDIRECTORIES bullet)
    
    if(ENABLE_EXPERIMENTAL_DEPS)
        list(APPEND SUBDIRECTORIES artoolkitplus)
        list(APPEND SUBDIRECTORIES aram)
        list(APPEND SUBDIRECTORIES igstkAurora)
        list(APPEND SUBDIRECTORIES ois)
        list(APPEND SUBDIRECTORIES zzip)
        list(APPEND SUBDIRECTORIES freeimage)
        list(APPEND SUBDIRECTORIES ogre)
        list(APPEND SUBDIRECTORIES pcl)
        list(APPEND SUBDIRECTORIES glew)
        list(APPEND SUBDIRECTORIES freeglut)
        list(APPEND SUBDIRECTORIES glext)
        list(APPEND SUBDIRECTORIES sofa)
        list(APPEND SUBDIRECTORIES geodesic)
        list(APPEND SUBDIRECTORIES openni)
    endif()
    
##Android Deps##
else()
    list(APPEND SUBDIRECTORIES opencv)
    list(APPEND SUBDIRECTORIES aruco)
endif()

foreach(subdir ${SUBDIRECTORIES})
    # define an uninstall target for each project
    configure_file(
        "${CMAKE_SOURCE_DIR}/cmake_uninstall.cmake.in"
        "${CMAKE_BINARY_DIR}/additional_deps/ar/${subdir}/cmake_uninstall.cmake"
        IMMEDIATE @ONLY)

    add_custom_target(${subdir}_uninstall
        COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/additional_deps/ar/${subdir}/cmake_uninstall.cmake)

    # define the standard location for the intermediate install directory
    set(INSTALL_PREFIX_${subdir} ${CMAKE_CURRENT_BINARY_DIR}/${subdir}/${subdir}-prefix/src/${subdir}-install-tmp)

    add_subdirectory(${subdir})
endforeach()
