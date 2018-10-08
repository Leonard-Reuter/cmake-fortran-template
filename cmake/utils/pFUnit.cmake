### for the use of pFUnit

if (${PFUNIT})
  enable_testing()
  include(ExternalProject)

  # python is needed for the preprocessing
  find_program(PYTHON python)

  set(PFUNIT_BUILD_PATH ${PROJECT_BINARY_DIR}/pFUnit)

  # this way, pFUnit is configured during the cmake build step
  ExternalProject_Add(pFUnit
    PREFIX pFUnit
    SOURCE_DIR ${PROJECT_SOURCE_DIR}/pFUnit
    BINARY_DIR ${PFUNIT_BUILD_PATH}
    TMP_DIR ${PFUNIT_BUILD_PATH}/tmp
    STAMP_DIR ${PFUNIT_BUILD_PATH}/stamp
    CMAKE_ARGS
          "-DCMAKE_INSTALL_PREFIX=${PFUNIT_BUILD_PATH}"
          "-DINSTALL_PATH=${PFUNIT_BUILD_PATH}"
          "-DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER}"
  )

  add_test(NAME pFUnitTest
           COMMAND ${PFUNIT_BUILD_PATH}/tests/tests.x
           WORKING_DIRECTORY ${PFUNIT_BUILD_PATH})

  set_tests_properties(pFUnitTest
          PROPERTIES LABELS "pFUnit;${PROJECT_NAME}")

  function(add_pFUnit_test moduleName libraries)
  # Input:
  # - moduleName: name of a module, used for the name of the test
  # - libraries:  list of libraries, that are needed to build the *.pf files
  # The list of libraries has to be given as "${libraries}" when this function is used

    # testSuites.inc is read by driver.F90 to know, which tests to compile
    file(WRITE ${CMAKE_CURRENT_BINARY_DIR}/testSuites.inc "")

    # storing *.pf files in testlist
    file(GLOB testlist RELATIVE ${CMAKE_CURRENT_LIST_DIR} ${CMAKE_CURRENT_LIST_DIR}/*.pf)

    foreach(testfile ${testlist})
      # setting test to the basename of testfile
      string(REPLACE ".pf" "" test ${testfile})

      # the actual preprocessing with pFUnitParser.py
      add_custom_command(
        OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${test}.f90
        COMMAND ${PYTHON} ${PFUNIT_BUILD_PATH}/bin/pFUnitParser.py ${CMAKE_CURRENT_LIST_DIR}/${test}.pf ${CMAKE_CURRENT_BINARY_DIR}/${test}.f90
        DEPENDS pFUnit ${CMAKE_CURRENT_LIST_DIR}/${test}.pf)

      # adding the test to testSuites.inc
      file(APPEND ${CMAKE_CURRENT_BINARY_DIR}/testSuites.inc "ADD_TEST_SUITE(${test}_suite)\n")

      # appending to a list of preprocessed files
      list(APPEND ppSources ${CMAKE_CURRENT_BINARY_DIR}/${test}.f90)
    endforeach()

    add_executable(${moduleName}Tests.bin
      ${PROJECT_SOURCE_DIR}/pFUnit/include/driver.F90
      ${ppSources})

    target_include_directories(${moduleName}Tests.bin
                 # for the pFUnit modules
                 PUBLIC ${PFUNIT_BUILD_PATH}/mod
                 # for testSuite.inc
                 PUBLIC ${CMAKE_CURRENT_BINARY_DIR}
                 )

    target_link_libraries(${moduleName}Tests.bin
      ${PFUNIT_BUILD_PATH}/lib/libpfunit.a
      ${libraries})

    add_test(NAME ${moduleName}Tests
            COMMAND ${EXECUTABLE_OUTPUT_PATH}/${moduleName}Tests.bin --verbose)

    set_tests_properties(${moduleName}Tests
          PROPERTIES LABELS "${moduleName};UnitTest;${PROJECT_NAME}")
  endfunction(add_pFUnit_test)
else()
  function(add_pFUnit_test moduleName libraries)
  endfunction(add_pFUnit_test)
endif()
