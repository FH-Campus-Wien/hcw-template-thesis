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
| `internal/scripts/thesis-setup.lua` | Prüft Sprache und Abschlussart und vergleicht sie mit dem aktiven Quarto-Profil. | Ja, automatisch beim Build. |
| `internal/scripts/update-hcw-format.sh` | Übernimmt gezielt die festgelegte Version des gemeinsamen HCW-Formats. | Nein, nur für Wartung. |
| `internal/scripts/import-v1-images.py` | Extrahiert die bereits übernommenen Bildbeispiele aus den Word-Vorlagen. | Nein, optionales Maintainer-Werkzeug. |
| `internal/latex/` | Thesis-spezifische Titelseite, Präambel und Hintergrundbild. | Ja, automatisch beim Build. |
| `internal/requirements/` | Offizielle Word-Referenzvorlagen für BA/MA in Deutsch und Englisch. | Nein, dienen als Referenz. |
| `internal/docs/ROADMAP.md` | Entwicklungsschritte bis zu einer stabilen Veröffentlichung. | Nein. |
| `internal/hcw-format-version.txt` | Festgelegter Release-Tag für ein bewusstes Format-Update. | Nur beim Format-Update. |

Der Quick Start und das Inhaltsverzeichnis stehen in der
[Projekt-README](../README.md). Die ausführlichen Anleitungen zum Schreiben,
Bauen und Aktualisieren sind dort verlinkt und liegen unter `internal/docs/`.
Das gemeinsame Format selbst bleibt unter
`_extensions/FH-Campus-Wien/hcw/`, wo Quarto es findet. Editor-Tasks und
Git-Konfiguration bleiben ebenfalls an ihren üblichen Stellen im Projektstamm.

## Hinweis zur Erstellung

Diese Dokumentvorlage wurde ursprünglich mit Unterstützung von ChatGPT SOL 5.6
erstellt und gemeinsam mit den Projektverantwortlichen weiterentwickelt.
