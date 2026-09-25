# Mapa de LVOs de SOS 2.6 (Library Vector Offsets)

Extraído de `sos.includes` (SOS 2.6, Dierk Ohlerich). Los bloques de código llaman a estas
funciones con `jsr -$XXX(a6)` donde **A6 = base de sos.library**. Esto permite descifrar las
llamadas de los desensamblados.

## Funciones principales (OFFSET en decimal → hex)

| LVO dec | hex | Función | Uso típico |
|---|---|---|---|
| -12 | -0C | LIB_First | primera entrada libre |
| -30 | -1E | **_StartIt** | arrancar el sistema |
| -36 | -24 | _BailOut | salir |
| -42 | -2A | **_AllocMem** | reservar memoria |
| -48 | -30 | _AllocBlock | reservar bloque |
| -54 | -36 | _FreeAll | liberar todo |
| -60 | -3C | _MemType | tipo de memoria |
| -66 | -42 | **_Load** | cargar archivo |
| -72 | -48 | **_LoadSeg** | cargar segmento |
| -78 | -4E | _FileLength | tamaño de archivo |
| -84 | -54 | **_SetInt** | fijar IRQ + copperlist |
| -90 | -5A | _ClrInt | limpiar IRQ |
| -96 | -60 | _SetDefault | push estado memoria/IRQ/copper |
| -102 | -66 | _ClrDefault | pop estado |
| -108 | -6C | _Error | error |
| -114 | -72 | **_SetCopperAdr** | fijar punteros en copperlist |
| -120 | -78 | _Randomize | |
| -126 | -7E | _FirstRand | |
| -132 | -84 | _FastRand | |
| -138 | -8A | **_LastRand** | ← **OJO: no confundir** |
| -144 | -90 | _DoubleBuffer | |
| -150 | -96 | _PPDecrunch | |
| -156 | -9C | **_SetCopperCol** | fijar colores en copperlist |
| -162 | -A2 | **_Fade** | fade de paleta |
| -168 | -A8 | _CloseScreen | |
| -174 | -AE | **_OpenScreen** | abrir pantalla |
| -180 | -B4 | **_PutScreen** | mostrar pantalla |
| -186 | -BA | _CheckRelease | |
| -192 | -C0 | _GetKey | |
| -198 | -C6 | **_Open** | abrir archivo |
| -204 | -CC | _Read | leer |
| -210 | -D2 | _Close | |
| -216 | -D8 | _Seek | |
| -222 | -DE | _GetFilePos | |
| -228 | -E4 | **_Save** | |
| -240 | -F0 | _WaitTimer | |
| -246 | -F6 | _CauseTimer | |
| -252 | -FC | _PrefetchDisk | |
| -258 | -102 | _InitDiskPrefetch | |
| -264 | -108 | **_LoadDecrunch** | cargar y descomprimir |
| -270 | -10E | _LoadSegMem | |
| -276 | -114 | _RemoveRamDisk | |
| -282 | -11A | **_GetPISS** | obtener PISS (info del sistema) |
| -288 | -120 | _UnfinishedIrq | |
| -294 | -126 | _ReLoad | |
| -300 | -12C | _FreeMem | |
| -306 | -132 | _SetIntFast | |
| -312 | -138 | **_OpenLibrary** | ← cargar librería por nombre (4 letras) |
| -318 | -13E | _ScanTagList | |
| -324 | -144 | _CheckForFile | |
| -330 | -14A | _ModDefault | |
| -336 | -150 | _SetIntDev | |
| -342 | -156 | _InitAltMemory | |
| -348 | -15C | _AltMemory | |
| -354 | -162 | _ResetRand | |
| -360 | -168 | _AltKick | |

## Librerías externas

- **SINE.soslibrary**: `_GenSinusTags equ -12` (genera tabla de seno; tags ST_ADRESS, ST_FORMAT,
  ST_RANGEPOT, ST_SIZEPOT, ST_QUARTERS).
- **DBUG.soslibrary**: `_SetPSS -30`, `_StripColor0 -24`, `_LoadDebugger -18`, `_CheckDBUG -12`.
- **TEXT.soslibrary**: `_PrintF -18`, `_SetOutput -12`.

## Correcciones a interpretaciones previas

- `jsr -$138(a6)` con `move.l #"DBUG"`/`"SINE"` = **OpenLibrary** (carga la librería por nombre).
  NO era "resolución de módulos por tag" (aunque funcionalmente equivale a cargar un módulo).
- `-$11A(a6)` = **GetPISS** (no una "primitiva interna").
- `-$54(a6)` = **SetInt** (no FindTask).
- `-$72(a6)` = **SetCopperAdr**; `-$9C(a6)` = **SetCopperCol**.
- `-$2A(a6)` = **AllocMem** (correcto); `-$228(a6)` = **Save** (no MakeLibrary).
- `-$180(a6)` = **PutScreen**; `-$174(a6)` = **OpenScreen**; `-$1E(a6)` = **StartIt**.
- `-$c(a6)`/`-$c(a4)` en contexto de DBUG = **CheckDBUG**.