# Release Notes

[← Quick Start und Inhaltsverzeichnis](../../README.md)

## v0.3.0-alpha.1 - 2026-11-09

Technischer Vorab-Release zur Integration der vier aktuellen V1-Word-Vorlagen.
Dieser Stand ist ausdrücklich noch kein Release Candidate (`v0.9.0`) und noch
keine formale Freigabe der Hochschulvorgaben.

### Neu und geändert

- Sprache (`de`/`en`), Abschlussart (`ba`/`ma`) und Textausrichtung zentral in
  `setup.tex` auswählen. Flattersatz ist jetzt die Voreinstellung.
- Deutsche und englische Kapitel sowie Vor- und Nachspann getrennt pflegen.
- Bilder, Quellen, Gleichungen und zugehörige Erklärungen aus den vier
  V1-Vorlagen übernehmen und als editierbare Quarto-Beispiele bereitstellen.
- 12 pt Fließtext, 1,25-fachen Zeilenabstand und 8 pt Absatzabstand verwenden.
  Seitenränder: oben/links/rechts 25 mm, unten im Haupttext 25 mm und im Vor-
  und Nachspann 20 mm. Die Titelseite bleibt gesondert gestaltet.
- Eigene Inhalte unter `content/`, interne Skripte und LaTeX-Dateien unter
  `internal/` zusammenfassen.
- Die Haupt-README auf einen Quick Start mit Links zu ausführlichen
  Themenseiten unter `internal/docs/` kürzen.
- Den Builder gezielt auf Version `1.4.0` aktualisieren; Schreiben und
  PDF-Erzeugung bleiben nach dem ersten Download offlinefähig.

### Toolchain-Hinweis

Quarto/Pandoc im neuen Builder können die Darstellung von Zitaten und
Literaturangaben verändern, auch bei unveränderten Markdown- und BibTeX-Dateien.
In den englischen Beispielen ergibt sich dadurch eine Seite weniger. Alle vier
Varianten wurden offline gebaut und die PDFs visuell geprüft. Vor einer Abgabe
sind Zitierstil und Seitenumbrüche dennoch gezielt zu kontrollieren; der aktuell
verwendete Standardstil ist noch keine bestätigte Hochschulvorgabe.

### Noch offen vor dem Release Candidate

- Verbindliche Pflichttexte und akademische Bezeichnungen abstimmen;
  insbesondere ist die Eigenständigkeitserklärung noch ein Platzhalter.
- Weitere Gestaltungsdetails mit den zuständigen Personen klären.
- Vollständige Bedienungstests unter Windows/macOS/Linux durchführen und
  den Quick Start durch eine neue Person ohne Einführung testen lassen.
- Änderungen an `setup.tex` erfordern weiterhin einen Neustart der laufenden
  Vorschau. Die Sprache wird beim Start der Vorschau ausgewählt.

Die vollständigen Freigabekriterien stehen in der [Roadmap](ROADMAP.md).
Bereits erstellte Arbeiten sollten die neue Verzeichnisstruktur und Toolchain
nicht ungeprüft übernehmen, sondern den Wechsel als gezieltes Update testen.
