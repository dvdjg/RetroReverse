// Ghidra headless script: print load/analysis evidence for an imported program.
// Usage: InfoDump.java <outFile>
// @category Amiga

import java.io.PrintWriter;

import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.listing.Function;
import ghidra.program.model.mem.MemoryBlock;
import ghidra.program.model.symbol.Symbol;
import ghidra.program.model.symbol.SymbolIterator;

public class InfoDump extends GhidraScript {
	@Override
	public void run() throws Exception {
		String[] args = getScriptArgs();
		String outFile = (args.length > 0) ? args[0] : "info.txt";
		StringBuilder sb = new StringBuilder();

		sb.append("program=").append(currentProgram.getName()).append("\n");
		sb.append("language=").append(currentProgram.getLanguageID()).append("\n");
		sb.append("compiler=").append(currentProgram.getCompilerSpec().getCompilerSpecID()).append("\n");
		sb.append("imageBase=").append(currentProgram.getImageBase()).append("\n\n");

		sb.append("== memory blocks ==\n");
		for (MemoryBlock b : currentProgram.getMemory().getBlocks()) {
			sb.append(String.format("  %-10s %s +0x%x  r=%b w=%b x=%b  init=%b%n",
					b.getName(), b.getStart(), b.getSize(), b.isRead(), b.isWrite(),
					b.isExecute(), b.isInitialized()));
		}

		sb.append("\n== entry points ==\n");
		for (Address a : currentProgram.getSymbolTable().getExternalEntryPointIterator()) {
			sb.append("  ").append(a).append("\n");
		}
		for (Function f : currentProgram.getFunctionManager().getExternalFunctions()) {
			sb.append("  ext ").append(f.getName()).append("\n");
		}

		int nFunc = currentProgram.getFunctionManager().getFunctionCount();
		int nSym = currentProgram.getSymbolTable().getNumSymbols();
		sb.append("\nfunctions=").append(nFunc).append(" symbols=").append(nSym).append("\n");

		sb.append("\n== sample symbols (library / NDK) ==\n");
		int shown = 0;
		SymbolIterator it = currentProgram.getSymbolTable().getAllSymbols(true);
		while (it.hasNext() && shown < 40) {
			Symbol s = it.next();
			String nm = s.getName();
			if (nm.startsWith("Custom") || nm.startsWith("ExceptionVectors")
					|| nm.contains("_lib") || nm.contains("Library")
					|| nm.equals("pc") || nm.startsWith("start")) {
				sb.append("  ").append(s.getAddress()).append("  ").append(nm)
						.append("  [").append(s.getSymbolType()).append("]\n");
				shown++;
			}
		}
		if (shown == 0) {
			sb.append("  (none matched)\n");
		}

		try (PrintWriter pw = new PrintWriter(outFile)) {
			pw.print(sb.toString());
		}
		println("Wrote " + outFile);
	}
}
