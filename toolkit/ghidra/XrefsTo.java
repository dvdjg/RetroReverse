// Ghidra headless script: list references to an address and (optionally) dump the data there.
//
// Uso (como -postScript):
//   XrefsTo.java <outTxt> <hexAddr> [hexLen]
//     - outTxt : fichero de texto con las referencias
//     - hexAddr: direccion objetivo (p.ej. una tabla/paleta referenciada por el codigo)
//     - hexLen : si se indica, vuelca <hexLen> bytes desde hexAddr a <outTxt>.bin
//                (para alimentar los decoders: planar_decode, copper_decode, bin_scan...)
//
// @category Amiga

import java.io.FileOutputStream;
import java.io.PrintWriter;

import ghidra.app.script.GhidraScript;
import ghidra.program.model.address.Address;
import ghidra.program.model.mem.Memory;
import ghidra.program.model.symbol.Reference;
import ghidra.program.model.symbol.ReferenceIterator;
import ghidra.program.model.symbol.ReferenceManager;

public class XrefsTo extends GhidraScript {
	@Override
	public void run() throws Exception {
		String[] args = getScriptArgs();
		String outTxt = args[0];
		long target = Long.parseLong(args[1].replaceFirst("^0[xX]", ""), 16);
		long len = (args.length > 2) ? Long.parseLong(args[2].replaceFirst("^0[xX]", ""), 16) : 0;

		Address t = toAddr(target);
		ReferenceManager rm = currentProgram.getReferenceManager();
		StringBuilder sb = new StringBuilder();
		sb.append("program=").append(currentProgram.getName()).append("\n");
		sb.append(String.format("target=0x%x%n", target));

		sb.append("\n== references to target ==\n");
		int n = 0;
		ReferenceIterator it = rm.getReferencesTo(t);
		while (it.hasNext()) {
			Reference r = it.next();
			sb.append(String.format("  from %s  [%s]%n", r.getFromAddress(), r.getReferenceType()));
			n++;
		}
		sb.append("total refs=").append(n).append("\n");

		if (len > 0) {
			Memory mem = currentProgram.getMemory();
			byte[] buf = new byte[(int) len];
			int read = mem.getBytes(t, buf, 0, (int) len);
			try (FileOutputStream fos = new FileOutputStream(outTxt + ".bin")) {
				fos.write(buf, 0, read);
			}
			sb.append(String.format("%ndumped 0x%x bytes at 0x%x to %s.bin%n", read, target, outTxt));
		}

		try (PrintWriter pw = new PrintWriter(outTxt)) {
			pw.print(sb.toString());
		}
		println(sb.toString());
	}
}
