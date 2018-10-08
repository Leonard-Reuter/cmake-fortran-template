# sets flags for the compiler
message("cmake identified compiler as ${CMAKE_Fortran_COMPILER_ID}.")
message("  with full path ${CMAKE_Fortran_COMPILER}")

# reads flags from cmake/flags
include(cmake/flags/${CMAKE_Fortran_COMPILER_ID}.cmake OPTIONAL RESULT_VARIABLE STATUS)

if (${STATUS} STREQUAL NOTFOUND)
    message( FATAL_ERROR "Flags for ${CMAKE_Fortran_COMPILER_ID} are not specified in cmake/flags") 
endif()

set(FLAGS "${PP_FLAGS}")

# sets warning flags
if(${WARNINGS})
    set(FLAGS "${FLAGS} ${WARN_FLAGS}")
else()
    set(FLAGS "${FLAGS} ${NOWARN_FLAGS}")
endif()

# sets final fortran flags
set(CMAKE_Fortran_FLAGS         "${FLAGS} ")

# adds build-dependent compiler flags
set(CMAKE_Fortran_FLAGS_DEBUG   "${DEBUG_FLAGS}")
set(CMAKE_Fortran_FLAGS_RELEASE "${RELEASE_FLAGS}")

# sets OpenMP flags. CMAKE_Fortran_OMP_FLAG variable is custom
if(${OPENMP})
    set(CMAKE_Fortran_OMP_FLAG "${OPENMP_FLAGS}")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${CMAKE_Fortran_OMP_FLAG}")
endif()
