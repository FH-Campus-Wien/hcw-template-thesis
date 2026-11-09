# PDF bauen und Vorschau verwenden

[← Quick Start und Inhaltsverzeichnis](../../README.md)

Dateipfade beziehen sich auf den Projektstamm. Terminalbefehle werden dort ausgeführt.

## VS-Code-Tasks

Die folgenden VS-Code-Tasks sind vorkonfiguriert:

- `Thesis: PDF erstellen` erzeugt `build/abschlussarbeit.pdf`.
- `Thesis: Vorschau starten` stellt die PDF unter
  <http://localhost:4242/abschlussarbeit.pdf> bereit.
- `Thesis: Vorschau stoppen` beendet den laufenden Vorschau-Container.

Ein separater Task zum Erstellen der Umgebung ist nicht mehr erforderlich.
Beim ersten Start von `PDF erstellen` oder `Vorschau starten` lädt Docker
automatisch das öffentliche Image
`ghcr.io/fh-campus-wien/hcw-document-builder:1.3.0`. Dafür ist keine
GitHub-Anmeldung notwendig. Danach liegt das Image lokal in Docker und wird bei
weiteren Starts wiederverwendet.

Mit **Terminal → Run Task** ist das Menü in der oberen Menüleiste von VS Code
gemeint, nicht das Eingeben eines Befehls in einer Shell. Je nach Sprache der
Oberfläche heißt der Menüpunkt **Terminal → Run Task** oder
**Terminal → Aufgabe ausführen**. Danach wird der gewünschte Thesis-Task aus der
Liste ausgewählt.

Alternativ können Tasks über die Befehlspalette gestartet werden:

1. `Ctrl+Shift+P` unter Windows/Linux beziehungsweise `Cmd+Shift+P` unter macOS
   drücken.
2. `Tasks: Run Task` beziehungsweise `Aufgaben: Aufgabe ausführen` eingeben.
3. Den gewünschten `Thesis: ...`-Task auswählen.

`Ctrl+Shift+B` unter Windows/Linux beziehungsweise `Cmd+Shift+B` unter macOS
startet direkt den Standardtask `Thesis: PDF erstellen`. Wer stattdessen einen
Befehl in das integrierte Terminal eingeben möchte, verwendet die
Docker-Befehle im folgenden Abschnitt **Ohne VS Code**.

Beim ersten Durchlauf wird das fertige Builder-Image heruntergeladen. Das kann
je nach Internetverbindung einige Minuten dauern; es werden dabei keine
LaTeX-Pakete auf dem eigenen Betriebssystem installiert. Das Image unterstützt
`linux/amd64` und `linux/arm64`. Docker wählt automatisch die native Variante
des Computers; Apple-Silicon-Macs benötigen daher keine AMD64-Emulation mehr.

## Ohne VS Code

### Builder-Image vorab laden (optional)

Die folgenden `docker run`-Befehle laden das Image automatisch, wenn es noch
nicht vorhanden ist. Wer den Download bewusst vor dem ersten Build ausführen
möchte, verwendet auf allen Betriebssystemen:

```shell
docker pull ghcr.io/fh-campus-wien/hcw-document-builder:1.3.0
```

Das Image ist öffentlich; `docker login` ist nicht erforderlich. Die konkrete
Version `1.3.0` ist absichtlich festgelegt, damit alle Studierenden mit
derselben Toolchain arbeiten.

### Windows PowerShell

PDF erstellen:

```powershell
docker run --rm `
  --mount "type=bind,source=$PWD,target=/work" `
  --workdir /work `
  --entrypoint /bin/sh `
  ghcr.io/fh-campus-wien/hcw-document-builder:1.3.0 `
  internal/scripts/thesis.sh render
```

Vorschau starten:

```powershell
docker run --rm --init `
  --name thesis-preview `
  --mount "type=bind,source=$PWD,target=/work" `
  --workdir /work `
  --publish 127.0.0.1:4242:4242 `
  --entrypoint /bin/sh `
  ghcr.io/fh-campus-wien/hcw-document-builder:1.3.0 `
  internal/scripts/thesis.sh preview --host 0.0.0.0 --port 4242 --no-browser
```

### Windows-Eingabeaufforderung (cmd.exe)

PDF erstellen:

```bat
docker run --rm --mount "type=bind,source=%cd%,target=/work" --workdir /work --entrypoint /bin/sh ghcr.io/fh-campus-wien/hcw-document-builder:1.3.0 internal/scripts/thesis.sh render
```

Vorschau starten:

```bat
docker run --rm --init --name thesis-preview --mount "type=bind,source=%cd%,target=/work" --workdir /work --publish 127.0.0.1:4242:4242 --entrypoint /bin/sh ghcr.io/fh-campus-wien/hcw-document-builder:1.3.0 internal/scripts/thesis.sh preview --host 0.0.0.0 --port 4242 --no-browser
```

### macOS und Linux

PDF erstellen:

```bash
docker run --rm \
  --mount "type=bind,source=$PWD,target=/work" \
  --workdir /work \
  --entrypoint /bin/sh \
  ghcr.io/fh-campus-wien/hcw-document-builder:1.3.0 \
  internal/scripts/thesis.sh render
```

Vorschau starten:

```bash
docker run --rm --init \
  --name thesis-preview \
  --mount "type=bind,source=$PWD,target=/work" \
  --workdir /work \
  --publish 127.0.0.1:4242:4242 \
  --entrypoint /bin/sh \
  ghcr.io/fh-campus-wien/hcw-document-builder:1.3.0 \
  internal/scripts/thesis.sh preview --host 0.0.0.0 --port 4242 --no-browser
```

Die Vorschau wird mit `Ctrl+C` beendet. Falls das aktuelle Terminal keine
Eingabe annimmt, kann sie aus einem zweiten Terminal auf allen Betriebssystemen
mit folgendem Befehl gestoppt werden:

```shell
docker stop thesis-preview
```

## Automatische PDF-Vorschau

Der Task `Thesis: Vorschau starten` führt im Container `quarto preview` aus und
bleibt dauerhaft aktiv. Quarto beobachtet dabei die Projektdateien. Nach dem
Speichern einer `.qmd`-Datei wird die Arbeit automatisch neu gerendert und die
PDF-Vorschau im Browser aktualisiert.

Ein typischer Schreibablauf sieht so aus:

1. In VS Code **Terminal → Run Task → Thesis: Vorschau starten** auswählen.
2. Im Browser <http://localhost:4242/abschlussarbeit.pdf> öffnen.
3. Eine `.qmd`-Datei in VS Code bearbeiten und speichern.
4. Warten, bis der laufende Task den neuen Build im Terminal meldet.
5. Die aktualisierte PDF im Browser kontrollieren.
6. Die Vorschau mit dem Task `Thesis: Vorschau stoppen` beenden. Alternativ im
   fokussierten Vorschau-Terminal `Ctrl+C` drücken.

Der Unterschied zwischen den beiden Tasks:

- `Thesis: PDF erstellen` rendert die Arbeit einmal und beendet den Container.
- `Thesis: Vorschau starten` hält den Container aktiv, überwacht Änderungen und
  rendert nach dem Speichern automatisch neu.

Das Terminal ist während der Vorschau durch den laufenden Prozess belegt und
kann nicht gleichzeitig als normale Kommandozeile verwendet werden. Über das
Plus-Symbol im Terminalbereich kann bei Bedarf ein weiteres Terminal geöffnet
werden. Falls `Ctrl+C` nicht reagiert, wird die Vorschau zuverlässig über
**Terminal → Run Task → Thesis: Vorschau stoppen** beendet. Das Papierkorb-Symbol
im Terminalbereich beendet sie ebenfalls.

Die Option `--no-browser` bedeutet nicht, dass keine Browser-Vorschau verfügbar
ist. Sie verhindert nur, dass Quarto versucht, einen Browser innerhalb des
Docker-Containers zu öffnen. Der Browser läuft auf dem eigenen Betriebssystem
und greift über den ausschließlich lokal freigegebenen Port `4242` auf die
Vorschau zu.

Bei umfangreichen Arbeiten kann ein vollständiger Neuaufbau einige Sekunden
dauern. Im VS-Code-Terminal ist erkennbar, wann das Rendern abgeschlossen ist.
Falls der Browser eine Änderung nicht sofort darstellt, kann die Seite einmal
manuell neu geladen werden.

Vor dem Start entfernt der Container-Starthelfer ausschließlich die von Quarto
generierte Datei `.quarto/preview/lock`. Das verhindert, dass ein nach einem
Abbruch verbliebener Lock wegen wiederverwendeter Container-Prozessnummern den
nächsten Vorschauprozess irrtümlich beendet. Projektinhalte werden dabei nicht
gelöscht.

[Zurück zum Inhaltsverzeichnis](../../README.md#inhaltsverzeichnis)
