CXX ?= g++
CXXFLAGS ?= -O2 -std=c++23 -Wall -Wextra -Iinclude

NESTEST ?= ../../../../external/references/repos/nes-test-roms/other/nestest.nes
NESTESTLOG ?= ../../../../external/references/repos/nes-test-roms/other/nestest.log

SRC = src/cpu6502.cpp src/bus.cpp src/cartridge.cpp test/nestest_runner.cpp

.PHONY: test trace clean

nestest_runner: $(SRC) include/cpu6502.hpp include/bus.hpp include/cartridge.hpp
	$(CXX) $(CXXFLAGS) -o $@ $(SRC)

# Criterio H1+H2: $02==0 (oficiales) y $03==0 (ilegales).
test: nestest_runner
	./nestest_runner "$(NESTEST)"

# Comparación traza a traza con nestest.log (PC/A/X/Y/P/SP).
trace: nestest_runner
	./nestest_runner "$(NESTEST)" --trace 20000 > build_trace.txt
	python3 test/compare_nestest_log.py build_trace.txt "$(NESTESTLOG)"

clean:
	rm -f nestest_runner build_trace.txt
