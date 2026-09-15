CXX ?= g++
CXXFLAGS ?= -O2 -std=c++17 -Wall -Wextra -Isrc
LDFLAGS ?= -static

.PHONY: test clean
test: src/test_tunnel.cpp src/tunnel.cpp
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o tunnel_test src/test_tunnel.cpp src/tunnel.cpp
	./tunnel_test data

clean:
	rm -f tunnel_test
	rm -rf anim
