cmake_minimum_required(VERSION 2.8)

project(FreeImageBuilder)

include(ExternalProject)

getCachedUrl(https://github.com/greenjava/FreeImage/archive/FreeImage_3.16.0.a.tar.gz CACHED_URL)

set(FREEIMAGE_CMAKE_ARGS -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
                    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
                    -DBUILD_SHARED_LIBS:BOOL=ON
                    -DFREEIMAGE_BUILD_STATIC:BOOL=OFF
                    -DFREEIMAGE_USE_SYSTEM_ZLIB:BOOL=ON
                    -DFREEIMAGE_USE_SYSTEM_JPEG:BOOL=ON
                    -DFREEIMAGE_USE_SYSTEM_PNG:BOOL=ON
                    -DINSTALL_WRAPPER:BOOL=OFF
                    -DINSTALL_EXAMPLES:BOOL=OFF
)

ExternalProject_Add(
    freeimage
    URL ${CACHED_URL}
    URL_HASH SHA256=7b356a2cf7932d8bfe13be62e602d829863f997ba09ae68b71670b348aa3d971
    DOWNLOAD_DIR ${ARCHIVE_DIR}
    DEPENDS zlib libpng tiff jpeg
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    CMAKE_ARGS ${FREEIMAGE_CMAKE_ARGS}
)


