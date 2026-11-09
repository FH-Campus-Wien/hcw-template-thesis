# Roadmap zum stabilen Thesis-Template

[← Quick Start und Inhaltsverzeichnis](../../README.md)

Aktueller Vorab-Release: `v0.3.0-alpha.1`.

Die V1-Word-Vorgaben sind technisch weitgehend integriert. Dieser Stand ist
noch kein Release Candidate und keine formale Freigabe durch die Hochschule.
Die Versionsnummern sind Meilensteine, keine Prozentangaben zum Fortschritt.

## Stand dieses Vorab-Releases

Bereits umgesetzt und technisch geprüft:

- Bachelor/Master und Deutsch/Englisch zentral in `setup.tex` auswählen.
- Getrennte Sprachdateien, vollständige Struktur für Vor- und Nachspann.
- Titelseite mit Logo und Linienmotiv sowie Beispiele aus den vier V1-Vorlagen.
- 12 pt Fließtext, 1,25-facher Zeilenabstand, 8 pt Absatzabstand und
  abschnittsabhängige Seitenränder entsprechend den V1-Word-Dateien.
- Flattersatz als Voreinstellung; Blocksatz bleibt wählbar.
- Aufgeräumte Verzeichnisse, kurzer Quick Start und ausführliche Themenseiten.

Vor `v0.9.0` bleiben insbesondere die verbindlichen Pflichttexte, akademischen
Bezeichnungen und weitere Gestaltungsdetails abzustimmen. Die vollständigen
Endanwender-Tests unter Windows und Linux sowie der Test durch eine neue Person
sind ebenfalls noch offen. Automatisierte Container-Tests auf AMD64 und ARM64
ersetzen diese Betriebssystem- und Bedienungstests nicht.

Die Änderungen dieses Stands stehen in den [Release Notes](CHANGELOG.md).

Das Thesis-Template erreicht `v1.0.0`, sobald es für eine reale Bachelor- oder
Masterarbeit ohne grundlegende Änderungen an Aufbau, Bedienung oder
Konfiguration eingesetzt werden kann. Ab diesem Zeitpunkt gilt die vorhandene
Struktur als verlässliche Schnittstelle für Studierende und Betreuende.

## Geplante Meilensteine

### `v0.2.x` - Struktur und Gestaltung

- Titelseite und Linienmotiv fertigstellen
- Frontmatter und Backmatter vollständig strukturieren
- Bachelor- und Masterkonfiguration getrennt prüfen
- Beispiele und Dokumentation vervollständigen

### `v0.3.0` - Hochschulvorgaben (in Arbeit)

- endgültige Pflichtbestandteile mit den zuständigen Stellen abstimmen
- freigegebenen Wortlaut der Eigenständigkeitserklärung übernehmen
- Vorgaben zur Dokumentation eingesetzter KI-Werkzeuge festhalten
- akademische Grade und Bezeichnungen prüfen

### `v0.4.0` - Plattformtests

- PDF-Erzeugung und Vorschau unter Windows testen
- PDF-Erzeugung und Vorschau unter macOS testen
- PDF-Erzeugung und Vorschau unter Linux testen
- dokumentierte VS-Code-Tasks auf allen Plattformen prüfen

### `v0.9.0` - Release Candidate

- ein neues Projekt über **Use this template** erstellen
- eine vollständige Testarbeit ohne lokale Quarto- oder LaTeX-Installation bauen
- Anleitung durch eine Person testen lassen, die das Template nicht entwickelt hat
- verbleibende Fehler und unklare Dokumentation korrigieren

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
