add_pfunit_ctest(allocator_tests
  TEST_SOURCES blockAllocator_test.pf
  LINK_LIBRARIES utils;allocators
  LABELS "allocators"
)
