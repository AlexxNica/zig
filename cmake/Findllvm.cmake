# Copyright (c) 2014 Andrew Kelley
# This file is MIT licensed.
# See http://opensource.org/licenses/MIT

# LLVM_FOUND
# LLVM_INCLUDE_DIR
# LLVM_LIBRARIES
# LLVM_LIBDIRS

find_program(LLVM_CONFIG_EXE NAMES llvm-config llvm-config-3.8)

execute_process(
    COMMAND ${LLVM_CONFIG_EXE} --libs
    OUTPUT_VARIABLE LLVM_LIBRARIES
    OUTPUT_STRIP_TRAILING_WHITESPACE)

execute_process(
    COMMAND ${LLVM_CONFIG_EXE} --system-libs
    OUTPUT_VARIABLE LLVM_SYSTEM_LIBS_TMP
    OUTPUT_STRIP_TRAILING_WHITESPACE)
separate_arguments(LLVM_SYSTEM_LIBS_TMP)
foreach(lib ${LLVM_SYSTEM_LIBS_TMP})
    string(REGEX REPLACE "^-l" "" lib_fixed ${lib})
    list(APPEND LLVM_SYSTEM_LIBS ${lib_fixed})
endforeach()

execute_process(
    COMMAND ${LLVM_CONFIG_EXE} --libdir
    OUTPUT_VARIABLE LLVM_LIBDIRS
    OUTPUT_STRIP_TRAILING_WHITESPACE)

execute_process(
    COMMAND ${LLVM_CONFIG_EXE} --includedir
    OUTPUT_VARIABLE LLVM_INCLUDE_DIR
    OUTPUT_STRIP_TRAILING_WHITESPACE)

find_library(LLVM_LIBRARY NAMES LLVM)

if(LLVM_LIBRARY)
  set(LLVM_LIBRARIES ${LLVM_LIBRARY})
endif()


set(LLVM_LIBRARIES ${LLVM_LIBRARIES} ${LLVM_SYSTEM_LIBS})


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(LLVM DEFAULT_MSG LLVM_LIBRARIES LLVM_INCLUDE_DIR)

mark_as_advanced(LLVM_INCLUDE_DIR LLVM_LIBRARIES LLVM_LIBDIRS)
