#!/bin/sh

set -eu

version_file="hcw-format-version.txt"
extension_id="FH-Campus-Wien/hcw"
extension_source="FH-Campus-Wien/hcw-quarto-format"
extension_dir="_extensions/FH-Campus-Wien/hcw"

if [ ! -f "$version_file" ]; then
  echo "Fehler: $version_file fehlt." >&2
  exit 1
fi

format_tag=$(tr -d '[:space:]' < "$version_file")

if ! printf '%s\n' "$format_tag" |
  grep -Eq '^v[0-9]+\.[0-9]+\.[0-9]+([+-][0-9A-Za-z.-]+)?$'; then
  echo "Fehler: $version_file muss einen Release-Tag wie v0.2.0 enthalten." >&2
  exit 1
fi

if [ -d "_extensions/hcw" ]; then
  echo "Fehler: Alte Erweiterung unter _extensions/hcw gefunden." >&2
  echo "Vor dem Update muss das Template auf den HCW-Namespace migriert werden." >&2
  exit 1
fi

echo "Installiere $extension_source@$format_tag ..."
quarto add "$extension_source@$format_tag" --no-prompt

manifest="$extension_dir/_extension.yml"
for required_file in \
  "$manifest" \
  "$extension_dir/header.tex" \
  "$extension_dir/title.tex" \
  "$extension_dir/assets/images/hcw-logo-anthrazit.png"
do
  if [ ! -s "$required_file" ]; then
    echo "Fehler: Erwartete Formatdatei fehlt: $required_file" >&2
    exit 1
  fi
done

installed_version=$(awk '$1 == "version:" { print $2; exit }' "$manifest")
expected_version=${format_tag#v}

if [ "$installed_version" != "$expected_version" ]; then
  echo "Fehler: Installiert ist $installed_version, erwartet wurde $expected_version." >&2
  exit 1
fi

echo "HCW-Format $installed_version wurde vollständig übernommen."
quarto list extensions
