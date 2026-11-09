# Installation und Einrichtung

[← Quick Start und Inhaltsverzeichnis](../../README.md)

Dateipfade beziehen sich auf den Projektstamm. Terminalbefehle werden dort ausgeführt.

## Voraussetzungen

- Git
- Docker Desktop unter Windows/macOS oder Docker Engine unter Linux
- Visual Studio Code (empfohlen) oder ein anderer Texteditor

Unter Windows muss Docker Desktop mit Linux-Containern laufen. Das übliche
WSL-2-Backend ist geeignet. Eine eigene LaTeX-, Quarto-, Pandoc- oder
WSL-Installation ist nicht erforderlich.

## Neues Projekt aus der Vorlage erstellen

Dieses Repository ist als GitHub Template Repository eingerichtet. Für jede
Abschlussarbeit wird daraus ein neues, unabhängiges Repository erstellt:

1. Auf GitHub
   [FH-Campus-Wien/hcw-template-thesis](https://github.com/FH-Campus-Wien/hcw-template-thesis)
   öffnen.
2. **Use this template → Create a new repository** auswählen.
3. Eigentümer:in, Repository-Name und gewünschte Sichtbarkeit festlegen.
4. **Create repository** auswählen.
5. Das neu erstellte Repository klonen:

```shell
git clone https://github.com/ORGANISATION-ODER-BENUTZER/NEUES-REPOSITORY.git
cd NEUES-REPOSITORY
```

Wenn die Hochschule bereits ein persönliches Repository bereitgestellt hat,
werden die ersten vier Schritte übersprungen und direkt dessen Clone-URL
verwendet.

Das zentrale Template-Repository sollte nicht direkt geklont werden. Andernfalls
zeigt `origin` weiterhin auf die zentrale Vorlage, was beim späteren Pushen
verwirrend ist. Für eine ausschließlich lokale Arbeit ohne GitHub-Repository
kann die Vorlage über **Code → Download ZIP** heruntergeladen und entpackt
werden.

## VS Code einrichten

Öffnen Sie den geklonten Ordner:

```shell
code .
```

Falls das Terminal auf macOS `command not found: code` meldet, wird der Ordner
über **Datei → Ordner öffnen** ausgewählt. Optional lässt sich der Befehl in
VS Code über `Cmd+Shift+P` und
**Shell Command: Install 'code' command in PATH** aktivieren.

### Empfohlene Erweiterungen

Installieren Sie die von VS Code empfohlenen Erweiterungen:

- **Quarto** (`quarto.quarto`): Unterstützung für `.qmd`-Dateien, Syntax,
  YAML-Metadaten, Zitate, Formeln und den visuellen Markdown-Editor.
- **Container Tools** (`ms-azuretools.vscode-containers`): Anzeige und Verwaltung
  der lokalen Docker-Images, Container und Logs.
- **vscode-pdf** (`tomoki1207.pdf`): öffnet die erzeugte PDF direkt in einem
  VS-Code-Tab, ohne einen externen PDF-Reader zu benötigen.
- **Code Spell Checker** (`streetsidesoftware.code-spell-checker`): englische
  Rechtschreibprüfung im Editor; das englische Wörterbuch ist bereits in dieser
  Basis-Erweiterung enthalten.
- **German - Code Spell Checker**
  (`streetsidesoftware.code-spell-checker-german`): deutsches Wörterbuch für
  die Rechtschreibprüfung.

VS Code zeigt beim ersten Öffnen des Projektordners normalerweise eine
Empfehlung zur gemeinsamen Installation an. Alternativ können die Erweiterungen
über die Erweiterungsansicht (`Ctrl+Shift+X`) anhand der oben angegebenen IDs
gesucht und einzeln installiert werden. Quarto selbst bleibt trotz der
Editor-Erweiterung ausschließlich im Docker-Container.

Die Rechtschreibprüfung ist im Projekt für Deutsch und Englisch aktiviert
(`de-DE,en`). Dadurch können sowohl deutsch- als auch englischsprachige Arbeiten
ohne Änderung der VS-Code-Konfiguration geschrieben werden.

Die Arbeit wird über die Docker-Tasks gebaut, nicht über den Preview-Button
der Quarto-Erweiterung. Details stehen unter [Build und Vorschau](build-und-vorschau.md).

[Zurück zum Inhaltsverzeichnis](../../README.md#inhaltsverzeichnis)
