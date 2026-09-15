# reimpl/Makefile — build de todos los reimpls (host) y recopilación de asm canónicos.
#
# `make test-all` compila y ejecuta los tests host de cada técnica.
# `make asm` lista los asm canónicos (rutinas optimizadas) preservados.

CXX ?= g++
CXXFLAGS ?= -O2 -std=c++17 -Wall -Wextra
LDFLAGS ?= -static

MODULES := sine_table motor_3d blob_render sine_wobble scrolltext palette_fade sphere tunnel

.PHONY: test-all asm clean

test-all:
	@for m in $(MODULES); do \
		echo "=== $$m ==="; \
		$(MAKE) -C $$m test || exit 1; \
	done

# Lista los asm canónicos (rutinas optimizadas) preservados para la reconstrucción.
asm:
	@echo "Rutinas asm canónicas preservadas (versiones optimizadas):"
	@find . -name "*_amiga.asm" -print 2>/dev/null || \
		find . -name "*_amiga.asm"

clean:
	@for m in $(MODULES); do $(MAKE) -C $$m clean; done
