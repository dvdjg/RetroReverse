// Ghidra headless script: search all memory blocks for a byte signature.
// Usage: FindSig.java <outFile> <hexbytes e.g. 4EF9000000104EF90000009A736F7300>
// @category Amiga

import java.io.PrintWriter;

import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.mem.Memory;
import ghidra.program.model.mem.MemoryBlock;

public class FindSig extends GhidraScript {
	@Override
	public void run() throws Exception {
		String[] args = getScriptArgs();
		String outFile = args[0];
		String hex = args[1].replaceAll("[^0-9a-fA-F]", "");
		byte[] sig = new byte[hex.length() / 2];
		for (int i = 0; i < sig.length; i++) {
			sig[i] = (byte) Integer.parseInt(hex.substring(i * 2, i * 2 + 2), 16);
		}

		StringBuilder sb = new StringBuilder();
		sb.append("signature=").append(hex).append("\n");
		Memory mem = currentProgram.getMemory();
		int hits = 0;
		for (MemoryBlock b : mem.getBlocks()) {
			if (!b.isInitialized()) {
				continue;
			}
			Address a = b.getStart();
			Address end = b.getEnd();
			try {
				Address found = mem.findBytes(a, end, sig, null, true, monitor);
				while (found != null) {
					sb.append("hit ").append(found).append("  block=").append(b.getName()).append("\n");
					hits++;
					Address next = found.add(1);
					if (next.compareTo(end) > 0) {
						break;
					}
					found = mem.findBytes(next, end, sig, null, true, monitor);
				}
			} catch (Exception e) {
				sb.append("err in block ").append(b.getName()).append(": ").append(e).append("\n");
			}
		}
		sb.append("total hits=").append(hits).append("\n");
		try (PrintWriter pw = new PrintWriter(outFile)) {
			pw.print(sb.toString());
		}
		println(sb.toString());
	}
}
