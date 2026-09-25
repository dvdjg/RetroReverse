CXX ?= g++
CXXFLAGS ?= -O2 -std=c++23 -Wall -Wextra -Iinclude

# Linux/g++ (WSL): .so + -ldl. Windows/MinGW: LIBEXT=dll y quitar LDLIBS.
LIBEXT ?= so
LDLIBS ?= -ldl

.PHONY: test clean

test: host_test test_core.$(LIBEXT)
	./host_test ./test_core.$(LIBEXT) dummy.bin

host_test: src/libretro_adapter.cpp test/host_test.cpp include/libretro_adapter.hpp include/emulator_control.hpp include/libretro_api.hpp
	$(CXX) $(CXXFLAGS) -o host_test src/libretro_adapter.cpp test/host_test.cpp $(LDLIBS)

# Vertical slice P0.3: core real -> trazas/savestates/capturas en extraction/.
vertical_slice: src/libretro_adapter.cpp test/vertical_slice.cpp include/libretro_adapter.hpp include/emulator_control.hpp include/libretro_api.hpp
	$(CXX) $(CXXFLAGS) -o vertical_slice src/libretro_adapter.cpp test/vertical_slice.cpp $(LDLIBS)

test_core.$(LIBEXT): test/test_core.cpp include/libretro_api.hpp
	$(CXX) $(CXXFLAGS) -shared -fPIC -o test_core.$(LIBEXT) test/test_core.cpp

clean:
	rm -f host_test vertical_slice test_core.so test_core.dll host_test.ppm
