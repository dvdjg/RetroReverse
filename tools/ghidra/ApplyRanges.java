// Puente trazas/desensamblado -> Ghidra: crea funciones en los rangos indicados.
//
// Uso (headless):
//   analyzeHeadless <proj> <name> -import <rom> -postScript ApplyRanges.java <ranges.txt>
// Formato de ranges.txt: una línea por instrucción "ADDR_HEX SIZE_HEX" (salida de
// tools/python/capstone_disasm.py -> <prefijo>.ranges.txt).
//
// Para coberturas de emulación, generar el mismo formato con los PCs ejecutados.

import java.io.BufferedReader;
import java.io.FileReader;

import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.address.AddressSpace;

public class ApplyRanges extends GhidraScript {
	@Override
	public void run() throws Exception {
		String[] args = getScriptArgs();
		if (args.length < 1) {
			println("uso: ApplyRanges <ranges.txt>");
			return;
		}
		AddressSpace space = currentProgram.getAddressFactory().getDefaultAddressSpace();
		int created = 0, existed = 0, failed = 0;
		try (BufferedReader br = new BufferedReader(new FileReader(args[0]))) {
			String line;
			while ((line = br.readLine()) != null) {
				line = line.trim();
				if (line.isEmpty() || line.startsWith("#")) continue;
				String[] p = line.split("\\s+");
				Address a = space.getAddress(Long.parseLong(p[0], 16));
				if (getFunctionAt(a) != null) { existed++; continue; }
				try {
					disassemble(a);
					createFunction(a, null);
					created++;
				} catch (Exception e) {
					failed++;
				}
			}
		}
		println("ApplyRanges: " + created + " funciones creadas, " + existed + " ya existían, " + failed + " fallos");
	}
}
