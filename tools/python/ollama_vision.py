#!/usr/bin/env python3
"""ollama_vision.py — Inspecciona imágenes con un modelo de visión local (Ollama).

Permite validar gráficos Amiga decodificados (bitplanes -> PNG) sin depender de la
capacidad visual del modelo de chat principal. Usa el modelo de visión configurado
por el usuario (por defecto qwen3-vl:8b-instruct-q8_0).

Uso:
  python ollama_vision.py <imagen.png> [--prompt "texto"] [--model <m>] [--url http://...]

Si no se indica --prompt, usa un prompt por defecto para validar gráficos Amiga
(alineación, contenido, si es imagen coherente o ruido/memoria mal alineada).
"""

import sys
import os
import json
import base64
import urllib.request
import argparse

if sys.stdout and hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
elif sys.stdout:
    sys.stdout.errors = "replace"

DEFAULT_URL = "http://localhost:11434/api/generate"
DEFAULT_MODEL = "qwen3-vl:8b-instruct-q8_0"

DEFAULT_PROMPT = (
    "Analiza esta imagen. Es un gráfico Amiga OCS decodificado desde bitplanes "
    "planares. Responde en español, muy conciso: "
    "1) ¿La imagen es coherente (algo reconocible: texto, logo, sprite) o es ruido/volcado "
    "de memoria mal alineado? "
    "2) Si es coherente, describe qué representa (color de fondo, si hay texto/logo, "
    "si hay patrones repetidos, gradientes). "
    "3) Si está mal alineada (ruido, rayas diagonales, 'memory dump'), indícalo claramente "
    "para ajustar ancho/stride/planos."
)


def ask_ollama(prompt, image_path, model, url, temperature=0.3):
    if not os.path.exists(image_path):
        raise FileNotFoundError(image_path)
    with open(image_path, "rb") as f:
        img_b64 = base64.b64encode(f.read()).decode()
    payload = {
        "model": model,
        "prompt": prompt,
        "images": [img_b64],
        "stream": False,
        "options": {"temperature": temperature},
    }
    req = urllib.request.Request(
        url,
        data=json.dumps(payload).encode(),
        headers={"Content-Type": "application/json"},
    )
    with urllib.request.urlopen(req, timeout=120) as resp:
        data = json.loads(resp.read().decode())
    return data.get("response", "").strip()


def main():
    ap = argparse.ArgumentParser(description="Inspecciona imágenes con Ollama (modelo de visión).")
    ap.add_argument("image", help="Ruta a la imagen (PNG)")
    ap.add_argument("--prompt", default=None, help="Prompt personalizado")
    ap.add_argument("--model", default=os.environ.get("OLLAMA_VISION_MODEL", DEFAULT_MODEL))
    ap.add_argument("--url", default=os.environ.get("OLLAMA_URL", DEFAULT_URL))
    args = ap.parse_args()

    prompt = args.prompt or DEFAULT_PROMPT
    print(f"modelo: {args.model}")
    print(f"imagen: {args.image}")
    print("prompt: " + prompt[:120] + ("..." if len(prompt) > 120 else ""))
    print("--- respuesta ---")
    resp = ask_ollama(prompt, args.image, args.model, args.url)
    print(resp)


if __name__ == "__main__":
    main()