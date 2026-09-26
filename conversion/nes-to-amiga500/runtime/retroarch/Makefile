# Makefile del core libretro (RetroArch) del nodo NES.
#
# Compila `nes_libretro.so` (Linux/WSL) usando `libretro.h` de
# external/libretro-common/include y el runtime del nodo (include/ + fallback/).
#
# Uso:  make            (WSL/Linux)
#       make TARGET=...  (Windows/MinGW: TARGET=nes_libretro.dll)
#
# Windows portátil: el Makefile de libretro-common es más completo, pero para un
# core de un solo .cpp basta este.

CXX ?= g++
REPO := ../../../..
AMIGA_CPP ?= ../../../../../../Amiga-Cpp
LIBRETRO_INC := $(REPO)/external/libretro-common/include
ENG_INC := $(AMIGA_CPP)/engine/include

INC := -I$(LIBRETRO_INC) -I$(ENG_INC) -I../include -I../fallback -I../platform -I../host \
       -I../../tools/transpiler/src
CXXFLAGS ?= -std=gnu++23 -O2 -fPIC -Wall -Wextra

TARGET ?= build/nes_libretro.so
SRC := libretro_core.cpp
HDR := $(wildcard *.hpp) $(wildcard ../include/*.hpp) $(wildcard ../fallback/*.hpp) \
       $(wildcard ../host/*.hpp) $(wildcard ../enhance/*.hpp) $(wildcard ../platform/*.hpp) \
       $(wildcard ../../tools/transpiler/src/*.hpp)

.PHONY: all clean codegen
all: $(TARGET)

# Core "codegen" para una ROM concreta: make codegen ROM=../../roms/nes/juego.nes
codegen:
	bash build-codegen-core.sh "$(ROM)"

$(TARGET): $(SRC) $(HDR)
	@mkdir -p build
	$(CXX) $(CXXFLAGS) $(INC) -shared $(SRC) -o $(TARGET)

clean:
	rm -rf build
