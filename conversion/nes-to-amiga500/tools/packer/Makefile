# packer — empaquetador RRPK (ZX0 + store)
#
# Compila el packer (C++23) y enlaza el compresor ZX0 vendorizado (C).
# Solo host: no usa eng/core ni STL prohibida.
CXX      ?= g++
CC       ?= gcc
CXXFLAGS ?= -std=c++23 -O2 -Wall -Wextra
CFLAGS   ?= -O2 -w

VENDOR := vendor/zx0
BUILD  := build
OBJ    := $(BUILD)/main.o $(BUILD)/codecs.o \
          $(BUILD)/zx0_compress.o $(BUILD)/zx0_optimize.o $(BUILD)/zx0_memory.o

.PHONY: all test clean

all: $(BUILD)/packer

$(BUILD):
	mkdir -p $(BUILD)

$(BUILD)/main.o: src/main.cpp src/rrpk_format.hpp src/filters.hpp src/codecs.hpp | $(BUILD)
	$(CXX) $(CXXFLAGS) -Isrc -I$(VENDOR) -c $< -o $@

$(BUILD)/codecs.o: src/codecs.cpp src/codecs.hpp src/rrpk_format.hpp | $(BUILD)
	$(CXX) $(CXXFLAGS) -Isrc -I$(VENDOR) -c $< -o $@

$(BUILD)/zx0_compress.o: $(VENDOR)/compress.c $(VENDOR)/zx0.h | $(BUILD)
	$(CC) $(CFLAGS) -I$(VENDOR) -c $< -o $@

$(BUILD)/zx0_optimize.o: $(VENDOR)/optimize.c $(VENDOR)/zx0.h | $(BUILD)
	$(CC) $(CFLAGS) -I$(VENDOR) -c $< -o $@

$(BUILD)/zx0_memory.o: $(VENDOR)/memory.c $(VENDOR)/zx0.h | $(BUILD)
	$(CC) $(CFLAGS) -I$(VENDOR) -c $< -o $@

$(BUILD)/packer: $(OBJ)
	$(CXX) $(CXXFLAGS) $(OBJ) -o $@

test: all
	bash tests/run.sh

clean:
	rm -rf $(BUILD)
