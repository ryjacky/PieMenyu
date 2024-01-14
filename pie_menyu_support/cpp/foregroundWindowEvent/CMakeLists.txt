cmake_minimum_required(VERSION 3.23)
project(foregroundWindowEvent)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_EXE_LINKER_FLAGS "-static")

add_executable(foregroundWindowEvent main.cpp)
