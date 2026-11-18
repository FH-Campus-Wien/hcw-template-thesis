# Roadmap zum stabilen Thesis-Template

[← Quick Start und Inhaltsverzeichnis](../../README.md)

Aktueller Release Candidate: `v0.9.0` (GitHub-Vorabversion).

Die Inhalte der vier V1-Word-Vorlagen sind technisch integriert. Mit `v0.9.0`
beginnt die abschließende Reviewphase vor dem stabilen Release. Laut Rückmeldung
vom 18. November 2026 hat der Vorgesetzte den Vorlagenstand freigegeben;
die macOS-Tests sind abgeschlossen. Windows- und Linux-Tests bleiben offen.
Dies dokumentiert die interne Projektfreigabe, keine darüber hinausgehende
institutionelle Zertifizierung. Weitere offene Prüfungen sind unten vermerkt.
Die Versionsnummern sind Meilensteine, keine Prozentangaben zum Fortschritt.

## Stand des Release Candidates

Bereits umgesetzt und technisch geprüft:

- Bachelor/Master und Deutsch/Englisch zentral in `setup.tex` auswählen.
- Getrennte Sprachdateien, vollständige Struktur für Vor- und Nachspann.
- Titelseite mit Logo und Linienmotiv sowie Beispiele aus den vier V1-Vorlagen.
- Originalwortlaut und generische Zwei-Kapitel-Struktur statt eigener
  Beispielgliederung; die bisherige Gliederung ist separat dokumentiert.
- Vollständiger Nachspann mit Literatur-, Abbildungs-, Tabellen- und
  Listingverzeichnis, KI-Übersicht und optionalem Anhang.
- Zusätzliche Umsetzungserklärungen einheitlich unter „Hinweise zu Latex“.
- 12 pt Fließtext, 1,25-facher Zeilenabstand, 8 pt Absatzabstand und
  abschnittsabhängige Seitenränder entsprechend den V1-Word-Dateien.
- Flattersatz als Voreinstellung; Blocksatz bleibt wählbar.
- Aufgeräumte Verzeichnisse, kurzer Quick Start und ausführliche Themenseiten.
- Alle vier BA/MA- und DE/EN-Varianten offline gebaut und die PDFs visuell geprüft.
- Builder `1.4.0`, gemeinsames Format `v0.1.1` und lokaler IEEE-Zitierstil
  ausdrücklich festgelegt.
- Interne Freigabe des Vorlagenstands und abgeschlossene macOS-Tests laut
  Rückmeldung vom 18. November 2026.

Vor `v1.0.0` bleiben die vollständigen Endanwender- und VS-Code-Bedienungstests
unter Windows und Linux sowie der Test durch eine neue Person offen.
Automatisierte Container-Tests auf AMD64 und ARM64 ersetzen diese
Betriebssystem- und Bedienungstests nicht. Etwaige abweichende Anforderungen
eines konkreten Studiengangs oder Abgabeprozesses werden weiterhin gesondert
abgeglichen.

Die Änderungen dieses Stands stehen in den [Release Notes](CHANGELOG.md).

Das Thesis-Template erreicht `v1.0.0`, sobald es für eine reale Bachelor- oder
Masterarbeit ohne grundlegende Änderungen an Aufbau, Bedienung oder
Konfiguration eingesetzt werden kann. Ab diesem Zeitpunkt gilt die vorhandene
Struktur als verlässliche Schnittstelle für Studierende und Betreuende.

## Entwicklungsweg und offene Freigaben

Die bisherigen Themenblöcke sind keine nachträgliche Bestätigung, dass jede
formale oder manuelle Prüfung abgeschlossen ist. Maßgeblich für die Freigabe
sind die Kriterien für `v1.0.0` weiter unten.

### Struktur und Gestaltung (technisch umgesetzt seit `v0.2.x`)

- Titelseite und Linienmotiv fertigstellen
- Frontmatter und Backmatter vollständig strukturieren
- Bachelor- und Masterkonfiguration getrennt prüfen
- Beispiele und Dokumentation vervollständigen

### Hochschulvorgaben (interne Freigabe bestätigt)

- [x] Vorlagenstand durch den Vorgesetzten freigegeben, laut Rückmeldung
  vom 18. November 2026.
- [x] Vorgaben aus den vier V1-Dateien einschließlich KI-Übersicht übernommen.
- Zusätzliche Anforderungen eines konkreten Studiengangs beziehungsweise
  Abgabeprozesses bei Bedarf gesondert klären; die vier V1-Dateien enthalten
  keine Eigenständigkeitserklärung.

### Plattform- und Bedienungstests (offen vor `v1.0.0`)

- [x] macOS-Tests laut Rückmeldung vom 18. November 2026 abgeschlossen.
- [ ] Windows: PDF-Erzeugung, Vorschau und dokumentierte VS-Code-Tasks testen.
- [ ] Linux: PDF-Erzeugung, Vorschau und dokumentierte VS-Code-Tasks testen.

### `v0.9.0` - Release Candidate (veröffentlicht)

Der technische Stand wird für abschließende Tests und Rückmeldungen
bereitgestellt. Bis zum stabilen Release sind noch folgende Schritte nötig:

- ein neues Projekt über **Use this template** erstellen
- eine vollständige Testarbeit ohne lokale Quarto- oder LaTeX-Installation bauen
- Anleitung durch eine Person testen lassen, die das Template nicht entwickelt hat
- verbleibende Fehler und unklare Dokumentation korrigieren

Korrekturen an diesem Stand erhalten bei Bedarf einen neuen Tag wie
`v0.9.1`; veröffentlichte Tags werden nicht nachträglich verschoben.

### `v1.0.0` - Stabiler Einsatz

Für die erste stabile Version müssen folgende Bedingungen erfüllt sein:

- Titelseite, Dokumentreihenfolge und Pflichttexte sind freigegeben.
- Bachelor- und Masterarbeiten wurden erfolgreich getestet.
- Windows, macOS und Linux werden durch den dokumentierten Docker-Workflow
  unterstützt.
- Ein neues Repository kann ohne zusätzliche persönliche Einführung verwendet
  werden.
- Builder- und Format-Versionen sind festgelegt und reproduzierbar.
- Quick Start, Detailanleitungen, Beispiele und Fehlerbehebung decken den
  normalen Arbeitsablauf ab.
- Mindestens eine vollständige Testarbeit wurde erfolgreich erstellt.

Ab `v1.0.0` sollen Änderungen innerhalb der Hauptversion abwärtskompatibel
bleiben. Grundlegende, inkompatible Änderungen an Dateistruktur oder
Konfiguration würden eine neue Hauptversion wie `v2.0.0` erfordern.
