CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

PROJECT(ArBinPkgs)

list(APPEND SUBDIRECTORIES opencv)
list(APPEND SUBDIRECTORIES artoolkitplus)
list(APPEND SUBDIRECTORIES aruco)
list(APPEND SUBDIRECTORIES eigen)
list(APPEND SUBDIRECTORIES flann)
list(APPEND SUBDIRECTORIES igstkAurora)
list(APPEND SUBDIRECTORIES pcl)
list(APPEND SUBDIRECTORIES bullet)

FOREACH(subdir ${SUBDIRECTORIES})
    # define an uninstall target for each project
    configure_file(
        "${CMAKE_SOURCE_DIR}/cmake_uninstall.cmake.in"
        "${CMAKE_BINARY_DIR}/${subdir}/cmake_uninstall.cmake"
        IMMEDIATE @ONLY)

    add_custom_target(${subdir}_uninstall
        COMMAND ${CMAKE_COMMAND} -P ${CMAKE_BINARY_DIR}/${subdir}/cmake_uninstall.cmake)

    # define the standard location for the intermediate install directory
    SET(INSTALL_PREFIX_${subdir} ${CMAKE_CURRENT_BINARY_DIR}/${subdir}/${subdir}-prefix/src/${subdir}-install-tmp)

    ADD_SUBDIRECTORY(${subdir})
ENDFOREACH()
