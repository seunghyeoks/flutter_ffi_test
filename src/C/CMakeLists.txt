# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(file_access_through_golang_library VERSION 0.0.1 LANGUAGES C)

add_library(file_access_through_golang SHARED
  "file_access_through_golang.c"
)

set_target_properties(file_access_through_golang PROPERTIES
  PUBLIC_HEADER file_access_through_golang.h
  OUTPUT_NAME "file_access_through_golang"
)

target_compile_definitions(file_access_through_golang PUBLIC DART_SHARED_LIB)
