#!/usr/bin/env python3
"""Compara la traza del emulador con nestest.log (PC/A/X/Y/P/SP por instrucción).

Uso: compare_nestest_log.py <trace.txt> <nestest.log>
La traza son líneas "T <PC> <A> <X> <Y> <P> <SP>" (nestest_runner --trace).
Ignora bytes/ASM/PPU/CYC del log (dependen del desensamblador/PPU).
"""
import re
import sys

flog = re.compile(r'A:([0-9A-F]{2}) X:([0-9A-F]{2}) Y:([0-9A-F]{2}) P:([0-9A-F]{2}) SP:([0-9A-F]{2})')


def parse_log(path):
    out = []
    with open(path, encoding='utf-8', errors='replace') as f:
        for line in f:
            m = flog.search(line)
            if not m:
                continue
            pc = int(line[:4], 16)
            out.append((pc, int(m.group(1), 16), int(m.group(2), 16), int(m.group(3), 16),
                        int(m.group(4), 16), int(m.group(5), 16)))
    return out


def parse_trace(path):
    out = []
    with open(path, encoding='utf-8', errors='replace') as f:
        for line in f:
            if not line.startswith('T '):
                continue
            p = line.split()
            out.append(tuple(int(x, 16) for x in p[1:7]))
    return out


def main():
    trace = parse_trace(sys.argv[1])
    log = parse_log(sys.argv[2])
    n = min(len(trace), len(log))
    for i in range(n):
        if trace[i] != log[i]:
            print(f'MISMATCH en línea {i + 1}:')
            print(f'  emu: PC={trace[i][0]:04X} A={trace[i][1]:02X} X={trace[i][2]:02X} Y={trace[i][3]:02X} P={trace[i][4]:02X} SP={trace[i][5]:02X}')
            print(f'  log: PC={log[i][0]:04X} A={log[i][1]:02X} X={log[i][2]:02X} Y={log[i][3]:02X} P={log[i][4]:02X} SP={log[i][5]:02X}')
            return 1
    print(f'OK: {n} instrucciones idénticas (emu {len(trace)} / log {len(log)})')
    return 0 if len(trace) >= len(log) else 1


if __name__ == '__main__':
    raise SystemExit(main())
