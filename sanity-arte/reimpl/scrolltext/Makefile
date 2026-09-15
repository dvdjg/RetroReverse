CXX ?= g++
CXXFLAGS ?= -O2 -std=c++17 -Wall -Wextra -Isrc
LDFLAGS ?= -static

.PHONY: test clean
test: src/test_scrolltext.cpp src/scrolltext.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o scroll_test src/test_scrolltext.cpp src/scrolltext.cpp
	./scroll_test

clean:
	rm -f scroll_test