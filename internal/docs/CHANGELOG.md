# Release Notes

[← Quick Start und Inhaltsverzeichnis](../../README.md)

## v0.9.0 - 2026-11-11

Release Candidate für die abschließende Prüfung vor `v1.0.0`. Auf GitHub als
Vorabversion veröffentlicht; noch keine formale Freigabe der Hochschulvorgaben.

### Neu und geändert

- Inhalte und generische Zwei-Kapitel-Struktur der vier V1-Word-Vorlagen
  wortgetreu übernehmen, statt sie in eine eigene Beispielgliederung umzuformulieren.
- Bisherige Kapitelaufteilung als Vorschlag nach `content/chapters/README.md` verschieben.
- Zusätzliche Umsetzungserklärungen einheitlich am Ende des jeweiligen
  offiziellen Kapitels unter „Hinweise zu Latex“ zusammenfassen.
- Vollständigen Nachspann mit Literatur-, Abbildungs-, Tabellen- und
  Listingverzeichnis, KI-Übersicht und optionalem Anhang übernehmen.
- Den zusätzlichen Platzhalter der Eigenständigkeitserklärung entfernen;
  er ist kein Bestandteil der vier V1-Word-Dateien.
- Sieben Formelnummern, das Fibonacci-Listing und die Original-Fußnoten übernehmen.
- Durchgehende Abbildungs-/Tabellennummern und eine lokale IEEE-CSL-Datei
  für numerische BibTeX-Zitate verwenden. Automatische Felder und
  Literaturformatierung werden neu erzeugt und sind nicht pixelgleich mit Word.

### Geprüfter Stand

- Alle vier Varianten (BA/MA, Deutsch/Englisch) mit dem festgelegten Builder
  `1.4.0` offline gebaut und ihre PDF-Ausgaben visuell geprüft.
- Wortlaut der übernommenen Textabsätze gegen alle vier V1-Dateien abgeglichen;
  die kleine deutsche BA/MA-Textabweichung wird passend zu `setup.tex` gewählt.
- Sieben Gleichungsnummern, fünf Abbildungen, drei Tabellen, Listing 2.1,
  Kurzbeschriftungen, Fußnoten und alle vier Spalten der KI-Tabelle geprüft.
- Gemeinsames Format weiterhin auf `v0.1.1` festgelegt.

### Noch offen vor v1.0.0

- Fachliche und formale Freigabe durch die zuständigen Personen, einschließlich
  akademischer Bezeichnungen, Zitierweise und etwaiger zusätzlicher Abgabevorgaben.
- Vollständige Endanwender- und VS-Code-Bedienungstests unter Windows/macOS/Linux.
  Lokale Docker-Tests ersetzen diese Tests nicht.
- Ein neues Projekt über **Use this template** durch eine bislang unbeteiligte
  Person erstellen und anhand des Quick Starts testen lassen.
- Verbleibende Rückmeldungen zu Gestaltung und Anleitung abschließen.
- Änderungen an `setup.tex` erfordern weiterhin einen Neustart der Vorschau.

Die Veröffentlichung von `v0.9.0` beginnt die abschließende Reviewphase;
sie bestätigt nicht, dass alle Freigabekriterien bereits erfüllt sind.
Details stehen in der [Roadmap](ROADMAP.md).

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
