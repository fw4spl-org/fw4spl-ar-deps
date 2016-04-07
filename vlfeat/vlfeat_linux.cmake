
ExternalProject_Add(
    vlfeat
    URL ${CACHED_URL}
    URL_HASH SHA256=d15bbee448e983eaf68846c76108369f0d0a46f935ddf9b3f717a877ff03f82a
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DOWNLOAD_NAME vlfeat-0.20.tar.gz
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
