add_fortran_library(allocators
        blockAllocator_m.f90)

target_link_libraries(allocators
        PRIVATE utils)

add_subdirectory(tests)
