
macro(useOgre)
    set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH};${EXTERNAL_LIBRARIES}/lib/OGRE/cmake)

    find_package(OGRE REQUIRED)

    if(${CMAKE_BUILD_TYPE} STREQUAL "Debug")
        set(OGRE_PLUGIN_DIR "${OGRE_PLUGIN_DIR_DBG}")
    else()
        set(OGRE_PLUGIN_DIR "${OGRE_PLUGIN_DIR_REL}")
    endif()

    # This is a hack to copy plugins inside the build directory
    # Most developers executes apps inside the build directory so this is done as a convenience
    file(GLOB OGRE_PLUGINS "${OGRE_PLUGIN_DIR}/*.so*")
    file(INSTALL ${OGRE_PLUGINS} DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/../ogreplugins")

    # This copies the plugins into the install directory
    install(DIRECTORY ${OGRE_PLUGIN_DIR} DESTINATION "${CMAKE_INSTALL_PREFIX}/ogrePlugins")

    fwInclude(
        ${OGRE_INCLUDE_DIRS}
        ${OGRE_Overlay_INCLUDE_DIRS}
        )

    fwLink(
        ${OGRE_LIBRARIES}
        ${OGRE_Overlay_LIBRARIES}
        )
endmacro()
