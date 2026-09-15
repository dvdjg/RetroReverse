CXX ?= g++
CXXFLAGS ?= -O2 -std=c++17 -Wall -Wextra -Isrc
LDFLAGS ?= -static

.PHONY: test clean
test: src/test_blob_render.cpp src/blob_render.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o blob_test src/test_blob_render.cpp src/blob_render.cpp
	./blob_test

clean:
	rm -f blob_test