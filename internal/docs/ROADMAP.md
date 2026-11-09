# Roadmap zum stabilen Thesis-Template

Aktueller veröffentlichter Stand: `v0.2.1`

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

### `v0.3.0` - Hochschulvorgaben

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
- README, Beispiele und Fehlerbehebung decken den normalen Arbeitsablauf ab.
- Mindestens eine vollständige Testarbeit wurde erfolgreich erstellt.

Ab `v1.0.0` sollen Änderungen innerhalb der Hauptversion abwärtskompatibel
bleiben. Grundlegende, inkompatible Änderungen an Dateistruktur oder
Konfiguration würden eine neue Hauptversion wie `v2.0.0` erfordern.
