cmake_minimum_required(VERSION 3.25)

project({{PROJECT_NAME}} LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

list(APPEND CMAKE_PREFIX_PATH ${CMAKE_BINARY_DIR})

find_package(spdlog REQUIRED CONFIG)
find_package(GTest REQUIRED CONFIG)

add_subdirectory(src)
add_subdirectory(apps)
add_subdirectory(tests)
