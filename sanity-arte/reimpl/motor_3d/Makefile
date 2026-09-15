CXX ?= g++
CXXFLAGS ?= -O2 -std=c++17 -Wall -Wextra -Isrc

.PHONY: test clean
test: src/test_transform3d.cpp src/transform3d.cpp
	$(CXX) $(CXXFLAGS) -o motor3d_test src/test_transform3d.cpp src/transform3d.cpp
	./motor3d_test

clean:
	rm -f motor3d_test