cmake_minimum_required(VERSION 2.8)

if(NOT PATCH_EXECUTABLE)

    message(STATUS "Checking for patch")
    
    find_program(PATCH_EXECUTABLE 
        NAME patch rustine
        PATHS "usr/bin"
              "$ENV{ProgramFiles}/GnuWin32/bin"
              "$ENV{ProgramFiles(x86)}/GnuWin32/bin"
              "$ENV{ProgramFiles}/Git/bin"
              "$ENV{ProgramFiles(x86)}/Git/bin"
              ${CMAKE_BINARY_DIR}/patch
    )
    
    if(NOT PATCH_EXECUTABLE)
        if(WIN32)
            #download patch for Windows
            set(PATCH_URL http://freefr.dl.sourceforge.net/project/gnuwin32/patch/2.5.9-7/patch-2.5.9-7-bin.zip)
            file(DOWNLOAD ${PATCH_URL} ${CMAKE_BINARY_DIR}/patch/patch-2.5.9-7-bin.zip
                 SHOW_PROGRESS
                 EXPECTED_MD5 b9c8b31d62f4b2e4f1887bbb63e8a905)
            execute_process(COMMAND ${CMAKE_COMMAND} -E tar xvf patch-2.5.9-7-bin.zip
                            WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/patch/")
            #hack to fix problem with GNU patch and Windows UAC
            file(RENAME "${CMAKE_BINARY_DIR}/patch/bin/patch.exe" "${CMAKE_BINARY_DIR}/patch/bin/rustine.exe")
            set(PATCH_EXECUTABLE "${CMAKE_BINARY_DIR}/patch/bin/rustine.exe")
        else()
            message(FATAL_ERROR "Patch not found")
        endif()
    endif()
    
    message(STATUS "Found patch: ${PATCH_EXECUTABLE}")
    
    set(PATCH_EXECUTABLE ${PATCH_EXECUTABLE} CACHE STRING "Patch executable" FORCE )
    
endif()


macro(patch_file baseDir patchFile)
    execute_process(COMMAND ${PATCH_EXECUTABLE} -p1 -i "${patchFile}"
                    WORKING_DIRECTORY "${baseDir}")
endmacro()
