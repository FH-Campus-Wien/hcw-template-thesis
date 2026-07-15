# Abschlussarbeit mit Quarto, Markdown und Docker

Vorlage für Bachelor- und Masterarbeiten. Geschrieben wird hauptsächlich in
Quarto-Markdown (`.qmd`). Quarto, Pandoc und LaTeX laufen ausschließlich in
Docker und müssen nicht lokal installiert werden.

GitHub dient nur zum Herunterladen und zur Versionsverwaltung. PDF-Erzeugung
und Vorschau laufen vollständig auf dem eigenen Computer.

## Voraussetzungen

- Git
- Docker Desktop unter Windows/macOS oder Docker Engine unter Linux
- Visual Studio Code (empfohlen) oder ein anderer Texteditor

Unter Windows muss Docker Desktop mit Linux-Containern laufen. Das übliche
WSL-2-Backend ist geeignet. Eine eigene LaTeX-, Quarto-, Pandoc- oder
WSL-Installation ist nicht erforderlich.

## Herunterladen

```shell
git clone https://github.com/EURE-ORGANISATION/EUER-REPOSITORY.git
cd EUER-REPOSITORY
```

Die Platzhalter sind durch die tatsächlichen Repository-Angaben zu ersetzen.

## Empfohlen: Visual Studio Code

Öffnen Sie den geklonten Ordner:

```shell
code .
```

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

Die folgenden VS-Code-Tasks sind vorkonfiguriert:

- `Thesis: Umgebung erstellen` erstellt das lokale Docker-Image.
- `Thesis: PDF erstellen` erzeugt `build/abschlussarbeit.pdf`.
- `Thesis: Vorschau starten` startet <http://localhost:4242>.
- `Thesis: Vorschau stoppen` beendet den laufenden Vorschau-Container.

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

Beim ersten Durchlauf werden das
Basis-Image und TeX Live geladen; spätere Durchläufe verwenden den Docker-Cache.
Auf Macs mit Apple Silicon verwendet das offizielle Quarto-Image derzeit
Docker-Emulation; der erste Image-Build kann dort deshalb länger dauern.

## Ohne VS Code

### Einmalig: Docker-Image erstellen

Dieser Befehl ist auf allen Betriebssystemen gleich:

```shell
docker build --platform linux/amd64 --tag thesis-builder:local .
```

Er muss beim ersten Start und nach Änderungen am `Dockerfile` ausgeführt werden.

### Windows PowerShell

PDF erstellen:

```powershell
docker run --rm --platform linux/amd64 `
  --mount "type=bind,source=$PWD,target=/work" `
  --workdir /work `
  thesis-builder:local render
```

Vorschau starten:

```powershell
docker run --rm --init --platform linux/amd64 `
  --mount "type=bind,source=$PWD,target=/work" `
  --workdir /work `
  --publish 127.0.0.1:4242:4242 `
  --entrypoint thesis-preview `
  thesis-builder:local --host 0.0.0.0 --port 4242 --no-browser
```

### Windows-Eingabeaufforderung (cmd.exe)

PDF erstellen:

```bat
docker run --rm --platform linux/amd64 --mount "type=bind,source=%cd%,target=/work" --workdir /work thesis-builder:local render
```

Vorschau starten:

```bat
docker run --rm --init --platform linux/amd64 --mount "type=bind,source=%cd%,target=/work" --workdir /work --publish 127.0.0.1:4242:4242 --entrypoint thesis-preview thesis-builder:local --host 0.0.0.0 --port 4242 --no-browser
```

### macOS und Linux

PDF erstellen:

```bash
docker run --rm --platform linux/amd64 \
  --mount "type=bind,source=$PWD,target=/work" \
  --workdir /work \
  thesis-builder:local render
```

Vorschau starten:

```bash
docker run --rm --init --platform linux/amd64 \
  --mount "type=bind,source=$PWD,target=/work" \
  --workdir /work \
  --publish 127.0.0.1:4242:4242 \
  --entrypoint thesis-preview \
  thesis-builder:local --host 0.0.0.0 --port 4242 --no-browser
```

Die Vorschau wird mit `Ctrl+C` beendet.

### Arbeiten mit der automatischen PDF-Vorschau

Der Task `Thesis: Vorschau starten` führt im Container `quarto preview` aus und
bleibt dauerhaft aktiv. Quarto beobachtet dabei die Projektdateien. Nach dem
Speichern einer `.qmd`-Datei wird die Arbeit automatisch neu gerendert und die
PDF-Vorschau im Browser aktualisiert.

Ein typischer Schreibablauf sieht so aus:

1. In VS Code **Terminal → Run Task → Thesis: Vorschau starten** auswählen.
2. Im Browser <http://localhost:4242> öffnen.
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

## Projekt bearbeiten

```text
_quarto.yml       Titel, Autor:in, Struktur und PDF-Einstellungen
index.qmd         Angaben, Kurzfassung, Abstract und Erklärung
chapters/         Kapitel der Arbeit
references.bib    Literaturdatenbank im BibTeX-Format
references.qmd    Position des Literaturverzeichnisses
images/           Abbildungen
template/         zentrale LaTeX-Gestaltung
build/            erzeugte PDF und weitere Ausgaben
```

Normaler Inhalt wird als Markdown geschrieben:

```markdown
# Einleitung

Das ist ein Absatz mit einer Quelle [@mustermann2025].

## Forschungsfrage

Welche Auswirkungen hat ...?
```

LaTeX kann in Ausnahmefällen direkt eingebettet werden:

````markdown
```{=latex}
\begin{landscape}
  % spezieller LaTeX-Inhalt
\end{landscape}
```
````

## Schreiben mit Quarto-Markdown

Quarto-Markdown verwendet für normale Inhalte eine einfache Textsyntax. Die
Quelldateien bleiben dadurch gut lesbar und können mit jedem Texteditor
bearbeitet werden.

### Überschriften und Absätze

Überschriften werden mit `#` geschrieben. Ein einzelnes `#` bezeichnet in
diesem Buchprojekt ein Kapitel, zwei `##` einen Abschnitt und drei `###` einen
Unterabschnitt:

```markdown
# Methodik

Das ist ein normaler Absatz. Ein neuer Absatz beginnt nach einer Leerzeile.

## Datenerhebung

### Auswahl der Stichprobe
```

Kapitel sollten nur in den Dateien beginnen, die in `_quarto.yml` unter
`book.chapters` eingetragen sind.

### Hervorhebungen, Listen und Links

```markdown
Dieser Text ist **fett**, dieser Text ist *kursiv* und dieses Wort ist
`technischer Code`.

- erster Punkt
- zweiter Punkt
  - eingerückter Unterpunkt

1. erster Schritt
2. zweiter Schritt

[Quarto-Dokumentation](https://quarto.org/docs/)
```

### Formeln

Eine Formel innerhalb eines Satzes wird mit einfachen Dollarzeichen
geschrieben, beispielsweise `$U = R \cdot I$`.

Eine abgesetzte, nummerierte Formel erhält ein Label mit dem Präfix `eq-`:

```markdown
$$
U = R \cdot I
$$ {#eq-ohmsches-gesetz}
```

Im Fließtext wird mit `@eq-ohmsches-gesetz` darauf verwiesen:

```markdown
Aus @eq-ohmsches-gesetz folgt der elektrische Widerstand.
```

Quarto erzeugt daraus automatisch die richtige Formelnummer. Wenn Formeln
hinzugefügt oder verschoben werden, werden alle Verweise beim nächsten Build
aktualisiert.

### Tabellen

Einfache Tabellen werden direkt in Markdown geschrieben:

```markdown
| Messgröße | Formelzeichen | Wert |
|---|:---:|---:|
| Spannung | U | 5,0 V |
| Strom | I | 20 mA |

: Elektrische Messwerte {#tbl-messwerte}
```

Die Doppelpunkte in der Trennzeile steuern die Ausrichtung. Im Beispiel ist die
zweite Spalte zentriert und die dritte rechtsbündig. Die Zeile unter der Tabelle
ist die Tabellenbeschriftung. Das Label beginnt mit `tbl-`.

Ein Verweis wird so geschrieben:

```markdown
Die Ergebnisse sind in @tbl-messwerte zusammengefasst.
```

Sehr breite oder komplexe Tabellen können bei Bedarf mit eingebettetem LaTeX
erstellt werden. Für normale Datentabellen sollte Markdown bevorzugt werden.

### Bilder und Abbildungen

Bilder werden im Verzeichnis `images/` gespeichert. Unterstützt werden unter
anderem PNG, JPEG und PDF. Für Fotos und Rastergrafiken eignet sich PNG oder
JPEG; Diagramme und andere Vektorgrafiken sollten nach Möglichkeit als PDF
eingebunden werden.

Vom Projektstamm beziehungsweise aus `index.qmd` wird ein Bild so eingebunden:

```markdown
![Generisches Microcontroller-Entwicklungsboard](images/microcontroller.png){#fig-microcontroller width=75% fig-alt="Grüne Leiterplatte mit einem zentralen Microcontroller und elektronischen Bauteilen"}
```

Aus einer Datei im Unterverzeichnis `chapters/` führt der relative Pfad eine
Ebene nach oben:

```markdown
![Generisches Microcontroller-Entwicklungsboard](../images/microcontroller.png){#fig-microcontroller width=75% fig-alt="Grüne Leiterplatte mit einem zentralen Microcontroller und elektronischen Bauteilen"}
```

Die Bestandteile sind:

- Der Text in `![...]` ist die sichtbare Bildunterschrift.
- Der Pfad in `(...)` verweist auf die Bilddatei.
- `#fig-microcontroller` ist das eindeutige Label der Abbildung.
- `width=75%` legt die relative Bildbreite fest.
- `fig-alt` beschreibt den Bildinhalt für barrierearme Ausgaben.

Im Text kann anschließend automatisch auf die Abbildung verwiesen werden:

```markdown
Der verwendete Aufbau ist in @fig-microcontroller dargestellt.
```

Das mitgelieferte Beispielbild liegt unter `images/microcontroller.png` und ist
in `chapters/04-ergebnisse.qmd` eingebunden. Bilddateien sollten aussagekräftige
Namen ohne Leerzeichen besitzen. Groß- und Kleinschreibung muss mit dem Pfad im
Markdown exakt übereinstimmen.

### Querverweise

Labels müssen innerhalb des gesamten Projekts eindeutig sein. Die Präfixe
bestimmen den Typ des referenzierten Elements:

```text
fig-   Abbildungen
tbl-   Tabellen
eq-    Formeln
sec-   Abschnitte
```

Auch Abschnitte können ein Label erhalten:

```markdown
## Versuchsaufbau {#sec-versuchsaufbau}

Wie in @sec-versuchsaufbau beschrieben, ...
```

Keine Nummern wie „Abbildung 3“ oder „Tabelle 2“ manuell in den Text schreiben.
Die `@...`-Verweise bleiben richtig, auch wenn Inhalte später verschoben werden.

### Codeblöcke

Programmcode wird mit drei Backticks eingeschlossen. Die Sprache nach den
öffnenden Backticks aktiviert die Syntaxhervorhebung:

````markdown
```c
int main(void) {
    return 0;
}
```
````

Dieser Code wird nur dargestellt und nicht ausgeführt. Ausführbare Codezellen
für Python, R oder Julia benötigen zusätzliche Laufzeiten und sind in der
aktuellen Docker-Vorlage nicht vorkonfiguriert.

### Fußnoten

```markdown
Diese Aussage benötigt eine ergänzende Erklärung.^[Text der Fußnote.]
```

Quarto nummeriert Fußnoten automatisch und setzt sie in der PDF an die passende
Position.

## Literatur und Zitate mit BibTeX

Alle Literaturangaben werden zentral in `references.bib` gespeichert. Die Datei
verwendet das BibTeX-Format und kann manuell bearbeitet oder aus einer
Literaturverwaltung wie Zotero exportiert werden.

Die Datei ist in `_quarto.yml` eingebunden:

```yaml
bibliography: references.bib
```

Das Literaturverzeichnis wird automatisch in `references.qmd` erzeugt. Diese
Datei sollte in der Kapitelliste von `_quarto.yml` an der gewünschten Position
stehen.

### BibTeX-Einträge anlegen

Jeder Eintrag besitzt einen eindeutigen Zitationsschlüssel. Im folgenden
Beispiel lautet er `mustermann2025`:

```bibtex
@book{mustermann2025,
  author    = {Mustermann, Erika},
  title     = {Wissenschaftliches Arbeiten},
  year      = {2025},
  publisher = {Beispielverlag},
  location  = {Wien}
}
```

Beispiel für einen Zeitschriftenartikel:

```bibtex
@article{huber2024,
  author  = {Huber, Anna and Meier, Thomas},
  title   = {Ein Beispiel für einen Fachartikel},
  journal = {Zeitschrift für Beispielforschung},
  year    = {2024},
  volume  = {12},
  number  = {3},
  pages   = {40--58},
  doi     = {10.1234/beispiel.2024.123}
}
```

Beispiel für eine Internetquelle:

```bibtex
@online{beispiel2026,
  author  = {{Beispielorganisation}},
  title   = {Titel der Webseite},
  year    = {2026},
  url     = {https://example.org/quelle},
  urldate = {2026-07-15}
}
```

Bei mehreren Personen werden die Namen mit `and` getrennt. Institutionen werden
in doppelte geschweifte Klammern gesetzt, damit BibTeX den Namen nicht in Vor-
und Nachnamen zerlegt. Die Datei wird als UTF-8 gespeichert; deutsche Umlaute
können direkt eingegeben werden.

### In Markdown zitieren

Ein Zitat in Klammern:

```markdown
Diese Vorgehensweise ist gut dokumentiert [@mustermann2025].
```

Ein Zitat mit Seitenangabe:

```markdown
Diese Definition wird in der Literatur erläutert [@mustermann2025, S. 42].
```

Mehrere Quellen in einem Zitat werden mit Semikolon getrennt:

```markdown
Mehrere Untersuchungen bestätigen diesen Zusammenhang
[@mustermann2025; @huber2024].
```

Der Name kann Teil des Satzes sein:

```markdown
@mustermann2025 beschreibt diese Methode ausführlich.
```

Soll nur das Jahr beziehungsweise der Zitationsrest erscheinen, kann der Name
im Klammerzitat unterdrückt werden:

```markdown
Mustermann [-@mustermann2025] beschreibt diese Methode ausführlich.
```

Der Zitationsschlüssel nach `@` muss exakt mit dem Schlüssel in
`references.bib` übereinstimmen. Groß- und Kleinschreibung sollte ebenfalls
beibehalten werden.

### Literaturverzeichnis

Die Datei `references.qmd` enthält den Platzhalter für alle im Text verwendeten
Quellen:

```markdown
# Literaturverzeichnis {.unnumbered}

::: {#refs}
:::
```

Standardmäßig erscheinen nur tatsächlich zitierte Quellen. Eine Quelle, die im
Literaturverzeichnis stehen soll, ohne im Fließtext sichtbar zitiert zu werden,
kann mit `nocite` in einem YAML-Block aufgenommen werden:

```yaml
---
nocite: |
  @beispiel2026
---
```

Mit `@*` werden alle Einträge aus `references.bib` aufgenommen:

```yaml
---
nocite: |
  @*
---
```

### Verarbeitung und Zitierstil

`references.bib` ist eine normale BibTeX-Datei. Die Zitate werden in dieser
Vorlage von Pandoc Citeproc verarbeitet; Studierende müssen `bibtex` oder
`biber` nicht selbst aufrufen. Die komplette Verarbeitung erfolgt beim normalen
Docker-Build.

Ein verbindlicher Zitierstil kann später als CSL-Datei in das Projekt gelegt
und in `_quarto.yml` aktiviert werden:

```yaml
bibliography: references.bib
csl: citation-style.csl
```

Ohne CSL-Datei verwendet Quarto den voreingestellten Zitierstil.

### Export aus Zotero

In Zotero können ausgewählte Quellen oder eine ganze Sammlung über
**Exportieren → BibTeX** ausgegeben werden. Die exportierte Datei wird als
`references.bib` im Projekt gespeichert. Bereits vorhandene manuelle Einträge
sollten vor dem Ersetzen gesichert oder in Zotero übernommen werden.

Nach Änderungen wird die PDF wie gewohnt mit `Ctrl+Shift+B` in VS Code oder mit
dem dokumentierten `docker run`-Befehl neu erstellt.

### Häufige Fehler

- `citeproc: citation ... not found`: Der Schlüssel fehlt in `references.bib`
  oder ist anders geschrieben.
- Eine Quelle fehlt im Literaturverzeichnis: Sie wurde nicht zitiert und nicht
  über `nocite` aufgenommen.
- Namen werden falsch dargestellt: Personen mit `and` trennen; Institutionen
  in doppelte geschweifte Klammern setzen.
- Sonderzeichen sind beschädigt: `references.bib` als UTF-8 speichern.
- Änderungen erscheinen nicht: PDF erneut bauen und die Ausgabe im Ordner
  `build/` kontrollieren.

## Offline verwenden

Nur der erste Image-Build benötigt Internet. Danach sind Basis-Image, Quarto
und TeX Live lokal in Docker gespeichert und die PDF kann offline entstehen.

Ein vorbereitetes Image lässt sich für vollständig offline arbeitende Rechner
exportieren:

```shell
docker save thesis-builder:local --output thesis-builder.tar
```

Import auf dem Zielrechner:

```shell
docker load --input thesis-builder.tar
```

## Fehlerbehebung

### Docker ist nicht erreichbar

Docker Desktop starten und prüfen:

```shell
docker version
```

### Port 4242 ist belegt

Links vom Doppelpunkt einen anderen Port verwenden, beispielsweise
`--publish 127.0.0.1:4243:4242`, und danach
<http://localhost:4243> öffnen.

### Umgebung vollständig neu erstellen

```shell
docker build --no-cache --platform linux/amd64 --tag thesis-builder:local .
```

### Dateinamen

Der Linux-Container unterscheidet `Logo.png` und `logo.png`. Schreibweise in
Markdown und Dateisystem muss exakt übereinstimmen.

## Anhang: Toolchain für Fortgeschrittene

### Was ist Quarto?

[Quarto](https://quarto.org/) ist ein quelloffenes Publikationssystem für
technische und wissenschaftliche Dokumente. Es erweitert Markdown um Funktionen
wie Dokumentmetadaten, Kapitel, Querverweise, nummerierte Abbildungen und
Tabellen, Literaturzitate, Formeln sowie verschiedene Ausgabeformate.

Quarto ist dabei weder ein Texteditor noch eine eigene Textsatz-Engine. Es
koordiniert die einzelnen Verarbeitungsschritte und liest die
Projektkonfiguration aus `_quarto.yml`. Dateien mit der Endung `.qmd` sind
Quarto-Markdown-Dateien: größtenteils normales Markdown, ergänzt um
Quarto-spezifische Syntax und YAML-Metadaten.

### Komponenten

Die Vorlage verwendet folgende Werkzeuge:

- **Visual Studio Code** ist ausschließlich der Editor. Die Arbeit kann auch mit
  jedem anderen UTF-8-fähigen Texteditor bearbeitet werden.
- **Quarto** liest `_quarto.yml`, verbindet die Kapitel in der festgelegten
  Reihenfolge und steuert die Konvertierung.
- **Pandoc** wandelt Quarto-Markdown in LaTeX um.
- **Pandoc Citeproc** liest `references.bib`, löst Zitationsschlüssel auf und
  formatiert Zitate sowie das Literaturverzeichnis.
- **LaTeX** übernimmt den professionellen Textsatz, darunter Seitenaufteilung,
  Überschriften, Verzeichnisse, Tabellen und Formeln.
- **LuaLaTeX** ist die konkret verwendete LaTeX-Engine und erzeugt die PDF.
- **Docker** stellt Quarto, Pandoc, TeX Live und alle LaTeX-Pakete in einer
  reproduzierbaren Linux-Umgebung bereit.

### Verarbeitungskette

```text
_quarto.yml
      │
      ├── index.qmd
      ├── chapters/*.qmd
      ├── references.bib
      └── template/preamble.tex
               │
               ▼
             Quarto
               │
               ▼
       Pandoc + Citeproc
               │
               ▼
       temporäres LaTeX
               │
               ▼
            LuaLaTeX
               │
               ▼
  build/abschlussarbeit.pdf
```

Beim Rendern führt Quarto sinngemäß diese Aufgaben aus:

1. `_quarto.yml` und die Metadaten einlesen.
2. Alle Kapitel in der angegebenen Reihenfolge zusammenführen.
3. Markdown, Querverweise und Zitationen verarbeiten.
4. Ein temporäres LaTeX-Dokument erzeugen.
5. `template/preamble.tex` in das LaTeX-Dokument einbinden.
6. LuaLaTeX so oft ausführen, wie es für Verzeichnisse und Referenzen nötig ist.
7. Die fertige PDF im Verzeichnis `build/` ablegen.

Die temporäre `.tex`-Datei wird standardmäßig nicht behalten. Für die Analyse
von LaTeX-Problemen kann in `_quarto.yml` vorübergehend Folgendes gesetzt werden:

```yaml
format:
  pdf:
    keep-tex: true
```

### Rolle des Docker-Images

Das `Dockerfile` baut das lokale Image `thesis-builder:local`. Darin befinden
sich eine festgelegte Quarto-Version sowie TeX Live und die benötigten
LaTeX-Pakete. Ein kleiner Test wird bereits beim Image-Build gerendert. Dadurch
fällt eine unvollständige LaTeX-Umgebung früh auf und nicht erst während der
Arbeit an einem Kapitel.

Beim späteren `docker run` wird das Projekt nicht in den Container kopiert. Das
aktuelle Verzeichnis wird als sogenannter Bind Mount unter `/work` eingebunden:

```text
Projekt auf dem Host  <── Bind Mount ──>  /work im Container
```

Der Container liest dadurch die aktuellen `.qmd`-Dateien und schreibt die PDF
direkt zurück in den lokalen Ordner `build/`. Nach dem Build wird der Container
durch `--rm` entfernt; das Docker-Image und alle Projektdateien bleiben erhalten.

### Warum funktioniert der Build offline?

Der erste `docker build` benötigt Internet, um das Quarto-Basis-Image und die
TeX-Live-Pakete herunterzuladen. Danach befinden sich alle Programme und Pakete
im lokalen Image. `docker run` verwendet dieses Image und benötigt für normale
PDF-Builds keine Netzwerkverbindung.

Die Reproduzierbarkeit hängt davon ab, dass die Basisversion im `Dockerfile`
fest angegeben bleibt. Eine Änderung der Quarto-Version oder der installierten
TeX-Live-Pakete sollte deshalb bewusst vorgenommen und anschließend mit einem
vollständigen PDF-Build getestet werden.
