
message("${SOURCE_DIR}")
message("${CMAKE_BINARY_DIR}")
message("${CMAKE_INSTALL_PREFIX}")

file(GLOB_RECURSE HEADER_LIST RELATIVE ${SOURCE_DIR}   ${SOURCE_DIR}/framework/*.hpp
                                                       ${SOURCE_DIR}/framework/*.h
                                                       ${SOURCE_DIR}/framework/*.inl
                                                       ${SOURCE_DIR}/applications/*.hpp
                                                       ${SOURCE_DIR}/applications/*.h
                                                       ${SOURCE_DIR}/applications/*.inl
                                                       ${SOURCE_DIR}/modules/*.hpp
                                                       ${SOURCE_DIR}/modules/*.h
                                                       ${SOURCE_DIR}/modules/*.inl
                                                       ${SOURCE_DIR}/extlibs/tinyxml/*.hpp
                                                       ${SOURCE_DIR}/extlibs/tinyxml/*.h
                                                       ${SOURCE_DIR}/extlibs/tinyxml/*.inl
                                                       ${SOURCE_DIR}/extlibs/newmat/*.hpp
                                                       ${SOURCE_DIR}/extlibs/newmat/*.h
                                                       ${SOURCE_DIR}/extlibs/newmat/*.inl)

# Copy header files
foreach(HEADER IN LISTS HEADER_LIST)
    string(REGEX REPLACE "^(.*/)" "" HEADER_FILE ${HEADER})
    string(REPLACE "/${HEADER_FILE}" "" HEADER_DIR ${HEADER})
	file( INSTALL "${SOURCE_DIR}/${HEADER}" DESTINATION ${CMAKE_INSTALL_PREFIX}/include/sofa/${HEADER_DIR} )

endforeach()

# Copy libs
file( COPY ${CMAKE_BINARY_DIR}/lib DESTINATION ${CMAKE_INSTALL_PREFIX} )

# Copy findSofa module
file( INSTALL "${SOURCE_DIR}/cmake/Modules/FindSOFA.cmake" DESTINATION ${CMAKE_INSTALL_PREFIX} )
file( INSTALL "${SOURCE_DIR}/cmake/Modules/find_lib.cmake" DESTINATION ${CMAKE_INSTALL_PREFIX} )
