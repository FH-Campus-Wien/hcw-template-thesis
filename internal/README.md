# Interne Dateien des Thesis-Templates

Dieser Ordner trennt die technische Umsetzung von den eigenen Inhalten unter
`content/`. Studierende müssen hier für eine normale Arbeit nichts ändern.
Die Build-Skripte und LaTeX-Dateien werden jedoch weiterhin benötigt; der
Ordner darf deshalb nicht als vermeintlicher Cache gelöscht werden.

Alle unten genannten Projektpfade beziehen sich auf den Repository-Stamm.
Auch die Docker-Tasks führen ihre Befehle dort aus.

| Pfad | Aufgabe | Beim normalen Schreiben benötigt? |
|---|---|---|
| `internal/scripts/thesis.sh` | Liest die Sprache aus `setup.tex` und startet PDF-Build oder Vorschau. | Ja, automatisch durch die Tasks. |
| `internal/scripts/thesis-setup.lua` | Prüft Sprache und Abschlussart, wählt BA/MA-Textvarianten und übernimmt Kurzbeschriftungen in die Verzeichnisse. | Ja, automatisch beim Build. |
| `internal/latex/` | Thesis-spezifische Titelseite, Präambel und Hintergrundbild. | Ja, automatisch beim Build. |
| `internal/csl/ieee.csl` | Lokal mitgelieferter IEEE-Stil für numerische BibTeX-Zitate; eigene Lizenz im Dateikopf. | Ja, automatisch beim Build. |
| `internal/docs/ROADMAP.md` | Entwicklungsschritte bis zu einer stabilen Veröffentlichung. | Nein. |
| `internal/hcw-format-version.txt` | Festgelegter Release-Tag für ein bewusstes Format-Update. | Nur beim Format-Update. |

Der Quick Start und das Inhaltsverzeichnis stehen in der
[Projekt-README](../README.md). Die ausführlichen Anleitungen zum Schreiben,
Bauen und Aktualisieren sind dort verlinkt und liegen unter `internal/docs/`.
Das gemeinsame Format selbst bleibt unter
`_extensions/FH-Campus-Wien/hcw/`, wo Quarto es findet. Editor-Tasks und
Git-Konfiguration bleiben ebenfalls an ihren üblichen Stellen im Projektstamm.

## Nur lokal vorhandene Maintainer-Dateien

Die Word-Referenzen unter `internal/requirements/` sowie die optionalen Skripte
`internal/scripts/import-v1-images.py` und
`internal/scripts/update-hcw-format.sh` werden nicht mehr mit dem Repository
ausgeliefert. Auf dem Maintainer-Rechner bleiben sie lokal erhalten und sind
über `.gitignore` ausgeschlossen. Ein neuer Klon enthält diese Dateien nicht.

PDF-Build und Vorschau benötigen sie nicht. Die notwendigen Skripte
`thesis.sh` und `thesis-setup.lua` bleiben versioniert. Auch Roadmap,
Dokumentation, Format-Versionsdatei, CSL-Stil und LaTeX-Konfiguration bleiben
im Repository. Die manuelle Format-Aktualisierung ist unter
[Toolchain und Wartung](docs/toolchain-und-wartung.md#hcw-format-im-template-aktualisieren)
beschrieben; ein Maintainer-Task wird nicht mehr mitgeliefert.

## Hinweis zur Erstellung

Diese Dokumentvorlage wurde ursprünglich mit Unterstützung von ChatGPT SOL 5.6
erstellt und gemeinsam mit den Projektverantwortlichen weiterentwickelt.
