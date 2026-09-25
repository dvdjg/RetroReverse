CXX ?= g++
CXXFLAGS ?= -O2 -std=c++23 -Wall -Wextra -Iinclude
LDFLAGS ?= -static

.PHONY: test check clean

# Construye y valida la HIGS + assets (node_dir = ..).
test: check
check: build/arte_check
	./build/arte_check ..

build/arte_check: src/spec.cpp src/game.cpp src/main.cpp
	mkdir -p build
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o build/arte_check src/spec.cpp src/game.cpp src/main.cpp

clean:
	rm -rf build
