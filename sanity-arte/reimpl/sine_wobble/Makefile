CXX ?= g++
CXXFLAGS ?= -O2 -std=c++17 -Wall -Wextra -Isrc
LDFLAGS ?= -static

.PHONY: test clean
test: src/test_sine_wobble.cpp src/sine_wobble.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o wobble_test src/test_sine_wobble.cpp src/sine_wobble.cpp
	./wobble_test

clean:
	rm -f wobble_test