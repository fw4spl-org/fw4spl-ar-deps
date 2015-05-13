cmake_minimum_required(VERSION 2.8)

project(libusbBuilder)

include(ExternalProject)

# getCachedUrl(https://github.com/libusb/libusb/archive/v1.0.19.tar.gz CACHED_URL)
getCachedUrl(http://sourceforge.net/projects/libusb/files/libusb-1.0/libusb-1.0.19/libusb-1.0.19.tar.bz2/download CACHED_URL)

if (APPLE)
    set(SETENV export CC=${CMAKE_C_COMPILER}
        CXX=${CMAKE_CXX_COMPILER}
        "LDFLAGS=-framework IOKit -framework CoreFoundation -arch i386 -arch x86_64 "
        "CFLAGS=-arch i386 -arch x86_64 "
        &&
    )
    set(LIBUSB_CONFIGURE_CMD
        ./configure
        --prefix=${INSTALL_PREFIX_libusb}/${CMAKE_INSTALL_PREFIX}
        --disable-dependency-tracking
    )
else()
    set(SETENV export CC=${CMAKE_C_COMPILER}
        CXX=${CMAKE_CXX_COMPILER}
        "LDFLAGS=-arch i386 -arch x86_64 "
        "CFLAGS=-arch i386 -arch x86_64 "
        &&
    )
    set(LIBUSB_CONFIGURE_CMD
        ./configure
        --prefix=${INSTALL_PREFIX_libusb}/${CMAKE_INSTALL_PREFIX}
    )
endif()

ExternalProject_Add(
    libusb
    URL ${CACHED_URL}
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    BUILD_IN_SOURCE 1
    CONFIGURE_COMMAND ${SETENV} ${LIBUSB_CONFIGURE_CMD}
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
)

ExternalProject_Add_Step(libusb COPY_FILES
    COMMAND ${CMAKE_COMMAND} -D SRC:PATH=${INSTALL_PREFIX_libusb} -D DST:PATH=${CMAKE_INSTALL_PREFIX} -P ${CMAKE_SOURCE_DIR}/Install.txt
    DEPENDEES install
)
