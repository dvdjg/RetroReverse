# CMake del runner SDL3 (PC y navegador).
#
# PC (Windows/Linux/macOS):  cmake -S . -B build && cmake --build build
#   Requiere SDL3 (find_package(SDL3)); en Windows/Linux puedes apuntar
#   `-DCMAKE_PREFIX_PATH=.../SDL3` o usar el script build-pc.ps1 (MinGW).
#
# Navegador (Emscripten):    emcmake cmake -S . -B build-web && cmake --build build-web
#   Genera build-web/nes_sdl.html. Requiere emsdk activado (ver ../platform/README.md).
cmake_minimum_required(VERSION 3.16)
project(nes_to_amiga_host CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Ruta a Amiga-Cpp (para `eng/core`). Se puede sobrescribir con -DAMIGA_CPP=...
set(AMIGA_CPP "" CACHE PATH "Ruta al repo Amiga-Cpp (eng/core)")
if(NOT AMIGA_CPP)
  get_filename_component(AMIGA_CPP "${CMAKE_CURRENT_SOURCE_DIR}/../../../../../../Amiga-Cpp" ABSOLUTE)
endif()

add_executable(nes_sdl main.cpp sdl_host.cpp)
target_include_directories(nes_sdl PRIVATE
  "${CMAKE_CURRENT_SOURCE_DIR}/../include"
  "${CMAKE_CURRENT_SOURCE_DIR}/../fallback"
  "${CMAKE_CURRENT_SOURCE_DIR}/../platform"
  "${AMIGA_CPP}/engine/include")

if(EMSCRIPTEN)
  target_link_options(nes_sdl PRIVATE
    -sUSE_SDL=3 -sALLOW_MEMORY_GROWTH=1 -sASYNCIFY
    "--shell-file=${CMAKE_CURRENT_SOURCE_DIR}/../web/shell.html")
  set_target_properties(nes_sdl PROPERTIES SUFFIX ".html")
else()
  find_package(SDL3 REQUIRED CONFIG)
  target_link_libraries(nes_sdl PRIVATE SDL3::SDL3)
endif()
