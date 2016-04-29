
ExternalProject_Add(
    vlfeat
    URL ${CACHED_URL}
    URL_HASH SHA256=fe972ab657d550a1044df1a782b02f71d725d62e53970a63a98ecb1353dd011a
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ${MAKE} MEX="" DEBUG=${DEBUG} INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    INSTALL_COMMAND ${MAKE} install MEX="" DEBUG=${DEBUG} INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
    STEP_TARGETS CopyConfigFileToInstall
)

ExternalProject_Add_Step(vlfeat CopyConfigFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/findBinpkgs/fw-vlfeat.cmake ${CMAKE_INSTALL_PREFIX}/fw-vlfeat.cmake
    COMMENT "Install configuration file"
)
