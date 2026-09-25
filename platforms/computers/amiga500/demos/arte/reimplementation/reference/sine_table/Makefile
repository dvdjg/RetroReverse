CXX ?= g++
CXXFLAGS ?= -O2 -std=c++17 -Wall -Wextra -Isrc

.PHONY: test regen clean
test: src/test_sine.cpp src/sine_table_data.hpp
	$(CXX) $(CXXFLAGS) -o sine_test src/test_sine.cpp
	./sine_test

regen: src/gen_sine.cpp
	$(CXX) $(CXXFLAGS) -o gen_sine src/gen_sine.cpp
	./gen_sine src/sine_table_data.hpp
	rm -f gen_sine

clean:
	rm -f sine_test gen_sine
