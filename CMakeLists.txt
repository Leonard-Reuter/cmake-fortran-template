cmake_minimum_required(VERSION 3.14)

### options
option(WARNINGS "ON - display compiler warnings, OFF - do not display compiler warnings" ON)
option(PFUNIT "ON - using pFUnit for unit tests, OFF - skip building unit tests" ON)

# defines project name and used language
project(FortranTemplate 
  LANGUAGES Fortran)

# adding pFUnit support
if (${PFUNIT})
  enable_testing()
  if (DEFINED ENV{PFUNIT_DIR})
    message("using pFUnit installed at $ENV{PFUNIT_DIR}")
    find_package(PFUNIT)
  else ()
    set(PFUNIT_VERSION "v4.6.0")
    message("PFUNIT_DIR not set, downloading pFUnit ${PFUNIT_VERSION}")
    include(FetchContent)
    set(FETCHCONTENT_BASE_DIR ${CMAKE_BINARY_DIR}/pFUnit)
    FetchContent_Declare(
      PFUNIT
      GIT_REPOSITORY "https://github.com/Leonard-Reuter/pFUnit"
      GIT_TAG 932993aaa2aeae3d2638fc21a25d5c72b4da3948 
    )  
    FetchContent_MakeAvailable(PFUNIT)
  endif()
else()
  # dummy function replacing add_pfunit_ctest
  function(add_pfunit_ctest arg)
  endfunction()
endif()

# sets compiler flags
include(cmake/utils/setFlags.cmake)

# adds custom cmake functions
include(cmake/utils/fortranFunctions.cmake)

# sets path for executables
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR}/bin)

# adds subdirectories
add_subdirectory(utils)
add_subdirectory(src)

