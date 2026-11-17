# whisper-dev: removes what earlier builds collected in a dlls folder, so
# the folder holds this build and nothing else. Run first by the 'dlls'
# target (WHISPER_DEV_CLEAN_DLLS, on):
#
#   cmake -DDEST=<dlls folder> -P clean_dlls.cmake
#
# Removed, in DEST itself only: the libraries (lib*.so*, *.dylib, *.dll),
# BUILD-INFO.txt, and the folders the build fills - rocblas/, hipblaslt/
# (ROCm's kernel files) and licences/. Kept: .gitignore, README.md, any
# other file, and every other folder (dlls/debug is a DEST of its own).
cmake_minimum_required(VERSION 3.21)

if (NOT DEST OR NOT IS_DIRECTORY "${DEST}")
    return()
endif()
file(GLOB _old LIST_DIRECTORIES false
    "${DEST}/lib*.so" "${DEST}/lib*.so.*" "${DEST}/*.dylib" "${DEST}/*.dll" "${DEST}/BUILD-INFO.txt")
list(LENGTH _old _n)
if (_old)
    file(REMOVE ${_old})
endif()
set(_folders)
foreach (_d rocblas hipblaslt licences)
    if (IS_DIRECTORY "${DEST}/${_d}")
        file(REMOVE_RECURSE "${DEST}/${_d}")
        list(APPEND _folders "${_d}/")
    endif()
endforeach()
if (_n GREATER 0 OR _folders)
    list(JOIN _folders " " _folders)
    message(STATUS "whisper-dev: ${DEST} emptied of an earlier build (${_n} file(s) ${_folders})")
endif()
