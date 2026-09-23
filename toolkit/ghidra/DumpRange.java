// Ghidra headless script: write a memory range to a file.
// Usage: DumpRange.java <outFile> <hexStart> <hexLength>
// @category Amiga

import java.io.FileOutputStream;
import java.io.PrintWriter;

import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.mem.Memory;

public class DumpRange extends GhidraScript {
	@Override
	public void run() throws Exception {
		String[] args = getScriptArgs();
		String outFile = args[0];
		long start = Long.parseLong(args[1], 16);
		long len = Long.parseLong(args[2], 16);

		Memory mem = currentProgram.getMemory();
		Address a = toAddr(start);
		byte[] buf = new byte[(int) len];
		int read = mem.getBytes(a, buf, 0, (int) len);
		try (FileOutputStream fos = new FileOutputStream(outFile)) {
			fos.write(buf, 0, read);
		}
		try (PrintWriter pw = new PrintWriter(outFile + ".txt")) {
			pw.printf("start=0x%x len=0x%x read=0x%x%n", start, len, read);
		}
		println("Wrote " + outFile + " (" + read + " bytes)");
	}
}
