cmake_minimum_required(VERSION 3.0)

project(ArBinPkgs)

option(ENABLE_EXPERIMENTAL_DEPS "Set to ON to build experimentals libraries" OFF)
option(ENABLE_OPEN_MP "Set to ON use allow the use of OpenMP" OFF)
option(ENABLED_OGRE_DEPS "Set to ON to build ogre" OFF)
option(ENABLED_SOFA_DEPS "Set to ON to build sofa" OFF)
option(ENABLED_PCL_DEPS "Set to ON to build PCL" OFF)

##Desktop Deps##
if(NOT ANDROID)
    list(APPEND SUBDIRECTORIES opencv)
    list(APPEND SUBDIRECTORIES aruco)
    list(APPEND SUBDIRECTORIES eigen)
    list(APPEND SUBDIRECTORIES flann)
    list(APPEND SUBDIRECTORIES bullet)
    list(APPEND SUBDIRECTORIES geodesic)

    if(ENABLED_OGRE_DEPS)
        list(APPEND SUBDIRECTORIES zzip)
        list(APPEND SUBDIRECTORIES freeimage)
        if (NOT APPLE)
            list(APPEND SUBDIRECTORIES ois)
        endif()
        list(APPEND SUBDIRECTORIES ogre)
    endif()

    if(ENABLED_SOFA_DEPS)
        list(APPEND SUBDIRECTORIES glew)
        if (NOT APPLE)
            list(APPEND SUBDIRECTORIES freeglut)
        endif()
        list(APPEND SUBDIRECTORIES glext)
        list(APPEND SUBDIRECTORIES sofa)
    endif()

    if(ENABLED_PCL_DEPS)
        if(UNIX)
            list(APPEND SUBDIRECTORIES libusb)
        endif()
        list(APPEND SUBDIRECTORIES openni)
        list(APPEND SUBDIRECTORIES pcl)
    endif()

    if(ENABLE_EXPERIMENTAL_DEPS)
        list(APPEND SUBDIRECTORIES artoolkitplus)
        list(APPEND SUBDIRECTORIES aram)
        # igstkAurora does not compile, at least on windows, and it is not used (or so have I been told), so just SKIP this !
        #list(APPEND SUBDIRECTORIES igstkAurora)
    endif()
##Android Deps##
else()
    list(APPEND SUBDIRECTORIES opencv)
    list(APPEND SUBDIRECTORIES aruco)
    if(ENABLE_EXPERIMENTAL_DEPS)
        list(APPEND SUBDIRECTORIES ndkgui)
    endif()
    if(ENABLED_PCL_DEPS)
        list(APPEND SUBDIRECTORIES flann)
        list(APPEND SUBDIRECTORIES eigen)
        list(APPEND SUBDIRECTORIES pcl)
    endif()
endif()

get_filename_component(CURRENT_DIR_NAME ${CMAKE_CURRENT_LIST_DIR} NAME)
foreach(subdir ${SUBDIRECTORIES})
    # define an uninstall target for each project
    configure_file(
        "${CMAKE_SOURCE_DIR}/cmake_uninstall.cmake.in"
        "${CMAKE_BINARY_DIR}/additional_deps/${CURRENT_DIR_NAME}/${subdir}/cmake_uninstall.cmake"
        IMMEDIATE @ONLY)

    add_custom_target(${subdir}_uninstall
        COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/additional_deps/${CURRENT_DIR_NAME}/${subdir}/cmake_uninstall.cmake)

    # define the standard location for the intermediate install directory
    set(INSTALL_PREFIX_${subdir} ${CMAKE_CURRENT_BINARY_DIR}/${subdir}/${subdir}-prefix/src/${subdir}-install-tmp)

    add_subdirectory(${subdir})
endforeach()
