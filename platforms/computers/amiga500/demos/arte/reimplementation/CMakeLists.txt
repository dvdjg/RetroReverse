cmake_minimum_required(VERSION 3.16)
project(arte_reimplementation LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(arte
    src/spec.cpp
    src/game.cpp
    src/main.cpp
)
target_include_directories(arte PRIVATE include)

# SDL3 opcional: si está disponible, se activa el bucle de render.
find_package(SDL3 QUIET)
if(SDL3_FOUND)
    target_compile_definitions(arte PRIVATE ARTE_WITH_SDL)
    target_link_libraries(arte PRIVATE SDL3::SDL3)
    message(STATUS "SDL3 encontrado: bucle de render disponible")
else()
    message(STATUS "SDL3 no encontrado: solo verificación de la HIGS")
endif()
