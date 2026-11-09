#!/usr/bin/env python3
"""Maintainer utility: extract identical V1 assets and convert EMF to vector PDF.

Requires Pillow, pypdf, LibreOffice and pdftoppm only on the maintainer machine.
Normal thesis builds use the committed assets and need none of these tools.
"""

import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import tempfile
from zipfile import ZipFile

from PIL import Image, ImageChops
from pypdf import PdfReader, PdfWriter
from pypdf.generic import RectangleObject

ASSETS = {
    "image3.png": "magnetron-sputtern.png",
    "image4.png": "buecher.png",
    "image5.jpeg": "fertigungsstrasse.jpeg",
    "image6.jpeg": "3d-druck-stuetzmaterial.jpeg",
    "image7.emf": "sinussignal.pdf",
    "image8.emf": "dft-fft-aufwand.pdf",
    "image9.emf": "wahrscheinlichkeitsverteilungen.pdf",
    "image10.png": "kontrast-schlecht.png",
    "image11.png": "kontrast-gut.png",
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--soffice", default="soffice")
    parser.add_argument("--pdftoppm", default="pdftoppm")
    args = parser.parse_args()
    root = Path(__file__).resolve().parents[2]
    sources = sorted((root / "internal/requirements").glob("*V1.dotx"))
    if len(sources) != 4:
        raise RuntimeError("Expected the four BA/MA DE/EN V1 reference files")
    destination = root / "content/images/v1"
    destination.mkdir(parents=True, exist_ok=True)
    manifest = {"sources": [], "assets": []}
    with tempfile.TemporaryDirectory(prefix="hcw-v1-images-") as directory:
        scratch = Path(directory)
        archives = []
        try:
            for path in sources:
                archives.append(ZipFile(path))
                manifest["sources"].append({
                    "file": f"internal/requirements/{path.name}",
                    "sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
                })
            for source_name, output_name in ASSETS.items():
                part = f"word/media/{source_name}"
                originals = [archive.read(part) for archive in archives]
                if any(data != originals[0] for data in originals[1:]):
                    raise RuntimeError(f"Different asset across variants: {part}")
                data = originals[0]
                target = destination / output_name
                conversion = "original bytes"
                if source_name.endswith(".emf"):
                    emf = scratch / source_name
                    emf.write_bytes(data)
                    subprocess.run([
                        args.soffice, "--headless",
                        f"-env:UserInstallation={(scratch / 'lo-profile').as_uri()}",
                        "--convert-to", "pdf", "--outdir", str(scratch), str(emf),
                    ], check=True, capture_output=True)
                    pdf = emf.with_suffix(".pdf")
                    preview = scratch / (emf.stem + "-preview")
                    subprocess.run([
                        args.pdftoppm, "-singlefile", "-r", "144", "-png",
                        str(pdf), str(preview),
                    ], check=True, capture_output=True)
                    with Image.open(preview.with_suffix(".png")) as raster:
                        rgb = raster.convert("RGB")
                        difference = ImageChops.difference(rgb, Image.new("RGB", rgb.size, "white"))
                        mask = difference.convert("L").point(lambda value: 255 if value > 12 else 0)
                        left, top, right, bottom = mask.getbbox()
                        reader = PdfReader(pdf)
                        page = reader.pages[0]
                        width = float(page.mediabox.width)
                        height = float(page.mediabox.height)
                        # Preserve vector content; remove only the Draw page's white margins.
                        box = RectangleObject([
                            max(0, left / rgb.width * width - 2),
                            max(0, height - bottom / rgb.height * height - 2),
                            min(width, right / rgb.width * width + 2),
                            min(height, height - top / rgb.height * height + 2),
                        ])
                        page.mediabox = box
                        page.cropbox = box
                        writer = PdfWriter()
                        writer.add_page(page)
                        with target.open("wb") as handle:
                            writer.write(handle)
                    conversion = "EMF to vector PDF via LibreOffice; whitespace cropped"
                else:
                    target.write_bytes(data)
                manifest["assets"].append({
                    "source_part": part,
                    "source_sha256": hashlib.sha256(data).hexdigest(),
                    "file": f"content/images/v1/{output_name}",
                    "sha256": hashlib.sha256(target.read_bytes()).hexdigest(),
                    "conversion": conversion,
                })
                print(output_name)
        finally:
            for archive in archives:
                archive.close()
    (destination / "manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=2) + "\n", encoding="utf-8",
    )


if __name__ == "__main__":
    main()
