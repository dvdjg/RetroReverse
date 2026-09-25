CXX ?= g++
CXXFLAGS ?= -O2 -std=c++17 -Wall -Wextra -Isrc
LDFLAGS ?= -static

.PHONY: test clean
test: src/test_sphere.cpp src/sphere.cpp src/motion.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o sphere_test src/test_sphere.cpp src/sphere.cpp src/motion.cpp
	./sphere_test data

clean:
	rm -f sphere_test sphere_frame_*.raw
	rm -rf anim