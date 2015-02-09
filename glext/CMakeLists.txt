cmake_minimum_required(VERSION 2.8)

project(glextBuilder)

file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/glext_download.cmake "
     file(DOWNLOAD http://www.opengl.org/registry/api/glext.h  ${CMAKE_INSTALL_PREFIX}/include/GL/glext.h)
     file(DOWNLOAD http://www.opengl.org/registry/api/glxext.h ${CMAKE_INSTALL_PREFIX}/include/GL/glxext.h)
     file(DOWNLOAD http://www.opengl.org/registry/api/wglext.h ${CMAKE_INSTALL_PREFIX}/include/GL/wglext.h)"
)

add_custom_target(glext COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/glext_download.cmake)
