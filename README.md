# Thesis-Template für Bachelor- und Masterarbeiten

In Markdown schreiben, mit Docker als PDF bauen. Quarto und LaTeX müssen nicht
lokal installiert werden.

## Quick Start

Voraussetzungen: Git, VS Code und gestartetes Docker Desktop (Windows/macOS)
beziehungsweise Docker Engine (Linux). Unter Windows Linux-Container verwenden.

1. Auf [GitHub](https://github.com/FH-Campus-Wien/hcw-template-thesis)
   **Use this template → Create a new repository** wählen.

2. Das eigene Repository klonen:

   ```shell
   git clone https://github.com/DEIN-ACCOUNT/DEINE-ARBEIT.git
   cd DEINE-ARBEIT
   ```

3. Diesen Ordner in VS Code über **Datei → Ordner öffnen** öffnen und die
   [empfohlenen Erweiterungen](internal/docs/installation.md#empfohlene-erweiterungen) installieren.

4. In `setup.tex` Sprache, Abschlussart und Textausrichtung wählen, zum Beispiel:

   ```latex
   \newcommand{\HCWLanguage}{de}             % de oder en
   \newcommand{\HCWThesisLevel}{ba}          % ba oder ma
   \newcommand{\HCWTextAlignment}{flattersatz} % Voreinstellung; alternativ blocksatz
   ```

   Titel, Name, Studiengang und Betreuung in `_quarto.yml` eintragen.

5. In `content/chapters/de/` oder `content/chapters/en/` schreiben.
   Vorspann und Nachspann liegen ebenfalls unter `content/`;
   Literatur in `content/references.bib`, Bilder unter `content/images/`.

6. Im VS-Code-Menü **Terminal → Aufgabe ausführen → Thesis: PDF erstellen** wählen.
   Ergebnis: `build/abschlussarbeit.pdf`.

Vorschau: Task `Thesis: Vorschau starten` ausführen und
[localhost:4242/abschlussarbeit.pdf](http://localhost:4242/abschlussarbeit.pdf) öffnen.
Beenden mit `Thesis: Vorschau stoppen`. Nach Änderungen an `setup.tex` die Vorschau neu starten.

Beim ersten Start lädt Docker das Builder-Image. Danach funktionieren Build und
Vorschau auch offline. Ein separater Task zum Erstellen der Umgebung ist nicht nötig.

## Inhaltsverzeichnis

- [Installation und Einrichtung](internal/docs/installation.md) – Voraussetzungen, eigenes Repository, VS-Code-Erweiterungen
- [Build und Vorschau](internal/docs/build-und-vorschau.md) – Tasks, Terminalbefehle für Windows/macOS/Linux, Vorschau stoppen
- [Projekt und Konfiguration](internal/docs/projekt-und-konfiguration.md) – Ordner, BA/MA, Deutsch/Englisch, Textausrichtung, Vor- und Nachspann
- [Markdown und LaTeX](internal/docs/markdown-und-latex.md) – Formeln, Tabellen, Bilder, Querverweise, Code und LaTeX-Sonderfälle
- [Literatur und BibTeX](internal/docs/literatur.md) – Quellen, Zitate, Zotero und Literaturverzeichnis
- [Offline und Fehlerbehebung](internal/docs/offline-und-fehlerbehebung.md) – Image-Transfer und häufige Probleme
- [Toolchain und Wartung (Advanced)](internal/docs/toolchain-und-wartung.md) – Quarto, Pandoc, LaTeX, gemeinsames Format und Updates
- [Roadmap](internal/docs/ROADMAP.md) – nächste Schritte bis Version 1.0.0

Mit Unterstützung von ChatGPT SOL 5.6 und ChatGPT SOL 6.1 erstellt und weiterentwickelt.
