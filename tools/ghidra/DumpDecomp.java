// Ghidra headless script: decompile a function (or all) to a C file.
// Usage (as -postScript):
//   DumpDecomp.java <outFile> [hexAddr]
//   - outFile: path of the .c output
//   - hexAddr: optional absolute address; if given, only the function
//     containing that address is decompiled. Otherwise all functions.
// @category Amiga

import java.io.PrintWriter;

import ghidra.app.decompiler.DecompInterface;
import ghidra.app.decompiler.DecompileResults;
import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.listing.Function;

public class DumpDecomp extends GhidraScript {
	@Override
	public void run() throws Exception {
		String[] args = getScriptArgs();
		String outFile = (args.length > 0) ? args[0] : "decomp.c";
		Address target = (args.length > 1)
				? toAddr(Long.parseLong(args[1].replaceFirst("^0[xX]", ""), 16))
				: null;

		DecompInterface ifc = new DecompInterface();
		ifc.toggleCCode(true);
		ifc.toggleSyntaxTree(true);
		if (!ifc.openProgram(currentProgram)) {
			println("ERROR: decompiler could not open program: " + ifc.getLastMessage());
			return;
		}

		StringBuilder sb = new StringBuilder();
		sb.append("// Ghidra decompilation of ").append(currentProgram.getName()).append("\n");
		sb.append("// language=").append(currentProgram.getLanguageID())
				.append(" imageBase=").append(currentProgram.getImageBase()).append("\n\n");

		if (target != null) {
			Function f = getFunctionContaining(target);
			if (f == null) {
				println("No function contains " + target);
				return;
			}
			dump(ifc, f, sb);
		} else {
			int n = 0;
			for (Function f : currentProgram.getFunctionManager().getFunctions(true)) {
				if (monitor.isCancelled()) {
					break;
				}
				dump(ifc, f, sb);
				n++;
			}
			println("decompiled " + n + " functions");
		}

		try (PrintWriter pw = new PrintWriter(outFile)) {
			pw.print(sb.toString());
		}
		println("Wrote " + outFile);
	}

	private void dump(DecompInterface ifc, Function f, StringBuilder sb) {
		DecompileResults res = ifc.decompileFunction(f, 90, monitor);
		sb.append("// FUN ").append(f.getName()).append(" @ ").append(f.getEntryPoint());
		sb.append("  [").append(f.getBody().getNumAddresses()).append(" bytes]\n");
		if (res != null && res.decompileCompleted()) {
			sb.append(res.getDecompiledFunction().getC());
		} else {
			sb.append("// <decompile failed: ")
					.append(res == null ? "null" : res.getErrorMessage()).append(">\n");
		}
		sb.append("\n");
	}
}
