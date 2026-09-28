# Transpilador NES -> C++23 (herramienta host).
#
# Depende de `eng/core` del repo hermano Amiga-Cpp (ruta relativa por defecto;
# se puede sobrescribir con `make AMIGA_CPP=/ruta/Amiga-Cpp`).
#
# Compilador recomendado: g++ (MinGW 16 o WSL/Linux g++ 13+).

CXX ?= g++
AMIGA_CPP ?= ../../../../../../Amiga-Cpp
ENG_INC ?= $(AMIGA_CPP)/engine/include
# El runtime (nes_runtime.hpp) no lo necesita la herramienta, pero sí el C++
# generado que compilan los tests; `tests/run.sh` lo resuelve por su cuenta.
RUNTIME_INC ?= ../../runtime/include
CXXFLAGS ?= -std=gnu++23 -O2 -Wall -Wextra -Werror=narrowing

SRC := src/main.cpp
BIN := build/nes_transpiler

.PHONY: all test test-all clean

all: $(BIN)

$(BIN): $(SRC) $(wildcard src/*.hpp)
	@mkdir -p build
	$(CXX) $(CXXFLAGS) -I$(ENG_INC) -Isrc $(SRC) -o $(BIN)

# Test rápido (ROMs propias mínimas).
test: $(BIN)
	bash tests/run.sh

# Batería completa (requiere `eng/core` + ROMs propias): equivalencia NROM +
# bankswitching (UxROM/MMC1/MMC3/MMC5/FME-7/VRC6) + guarda de tamaño estático.
# Es lo que debe correr un CI con engine; en el CI público no hay ROMs ni engine.
test-all: $(BIN)
	bash tests/run.sh
	bash tests/banks_test.sh
	bash tests/static_size_test.sh

clean:
	rm -rf build
