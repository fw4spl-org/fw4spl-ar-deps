CMAKE_MINIMUM_REQUIRED(VERSION 2.4)

# loose if - else constructs
SET(CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS TRUE)

# add some functions we use that are shipped with cmake
INCLUDE(CheckLibraryExists)
INCLUDE(CheckIncludeFile)
INCLUDE(CheckCCompilerFlag)
INCLUDE(CheckCSourceCompiles)

# define the project
PROJECT(OIS)

OPTION(BUILD_DEMOS "build ffconsole and console demos" FALSE)
OPTION(BUILD_SHARED_LIBS "build shared lib" TRUE)
         
# general flags for all platforms
ADD_DEFINITIONS("-D_LIB")
# add include directory for ois lib
INCLUDE_DIRECTORIES(includes)

# platform specific things
IF(WIN32)
    # add some flag that removes a lot of false warnings
    ADD_DEFINITIONS("-D_CRT_SECURE_NO_WARNINGS")
    FILE(GLOB sources src/*.cpp src/win32/*.cpp src/*.h src/win32/*.h)
    
    IF(BUILD_DEMOS)
        SET(ffconsole_src demos/FFConsoleDemo.cpp demos/FFConsoleDemoResource.rc)
        SET(console_src demos/OISConsole.cpp demos/OISConsoleResource.rc)
    ENDIF(BUILD_DEMOS)
    
    # need DirectX includes and libraries
    INCLUDE_DIRECTORIES($ENV{DXSDK_DIR}/include)
    IF(CMAKE_CL_64)
        LINK_DIRECTORIES($ENV{DXSDK_DIR}/Lib/x64)
    ELSE(CMAKE_CL_64)
        LINK_DIRECTORIES($ENV{DXSDK_DIR}/Lib/x86)
    ENDIF(CMAKE_CL_64)
    
    SET(OS_LIBS dinput8 dxguid)
      
    CHECK_INCLUDE_FILE(windows.h HAVE_WINDOWS_INCLUDES)
    IF(NOT HAVE_WINDOWS_INCLUDES)
        MESSAGE(FATAL_ERROR "could not find the windows platform includes. Please install them.")
    ENDIF()
ELSEIF(NOT APPLE)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -include unistd.h")
    FILE(GLOB sources src/*.cpp src/linux/*.cpp src/*.h src/linux/*.h)
    SET(OS_LIBS X11)
    IF(BUILD_DEMOS)
        SET(ffconsole_src demos/FFConsoleDemo.cpp)
        SET(console_src demos/OISConsole.cpp)
    ENDIF(BUILD_DEMOS)
    # check for libs and include files we want to use
    CHECK_LIBRARY_EXISTS(X11 XOpenDisplay "" HAVE_X11_LIBS)
    IF(NOT HAVE_X11_LIBS)
        MESSAGE(FATAL_ERROR "could not link against X11, please check of you have the required libraries installed")
    ENDIF()
    CHECK_INCLUDE_FILE(X11/keysym.h HAVE_X11_INCLUDES)
    IF(NOT HAVE_X11_INCLUDES)
        MESSAGE(FATAL_ERROR "could not find the X11 includes. Please install them.")
    ENDIF()
ELSE()
    FILE(GLOB sources src/*.cpp src/mac/*.cpp includes/*.h includes/mac/*.h)
    find_library(OS_LIBS CoreFoundation)
    find_library(IOKIT IOKit)
    IF(BUILD_DEMOS)
        SET(ffconsole_src demos/FFConsoleDemo.cpp)
        SET(console_src demos/OISConsole.cpp)
    ENDIF(BUILD_DEMOS)
ENDIF(WIN32)


SET(LIB_MAJOR_VERSION "1")
SET(LIB_MINOR_VERSION "3")
SET(LIB_BUILD_VERSION "0")
SET(LIB_VERSION "${LIB_MAJOR_VERSION}.${LIB_MINOR_VERSION}.${LIB_BUILD_VERSION}")
IF(NOT DEFINED LIB_INSTALL_DIR)
  SET(LIB_INSTALL_DIR "lib${LIB_SUFFIX}")
ENDIF(NOT DEFINED LIB_INSTALL_DIR)


# Needed for OIS.pc.in
SET(prefix ${CMAKE_INSTALL_PREFIX})
SET(exec_prefix "\${prefix}")
SET(libdir "\${exec_prefix}/${LIB_INSTALL_DIR}")
SET(bindir "\${exec_prefix}/bin")
SET(includedir "\${prefix}/include")
SET(PACKAGE_NAME "OIS")
SET(PACKAGE_VERSION "${LIB_VERSION}")

CONFIGURE_FILE(
    "${OIS_SOURCE_DIR}/OIS.pc.in"
    "${OIS_BINARY_DIR}/OIS.pc"
    @ONLY)

# some additional compiler flags
ADD_DEFINITIONS(-Wall)
CHECK_C_COMPILER_FLAG(-Wextra HAVE_W_EXTRA)
IF(HAVE_W_EXTRA)
    ADD_DEFINITIONS(-Wextra)
ENDIF()

# build the library
SET(LIBNAME "OIS")
IF(BUILD_SHARED_LIBS)
    ADD_DEFINITIONS(-DOIS_DYNAMIC_LIB)
    ADD_DEFINITIONS(-DOIS_NONCLIENT_BUILD)
    ADD_LIBRARY(${LIBNAME} SHARED ${sources})
ELSE(BUILD_SHARED_LIBS)
    ADD_LIBRARY(${LIBNAME} STATIC ${sources})
ENDIF(BUILD_SHARED_LIBS)
TARGET_LINK_LIBRARIES(${LIBNAME} ${OS_LIBS} ${IOKIT})
SET_TARGET_PROPERTIES(${LIBNAME} PROPERTIES VERSION ${LIB_VERSION} SOVERSION ${LIB_MAJOR_VERSION})

IF(BUILD_DEMOS)
    # build ffconsole demo
    ADD_EXECUTABLE(ffconsole ${ffconsole_src})
    TARGET_LINK_LIBRARIES(ffconsole ${LIBNAME})
    # build console demo
    ADD_EXECUTABLE(console ${console_src})
    TARGET_LINK_LIBRARIES(console ${LIBNAME})
ENDIF(BUILD_DEMOS)

# install the library
INSTALL(TARGETS ${LIBNAME}
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION ${LIB_INSTALL_DIR}
        ARCHIVE DESTINATION ${LIB_INSTALL_DIR}
)
# install the headers
INSTALL(DIRECTORY includes/ DESTINATION include/OIS FILES_MATCHING PATTERN "*.h" PATTERN ".svn" EXCLUDE)

# install the PkgConfig file
INSTALL(FILES "${OIS_BINARY_DIR}/OIS.pc" DESTINATION "${LIB_INSTALL_DIR}/pkgconfig")
