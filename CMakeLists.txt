cmake_minimum_required(VERSION 3.5)

### options
option(WARNINGS "ON - display compiler warnings, OFF - do not display compiler warnings" ON)
option(OPENMP "ON - enables adding of OpenMP targets, OFF - disables adding of OpenMP targets" OFF)
option(PFUNIT "ON - using pFUnit for unit tests, OFF - skip building unit tests" OFF)

# defines project name and used language
project(FortranTemplate Fortran)

# sets compiler flags
include(cmake/utils/setFlags.cmake)

# sets path for executables
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR}/bin)

# adds custom cmake functions
include(cmake/utils/fortranFunctions.cmake)

# adding pFUnit support
include(cmake/utils/pFUnit.cmake)

# adds subdirectories
add_subdirectory(utils)
add_subdirectory(src)

