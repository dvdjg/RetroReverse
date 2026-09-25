CXX ?= g++
CXXFLAGS ?= -O2 -std=c++17 -Wall -Wextra -Isrc
LDFLAGS ?= -static

.PHONY: test clean
test: src/test_palette_fade.cpp src/palette_fade.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o fade_test src/test_palette_fade.cpp src/palette_fade.cpp
	./fade_test

clean:
	rm -f fade_test