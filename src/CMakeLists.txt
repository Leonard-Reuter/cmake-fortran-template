add_executable(main.bin main_p.f90)

target_link_libraries(main.bin
        PRIVATE utils
        PRIVATE allocators)

add_subdirectory(allocators)
