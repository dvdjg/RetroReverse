CXX ?= g++
CXXFLAGS ?= -O2 -std=c++17 -Wall -Wextra -Isrc
LDFLAGS ?= -static

.PHONY: test clean
test: src/test_zoom.cpp src/zoom.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o zoom_test src/test_zoom.cpp src/zoom.cpp
	./zoom_test

clean:
	rm -f zoom_test
