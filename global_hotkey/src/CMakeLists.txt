# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(global_hotkey_library VERSION 0.0.1 LANGUAGES C)

add_library(global_hotkey SHARED
  "global_hotkey.c"
)

set_target_properties(global_hotkey PROPERTIES
  PUBLIC_HEADER global_hotkey.h
  OUTPUT_NAME "global_hotkey"
)

target_compile_definitions(global_hotkey PUBLIC DART_SHARED_LIB)
