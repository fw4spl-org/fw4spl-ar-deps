cmake_minimum_required(VERSION 2.8)

project(glmBuilder)

include(ExternalProject)

set(GLM_CMAKE_ARGS 
    -DCMAKE_PREFIX_PATH=${CMAKE_INSTALL_PREFIX}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX} 
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DBUILD_DOXYGEN:BOOL=OFF
)

getCachedUrl(http://downloads.sourceforge.net/project/ogl-math/glm-0.9.5.4/glm-0.9.5.4.zip CACHED_URL)

ExternalProject_Add(
    glm
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${GLM_CMAKE_ARGS}
    STEP_TARGETS CopyConfigFileToInstall
)

ExternalProject_Add_Step(glm CopyConfigFileToInstall
    COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_CURRENT_BINARY_DIR}/glm-prefix/src/glm/util/FindGLM.cmake ${CMAKE_INSTALL_PREFIX}/FindGLM.cmake
    COMMENT "Install configuration file"
)

