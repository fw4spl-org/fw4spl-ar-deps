set(VLFEAT_PATCH_DIR ${CMAKE_CURRENT_SOURCE_DIR}/patch)
set(VLFEAT_PATCH_CMD "${PATCH_EXECUTABLE}" -p1 -i ${VLFEAT_PATCH_DIR}/ConditionalMex.diff -d <SOURCE_DIR>)

ExternalProject_Add(
    vlfeat
    URL ${CACHED_URL}
    URL_HASH SHA256=${VLFEAT_HASH}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DOWNLOAD_NAME vlfeat-0.9.21.tar.gz
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ""
    PATCH_COMMAND ${VLFEAT_PATCH_CMD}
    BUILD_COMMAND ${MAKE} -f <SOURCE_DIR>/Makefile.mak MEX="" DEBUG=${CMAKE_BUILD_TYPE} INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}    
    INSTALL_COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/CopyFiles.cmake
    STEP_TARGETS CopyConfigFileToInstall    
)

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/CopyFiles.cmake
    "
     file(INSTALL ${CMAKE_CURRENT_BINARY_DIR}/vlfeat-prefix/src/vlfeat/bin/win64/vl.dll DESTINATION ${CMAKE_INSTALL_PREFIX}/bin)
     file(INSTALL ${CMAKE_CURRENT_BINARY_DIR}/vlfeat-prefix/src/vlfeat/bin/win64/vl.lib DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
     file(INSTALL ${CMAKE_CURRENT_BINARY_DIR}/vlfeat-prefix/src/vlfeat/vl DESTINATION ${CMAKE_INSTALL_PREFIX}/include FILES_MATCHING PATTERN \"*.h\")
    "
)

ExternalProject_Add_Step(vlfeat CopyConfigFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_SOURCE_DIR}/../cmake/findBinpkgs/fw-vlfeat.cmake ${CMAKE_INSTALL_PREFIX}/fw-vlfeat.cmake
    COMMENT "Install configuration file"
)
