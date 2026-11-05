# Abschlussarbeit mit Quarto, Markdown und Docker

Vorlage für Bachelor- und Masterarbeiten. Geschrieben wird hauptsächlich in
Quarto-Markdown (`.qmd`). Quarto, Pandoc und LaTeX laufen ausschließlich im
öffentlichen, versionierten Docker-Image der Hochschule Campus Wien und müssen nicht
lokal installiert werden.

GitHub dient zum Herunterladen, zur Versionsverwaltung und zum einmaligen Bezug
des Builder-Images. PDF-Erzeugung und Vorschau laufen vollständig auf dem
eigenen Computer und funktionieren nach dem ersten Download auch offline.

Das Repository enthält außerdem eine freigegebene Kopie des gemeinsamen
Quarto-Formats `hcw-pdf` in Version `0.1.1`. Schrift, Farben,
Seitengrundlayout und gemeinsame LaTeX-Einstellungen werden dadurch zentral
gepflegt, sind für normale Builds aber direkt im Template vorhanden. Die
offizielle BA-/MA-Titelseite einschließlich Logo und Linienmotiv bleibt bewusst
thesis-spezifisch. Das Format wird beim Schreiben weder aus GitHub nachgeladen
noch automatisch aktualisiert.

Die geplanten Schritte bis zur stabilen Version `v1.0.0` stehen in der
[Roadmap](ROADMAP.md).

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

## Empfohlen: Visual Studio Code

Öffnen Sie den geklonten Ordner:

```shell
code .
```

Falls das Terminal auf macOS `command not found: code` meldet, wird der Ordner
über **Datei → Ordner öffnen** ausgewählt. Optional lässt sich der Befehl in
VS Code über `Cmd+Shift+P` und
**Shell Command: Install 'code' command in PATH** aktivieren.

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
  scripts/thesis.sh render
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
  scripts/thesis.sh preview --host 0.0.0.0 --port 4242 --no-browser
```

### Windows-Eingabeaufforderung (cmd.exe)

PDF erstellen:

```bat
docker run --rm --mount "type=bind,source=%cd%,target=/work" --workdir /work --entrypoint /bin/sh ghcr.io/fh-campus-wien/hcw-document-builder:1.3.0 scripts/thesis.sh render
```

Vorschau starten:

```bat
docker run --rm --init --name thesis-preview --mount "type=bind,source=%cd%,target=/work" --workdir /work --publish 127.0.0.1:4242:4242 --entrypoint /bin/sh ghcr.io/fh-campus-wien/hcw-document-builder:1.3.0 scripts/thesis.sh preview --host 0.0.0.0 --port 4242 --no-browser
```

### macOS und Linux

PDF erstellen:

```bash
docker run --rm \
  --mount "type=bind,source=$PWD,target=/work" \
  --workdir /work \
  --entrypoint /bin/sh \
  ghcr.io/fh-campus-wien/hcw-document-builder:1.3.0 \
  scripts/thesis.sh render
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
  scripts/thesis.sh preview --host 0.0.0.0 --port 4242 --no-browser
```

Die Vorschau wird mit `Ctrl+C` beendet. Falls das aktuelle Terminal keine
Eingabe annimmt, kann sie aus einem zweiten Terminal auf allen Betriebssystemen
mit folgendem Befehl gestoppt werden:

```shell
docker stop thesis-preview
```

### Arbeiten mit der automatischen PDF-Vorschau

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

## Projekt bearbeiten

```text
setup.tex         Auswahl Deutsch/Englisch und Bachelor/Master
_quarto.yml       gemeinsame Titelseitenangaben und PDF-Einstellungen
_quarto-de.yml    deutsche Kapiteldateien und Reihenfolge
_quarto-en.yml    englische Kapiteldateien und Reihenfolge
index.qmd         technische Startdatei des Quarto-Buchs
chapters/
├── de/           ausschließlich deutsche Kapitel
└── en/           ausschließlich englische Kapitel
frontmatter/
├── de/           Danksagung, Abkürzungen und Inhaltsverzeichnis auf Deutsch
├── en/           Acknowledgements, abbreviations und contents auf Englisch
├── kurzfassung.qmd
└── abstract.qmd  beide Zusammenfassungen gehören in jede Variante
backmatter/
├── de/           Literaturverzeichnis, KI-Dokumentation und Erklärung
└── en/           Bibliography, AI documentation und declaration
references.bib    gemeinsame Literaturdatenbank im BibTeX-Format
images/           Abbildungen
_extensions/
└── FH-Campus-Wien/hcw/
                   lokale Kopie des gemeinsamen HCW-Formats
hcw-format-version.txt
                   übernommener Release-Tag des HCW-Formats
ROADMAP.md         geplante Schritte bis zum stabilen Template v1.0.0
template/
├── title.tex      thesis-spezifische Titelseite
├── preamble.tex   thesis-spezifische LaTeX-Ergänzungen
└── assets/        Hintergrund der Titelseite
requirements/      offizielle BA-/MA-Referenzen für Deutsch und Englisch
scripts/           Werkzeuge für Vorlagenbetreuer:innen
build/            erzeugte PDF und weitere Ausgaben
```

Bearbeiten Sie ausschließlich die Dateien Ihrer Arbeitssprache:

| Auswahl in `setup.tex` | Kapitel bearbeiten | Vorspann und Nachspann |
|---|---|---|
| `\HCWLanguage` = `de` | `chapters/de/` | `frontmatter/de/` und `backmatter/de/` |
| `\HCWLanguage` = `en` | `chapters/en/` | `frontmatter/en/` und `backmatter/en/` |

Jede Kapiteldatei enthält nur eine Sprache. Überschriften, Erläuterungen und
Bildunterschriften werden direkt in dieser Datei bearbeitet. Die jeweils
andere Sprachfassung muss für eine eigene Arbeit nicht mitgepflegt werden.
Gemeinsam bleiben die Bilder unter `images/`, die Literaturdatenbank und die
zwei ausdrücklich vorgeschriebenen Zusammenfassungen: `frontmatter/kurzfassung.qmd`
und `frontmatter/abstract.qmd`.

Neue Kapitel werden in der Kapitelliste `book.chapters` des passenden Profils
`_quarto-de.yml` beziehungsweise `_quarto-en.yml` eingetragen. `index.qmd` im
Projektstamm bleibt als technische Startdatei bestehen; die Danksagung steht
in `frontmatter/de/danksagung.qmd` beziehungsweise
`frontmatter/en/acknowledgements.qmd`.
Diese beiden Dateien enthalten den Text der Danksagung. Die gemeinsame
Startdatei setzt die Überschrift aus `acknowledgements-title` im jeweiligen
Sprachprofil darüber.

### Titelseite für Bachelor- und Masterarbeiten

Die Titelseite folgt den offiziellen Word-Vorlagen für Bachelor- und
Masterarbeiten. Sie enthält das HCW-Logo, das helle Linienmotiv, den deutschen
und englischen Titel, Autor:in, akademischen Grad, Studiengang und Betreuung.
Die Sprache und die Abschlussart werden ausschließlich am Anfang von
`setup.tex` gewählt:

```latex
\newcommand{\HCWLanguage}{de}    % de oder en
\newcommand{\HCWThesisLevel}{ba} % ba oder ma
```

Damit ergeben sich vier unterstützte Varianten:

| `HCWLanguage` | `HCWThesisLevel` | Variante |
|---|---|---|
| `de` | `ba` | Bachelorarbeit auf Deutsch |
| `de` | `ma` | Masterarbeit auf Deutsch |
| `en` | `ba` | Bachelor’s Thesis auf Englisch |
| `en` | `ma` | Master’s Thesis auf Englisch |

Der Schalter steuert die Abschlussbezeichnung, den akademischen Grad, die
Reihenfolge der beiden Titel, die festen Beschriftungen der Titelseite, die
Sprache der Quarto-Querverweise sowie die Auswahl der Sprachordner und die
Reihenfolge im Vorspann. Der Build- und Vorschau-Task liest `setup.tex` automatisch; die
internen Profile `_quarto-de.yml` und `_quarto-en.yml` werden nicht manuell
gestartet.

Nach einer Änderung der Sprache wird eine bereits laufende Vorschau gestoppt
und neu gestartet, damit sie das passende Sprachprofil lädt.

Für Werkzeuge, die das Projekt ohne Build-Task einlesen, ist Deutsch als
Standardprofil hinterlegt. Die dokumentierten Build- und Vorschau-Tasks
wählen ausdrücklich die Sprache aus `setup.tex`.

Die persönlichen und arbeitsspezifischen Angaben bleiben in `_quarto.yml`:

```yaml
book:
  title: "English title of the thesis"
  subtitle: "English subtitle"
  author: "Vorname Nachname"

title-de: "Deutscher Titel der Abschlussarbeit"
subtitle-de: "Deutscher Untertitel"
study-program: "Name des Studiengangs"
institution: "Hochschule Campus Wien"
submission-year: "2026"
supervisors:
  - "Titel Vorname Nachname"
  - "Titel Vorname Nachname (optional)"
```

Die akademischen Grade sind in `setup.tex` entsprechend den Referenzvorlagen
mit `Bachelor of Science in Engineering` und `Master of Science in
Engineering` vorbelegt. Verleiht ein Studiengang einen anderen Grad, wird die
betreffende Zeile dort angepasst. Falls es nur eine Betreuungsperson gibt,
wird die zweite Zeile unter `supervisors` vollständig gelöscht. `book.title`
und `book.subtitle` sind der englische Titel und Untertitel; `title-de` und
`subtitle-de` enthalten die deutschen Fassungen.

Die Spracheinstellung lädt die Dateien des gewählten Sprachordners. Eigene
Änderungen bleiben in diesem Ordner; beim Wechsel wird die separat vorhandene
andere Fassung geladen und keine automatische Übersetzung erzeugt.

Das Hintergrundbild liegt ausschließlich in diesem Thesis-Template unter
`template/assets/hcw-thesis-title-background.jpg`. Es enthält bereits das Logo
und das Linienmotiv und wird nur auf der Titelseite eingesetzt. Die vier
V1-Word-Vorlagen unter `requirements/` sind die verbindlichen Referenzen für
Deutsch/Englisch und Bachelor/Master. Sie werden zum Schreiben der
Quarto-Arbeit nicht benötigt.

### Bilder, Formeln und Erklärungen aus den V1-Vorlagen

Die Inhaltsbeispiele wurden mit allen vier V1-Dateien verglichen. Bachelor-
und Mastervorlage verwenden dieselben mathematischen Beispiele und Bilder.
Die Erläuterungen und Bildunterschriften erscheinen passend zu
`HCWLanguage` auf Deutsch oder Englisch. Die Auswahl `ba`/`ma` verwendet
dieselben Beispiele mit der passenden Titelseite und Abschlussbezeichnung.

| Datei | Beispiele |
|---|---|
| `chapters/de/03-methodik.qmd` oder `chapters/en/03-methodology.qmd` | Fourier-Transformation und inverse Transformation, lineares Gleichungssystem, ausgerichtete Spannungsgleichungen, Logarithmusreihe mit Summen und Brüchen |
| `chapters/de/04-ergebnisse.qmd` oder `chapters/en/04-results.qmd` | Magnetron-Sputtern, kleines Grafikbeispiel, zwei Teilabbildungen, Cosinussignal mit Periodendauer, Kontrastvergleich sowie Tabellen und Querformat |
| `images/v1/` | neun gemeinsam verwendete Bilddateien aus den vier Referenzen |
| `references.bib` | die fünf Quellen der übernommenen V1-Beispiele |

Die Formeln bleiben editierbarer LaTeX-Mathematikcode. Zusammengehörende
Gleichungen werden mit `aligned` am Gleichheitszeichen ausgerichtet und hier
als gemeinsamer Block nummeriert. Die Vorlage erläutert außerdem Satzzeichen
an Formeln, die Definition von Variablen und aufrecht gesetzte Einheiten und
Konstanten, beispielsweise `$t = 5\,\mathrm{s}$`.

Die Rasterbilder sind unverändert aus den Word-Dateien extrahiert. Die drei
eingebetteten EMF-Grafiken liegen als Vektor-PDFs vor, damit sie im
plattformunabhängigen Docker-Build ohne zusätzliche Programme funktionieren.
Auch die beiden als Grafik vorliegenden Tabellen bleiben Tabellen mit
`tbl-`-Labels. Die große Verteilungsübersicht demonstriert eine eigene
Querformatseite. Die ursprünglichen Beschriftungen innerhalb der Grafiken
bleiben erhalten; Bildunterschriften und begleitende Erklärungen sind
zweisprachig.

Herkunft und Prüfsummen sind unter `images/v1/README.md` und
`images/v1/manifest.json` dokumentiert. Das dort beschriebene
`scripts/import-v1-images.py` ist ein optionales Werkzeug für
Vorlagenbetreuer:innen; für das Schreiben ist keine Extraktion erforderlich.

Die deutschen und englischen Erklärungen stehen in getrennten Dateien unter
`chapters/de/` und `chapters/en/`. Formeln und Bildunterschriften werden in der
jeweiligen Kapiteldatei bearbeitet; die eingebundenen Bilddateien werden
gemeinsam genutzt. Die Profile legen die Sprache, die zugehörige Kapitelliste
und die Überschrift der Danksagung fest. Labels wie `eq-fourier-transformation` stimmen in den beiden
Ausgangsvorlagen überein; es wird immer nur eine Fassung in den Build geladen.

Überschriften verwenden normale Markdown-Syntax, beispielsweise
`# Methodik {#sec-methodik}`. Das Abschnittslabel bleibt beim Umbenennen der
Überschrift erhalten und kann für Querverweise verwendet werden.
Die ergänzte Notiz unter der Verteilungsübersicht kennzeichnet das in der
Originalgrafik falsch gesetzte Varianzsymbol der Gleichverteilung und nennt
die korrekte Schreibweise.

Die Teilabbildungen in Kapitel 4 verwenden einen gemeinsamen Div-Block mit
`#fig-htm` und `layout-ncol=2`. Jedes Teilbild hat zusätzlich ein eigenes
`fig-`-Label; so können die Gesamtgrafik und einzelne Teile referenziert
werden. `layout-ncol=1` stellt die beiden Kontrastbeispiele untereinander dar.
Grafisch importierte Tabellen stehen analog in einem `tbl-`-Div mit einer
Tabellenbeschriftung. Das Beispiel im Querformat verwendet die bereits
eingebundene LaTeX-Umgebung `landscape`.

### Vorspann (Front Matter)

Nach der Titelseite folgt dieselbe Grundreihenfolge wie in den
Referenzvorlagen. In der deutschen Variante lautet sie:

1. `frontmatter/de/danksagung.qmd`: Danksagung
2. `frontmatter/kurzfassung.qmd`: deutsche Kurzfassung
3. `frontmatter/abstract.qmd`: englischer Abstract
4. `frontmatter/de/abkuerzungsverzeichnis.qmd`: optionales
   Abkürzungsverzeichnis
5. `frontmatter/de/inhaltsverzeichnis.qmd`: Inhaltsverzeichnis

In der englischen Variante werden `Acknowledgements` und `Abstract` zuerst
ausgegeben; danach folgen die deutsche `Kurzfassung`, `List of Abbreviations`
und `Table of Contents`. Die englischen Dateien liegen unter
`frontmatter/en/`; Kurzfassung und Abstract werden von beiden Varianten
verwendet und müssen jeweils nur einmal geschrieben werden.

Für Kurzfassung und Abstract gilt bewusst eine einfache, saloppe Merkhilfe:

> Erst das Problem und warum es ein Problem ist. Dann die Lösung und warum sie
> eine Lösung ist.

Jeder Eintrag beginnt auf einer eigenen Seite. Der Vorspann verwendet römische
Seitenzahlen; mit dem ersten Fachkapitel beginnt die arabische
Nummerierung bei 1. Die Reihenfolge wird im aktiven Sprachprofil
`_quarto-de.yml` oder `_quarto-en.yml` unter `book.chapters` festgelegt.
Dateien sollten dort nur nach einer bewussten
Anpassung der geforderten Hochschulstruktur verschoben oder entfernt werden.

Die Eigenständigkeitserklärung gehört nicht in den Vorspann. Die
HCW-Prüfungsordnung nennt sie für Bachelor- und Masterarbeiten nach dem
Quellenverzeichnis als letzten verpflichtenden Bestandteil. Sie liegt daher
unter `backmatter/de/eigenstaendigkeitserklaerung.qmd` beziehungsweise
`backmatter/en/declaration.qmd` und steht am Ende der jeweiligen Kapitelliste.
Ein allfälliger Anhang wird ebenfalls vor der Eigenständigkeitserklärung eingereiht.

### Dokumentation eingesetzter KI-Werkzeuge

Die Nutzung von KI-Werkzeugen ist kein Bestandteil des Vorspanns und keine
Gestaltungsregel des gemeinsamen Quarto-Formats. Sie wird als inhaltlicher
Bestandteil der jeweiligen Arbeit unter
`backmatter/de/ki-werkzeuge.qmd` beziehungsweise `backmatter/en/ai-tools.qmd`
dokumentiert. Im Thesis-Template steht diese
Übersicht nach dem Literaturverzeichnis und vor der abschließenden
Eigenständigkeitserklärung:

```text
Literaturverzeichnis
Übersicht eingesetzter KI-Werkzeuge
gegebenenfalls Anhang
Eigenständigkeitserklärung
```

Die mitgelieferte Markdown-Tabelle erfasst Werkzeug, Anbieter beziehungsweise
Version, Einsatzbereich, Art der Nutzung und betroffene Teile der Arbeit. Die
Beispielzeile muss durch die tatsächlichen Angaben ersetzt werden. Wurde keine
KI verwendet, wird dies ausdrücklich vermerkt.

Die HCW-Leitlinien verlangen eine transparente Kennzeichnung und
zusammenfassende Auflistung eingesetzter KI-Werkzeuge. Das konkrete Format ist
mit den Vorgaben des jeweiligen Studiengangs abzugleichen. Maßgeblich sind der
[Leitfaden für wissenschaftliche Arbeiten](https://portal.hcw.ac.at/webservices/portaltoenabler/enablergetdocument.aspx?id=1982)
und der
[Leitfaden zum Einsatz von KI in der Lehre](https://portal.hcw.ac.at/webservices/portaltoenabler/enablergetdocument.aspx?id=2486).

## Gemeinsames HCW-Format

In `_quarto.yml` wird nicht mehr Quartos allgemeines `pdf`-Format, sondern das
gemeinsame Format `hcw-pdf` verwendet:

```yaml
format:
  hcw-pdf:
    documentclass: scrreprt
    toc: false
    number-sections: true
```

`toc: false` deaktiviert nur Quartos automatische Platzierung direkt nach der
Titelseite. Das Inhaltsverzeichnis selbst wird bewusst später über
`frontmatter/de/inhaltsverzeichnis.qmd` beziehungsweise
`frontmatter/en/table-of-contents.qmd` eingefügt, damit zuvor Danksagung,
Kurzfassung und englischer Abstract erscheinen.

Die zentrale Quelle ist das öffentliche Repository
[FH-Campus-Wien/hcw-quarto-format](https://github.com/FH-Campus-Wien/hcw-quarto-format).
Dieses Thesis-Template enthält eine geprüfte Kopie unter
`_extensions/FH-Campus-Wien/hcw/`. Dadurch benötigt ein Build keinen Zugriff
auf GitHub und eine spätere Änderung des zentralen Formats verändert eine
bestehende Abschlussarbeit nicht unbemerkt.

Das gemeinsame Format liefert derzeit:

- HCW-Logo und eine gemeinsame Standard-Titelseite für andere Dokumentarten
- TeX Gyre Heros als frei verfügbare Helvetica-Alternative
- Farben, Seitenränder, Überschriften und Beschriftungen
- gemeinsame Kopfzeilen- und PDF-Grundeinstellungen

Thesis-spezifisch bleiben `scrreprt`, Kapitelstruktur, Verzeichnisse,
eineinhalbfacher Zeilenabstand, die für Abschlussarbeiten angepasste Kopfzeile
und die offizielle BA-/MA-Titelseite. `template/title.tex` überschreibt deshalb
nur in diesem Repository die allgemeine Titelseite des gemeinsamen Formats.
Diese Ergänzungen stehen in `_quarto.yml` und unter `template/`. Damit bleibt
die Trennung klar: allgemeines Hochschuldesign im Format-Repository,
inhaltsspezifische Regeln im Thesis-Template.

Die Quarto-Format-Extension ist nicht mit der gleichnamigen
VS-Code-Erweiterung zu verwechseln. Die VS-Code-Erweiterung unterstützt das
Bearbeiten von `.qmd`-Dateien; `hcw-pdf` bestimmt die PDF-Gestaltung innerhalb
des Docker-Containers.

Normaler Inhalt wird als Markdown geschrieben:

```markdown
# Einleitung

Das ist ein Absatz mit einer Quelle [@mustermann2025].

## Forschungsfrage

Welche Auswirkungen hat ...?
```

### LaTeX für Sonderfälle

Normaler Inhalt sollte in Markdown geschrieben werden. Dadurch bleiben
Quelldateien lesbar und Quarto kann Nummerierung, Querverweise und andere
Ausgabeformate korrekt verarbeiten. Direktes LaTeX ist für einzelne
PDF-spezifische Layoutanforderungen vorgesehen, die sich mit Markdown nicht
sinnvoll ausdrücken lassen.

#### LaTeX innerhalb eines Absatzes

Raw-LaTeX kann mit der Pandoc-Attributsyntax in einen Markdown-Absatz
eingebettet werden:

```markdown
Der Begriff `\textsc{Versuchsaufbau}`{=latex} wird in Kapitälchen gesetzt.
```

Für Fett- oder Kursivschrift ist weiterhin normales Markdown vorzuziehen:

```markdown
Dieser Text ist **fett** und dieser Text ist *kursiv*.
```

#### LaTeX-Blöcke

Mehrzeiliges LaTeX steht in einem Raw-LaTeX-Block:

````markdown
```{=latex}
\begin{center}
  \fbox{
    \parbox{0.75\textwidth}{
      Dieser Kasten wird direkt von LaTeX gesetzt.
    }
  }
\end{center}
```
````

Auch ein erzwungener Seitenumbruch kann so geschrieben werden:

````markdown
```{=latex}
\newpage
```
````

#### Zusätzliche LaTeX-Pakete

Zusätzliche Pakete werden nicht in einer `.qmd`-Datei und nicht unter
`_extensions/` eingetragen. Thesis-spezifische Pakete gehören in
`template/preamble.tex`:

```latex
\usepackage{pdflscape}
```

`pdflscape` ist in dieser Vorlage bereits eingebunden und im Builder-Image
vorhanden. Damit kann beispielsweise eine breite Tabelle auf einer
Querformatseite gesetzt werden:

````markdown
```{=latex}
\begin{landscape}
\begin{center}
\begin{tabular}{llllll}
\toprule
Messung & Spannung & Strom & Leistung & Temperatur & Status \\
\midrule
A & 5 V & 20 mA & 100 mW & 23 °C & gültig \\
B & 12 V & 15 mA & 180 mW & 25 °C & gültig \\
\bottomrule
\end{tabular}
\end{center}
\end{landscape}
```
````

Ein `\usepackage{...}`-Eintrag kann nur ein Paket laden, das bereits im
versionierten Builder-Image installiert ist. Meldet LaTeX
`File ... .sty not found`, muss das Paket kontrolliert in den
`hcw-document-builder` aufgenommen werden. Eine Installation während eines
normalen Builds ist wegen der Offline- und Reproduzierbarkeitsanforderungen
nicht vorgesehen.

Raw-LaTeX wird nur in der PDF-Ausgabe verarbeitet. Bei einer späteren
HTML-Ausgabe wird solcher Inhalt nicht automatisch in HTML übersetzt. Außerdem
liegen Raw-LaTeX-Tabellen und -Abbildungen außerhalb von Quartos automatischem
Querverweissystem. Wenn `@tbl-...`- oder `@fig-...`-Verweise benötigt werden,
sollten deshalb möglichst die dokumentierten Markdown-Varianten verwendet
werden.

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

Kapitel sollten nur in den Dateien beginnen, die im gewählten Sprachprofil
`_quarto-de.yml` oder `_quarto-en.yml` unter `book.chapters` eingetragen sind.

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

Komplexere Formeln verwenden dieselbe LaTeX-Schreibweise. Ein gewichteter
Mittelwert mit Summen im Zähler und Nenner wird beispielsweise so geschrieben:

```markdown
$$
\bar{x}_w
=
\frac{\displaystyle\sum_{i=1}^{n} w_i x_i}
     {\displaystyle\sum_{i=1}^{n} w_i}
$$ {#eq-gewichteter-mittelwert}
```

Mit `aligned` lassen sich mehrere zusammengehörige Formelzeilen am
Gleichheitszeichen ausrichten. Das folgende Beispiel kombiniert mehrere
Brüche, Integrale und eine Summe:

```markdown
$$
\begin{aligned}
a_n
&=
\frac{2}{L}
\int_{0}^{L}
f(x)\cos\left(\frac{2\pi n x}{L}\right)
\,\mathrm{d}x,
\\
b_n
&=
\frac{2}{L}
\int_{0}^{L}
f(x)\sin\left(\frac{2\pi n x}{L}\right)
\,\mathrm{d}x,
\\
f_N(x)
&=
\frac{a_0}{2}
+
\sum_{n=1}^{N}
\left[
a_n\cos\left(\frac{2\pi n x}{L}\right)
+
b_n\sin\left(\frac{2\pi n x}{L}\right)
\right].
\end{aligned}
$$ {#eq-fourier-approximation}
```

Diese zusätzlichen Syntaxbeispiele ergänzen die Formeln aus den offiziellen
V1-Vorlagen. Deren gerenderte Beispiele mit deutschen und englischen
Erklärungen stehen in `chapters/de/03-methodik.qmd` beziehungsweise
`chapters/en/03-methodology.qmd`.

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

Vom Projektstamm wird ein Bild so eingebunden:

```markdown
![Generisches Microcontroller-Entwicklungsboard](images/microcontroller.png){#fig-microcontroller width=75% fig-alt="Grüne Leiterplatte mit einem zentralen Microcontroller und elektronischen Bauteilen"}
```

Aus einer Datei in `chapters/de/` oder `chapters/en/` führt der relative Pfad
zwei Ebenen nach oben:

```markdown
![Generisches Microcontroller-Entwicklungsboard](../../images/microcontroller.png){#fig-microcontroller width=75% fig-alt="Grüne Leiterplatte mit einem zentralen Microcontroller und elektronischen Bauteilen"}
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

Das zusätzliche Beispielbild liegt unter `images/microcontroller.png` und
kann mit dem gezeigten Code eingebunden werden. Die tatsächlich gerenderten
V1-Bildbeispiele in `chapters/de/04-ergebnisse.qmd` und
`chapters/en/04-results.qmd` verwenden `images/v1/`.
Bilddateien sollten aussagekräftige Namen ohne Leerzeichen besitzen. Groß-
und Kleinschreibung muss mit dem Pfad im Markdown exakt übereinstimmen.

### Querverweise

Labels müssen innerhalb der ausgewählten Sprachfassung eindeutig sein. Die
parallele deutsche und englische Vorlage dürfen dieselben Labels verwenden,
weil immer nur eine Fassung geladen wird. Die Präfixe bestimmen den Typ des
referenzierten Elements:

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

Das Literaturverzeichnis wird automatisch in
`backmatter/de/literaturverzeichnis.qmd` beziehungsweise
`backmatter/en/bibliography.qmd` erzeugt. Die Datei steht in der Kapitelliste
des jeweiligen Sprachprofils an der gewünschten Position.

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

Die Datei `backmatter/de/literaturverzeichnis.qmd` beziehungsweise
`backmatter/en/bibliography.qmd` enthält den Platzhalter für alle im Text verwendeten
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

Nur das erstmalige Laden des Builder-Images benötigt Internet. Danach sind
Quarto, Pandoc, TeX Live und die benötigten Pakete lokal in Docker gespeichert;
PDF-Build und Vorschau funktionieren ohne Netzwerkverbindung.

Ein vorbereitetes Image lässt sich für vollständig offline arbeitende Rechner
exportieren:

```shell
docker save --output hcw-document-builder-1.3.0.tar ghcr.io/fh-campus-wien/hcw-document-builder:1.3.0
```

Import auf dem Zielrechner:

```shell
docker load --input hcw-document-builder-1.3.0.tar
```

Das geladene Image behält seinen vollständigen Namen und Versions-Tag. Die
mitgelieferten VS-Code-Tasks funktionieren deshalb anschließend unverändert.

## Fehlerbehebung

### Docker ist nicht erreichbar

Docker Desktop starten und prüfen:

```shell
docker version
```

### Port 4242 ist belegt

Links vom Doppelpunkt einen anderen Port verwenden, beispielsweise
`--publish 127.0.0.1:4243:4242`, und danach
<http://localhost:4243/abschlussarbeit.pdf> öffnen.

### Builder-Image erneut laden

```shell
docker pull ghcr.io/fh-campus-wien/hcw-document-builder:1.3.0
```

Der Befehl ist normalerweise nicht nötig. Er prüft, ob das gepinnte Image lokal
vorhanden ist, und lädt fehlende Layer erneut. Ein lokaler Image-Build ist für
dieses Template nicht vorgesehen.

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
- **Quarto** liest `_quarto.yml` und das gewählte Sprachprofil, verbindet die
  Kapitel in der festgelegten Reihenfolge und steuert die Konvertierung.
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
setup.tex
      │
      ├── scripts/thesis.sh
      └── _quarto-de.yml oder _quarto-en.yml
               │
               ▼
_quarto.yml
      │
      ├── index.qmd (technische Startdatei)
      ├── chapters/de/*.qmd oder chapters/en/*.qmd
      ├── frontmatter/ und backmatter/ der gewählten Sprache
      ├── references.bib
      ├── _extensions/FH-Campus-Wien/hcw/
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

Beim Rendern führt die Toolchain sinngemäß diese Aufgaben aus:

1. `scripts/thesis.sh` liest die Arbeitssprache aus `setup.tex`.
2. Das passende Quarto-Sprachprofil `de` oder `en` aktivieren.
3. `_quarto.yml` und die Kapitelliste des aktiven Sprachprofils einlesen.
4. Alle Kapitel in der angegebenen Reihenfolge zusammenführen.
5. Markdown, Querverweise und Zitationen verarbeiten.
6. Ein temporäres LaTeX-Dokument erzeugen.
7. Gemeinsames HCW-Format, `setup.tex` und `template/preamble.tex` einbinden.
8. LuaLaTeX so oft ausführen, wie es für Verzeichnisse und Referenzen nötig ist.
9. Die fertige PDF im Verzeichnis `build/` ablegen.

Die temporäre `.tex`-Datei wird standardmäßig nicht behalten. Für die Analyse
von LaTeX-Problemen kann in `_quarto.yml` vorübergehend Folgendes gesetzt werden:

```yaml
format:
  hcw-pdf:
    keep-tex: true
```

### Rolle des Docker-Images

Das Builder-Image wird unabhängig von diesem Dokument-Template im öffentlichen
Repository
[FH-Campus-Wien/hcw-document-builder](https://github.com/FH-Campus-Wien/hcw-document-builder)
gepflegt. Darin befinden sich eine festgelegte Quarto-Version sowie TeX Live
und die benötigten LaTeX-Pakete. Bei jedem Image-Build wird bereits ein kleines
PDF als Smoke-Test gerendert. Dadurch fällt eine unvollständige LaTeX-Umgebung
vor der Veröffentlichung auf und nicht erst während der Arbeit an einem
Kapitel.

Freigegebene Versionen werden als öffentliches Container-Image auf GitHub
Container Registry veröffentlicht. Dieses Template verwendet bewusst die
vollständige Version
`ghcr.io/fh-campus-wien/hcw-document-builder:1.3.0` und nicht `latest`. Ein
Update der zentralen Toolchain verändert bestehende Arbeiten daher nicht
unbemerkt.

Beim späteren `docker run` wird das Projekt nicht in den Container kopiert. Das
aktuelle Verzeichnis wird als sogenannter Bind Mount unter `/work` eingebunden:

```text
Projekt auf dem Host  <── Bind Mount ──>  /work im Container
```

Der Container liest dadurch die aktuellen `.qmd`-Dateien und schreibt die PDF
direkt zurück in den lokalen Ordner `build/`. Nach dem Build wird der Container
durch `--rm` entfernt; das Docker-Image und alle Projektdateien bleiben erhalten.

### Warum funktioniert der Build offline?

Der erste `docker pull` beziehungsweise `docker run` benötigt Internet, um das
fertige Builder-Image herunterzuladen. Danach befinden sich alle Programme und
Pakete im lokalen Image. `docker run` verwendet diese lokale Kopie und benötigt
für normale PDF-Builds keine Netzwerkverbindung.

Die Reproduzierbarkeit entsteht durch den fest angegebenen Image-Tag `1.3.0`.
Eine neue Quarto-Version oder geänderte LaTeX-Pakete werden zuerst im separaten
Builder-Repository getestet und als neue Version veröffentlicht. Erst danach
wird ein Template bewusst auf diese neue Version umgestellt und erneut als PDF
getestet.

### Builder-Version im Template aktualisieren

Eine neue Builder-Version wird nicht automatisch übernommen. Für ein geplantes
Update sind folgende Schritte erforderlich:

1. Den neuen Release im Builder-Repository samt Smoke-Test veröffentlichen.
2. Den vollständigen Image-Tag in `.vscode/tasks.json` und in den
   Betriebssystem-Beispielen dieser README gemeinsam ändern.
3. PDF-Erzeugung, Vorschau, Vorschau-Neustart und Offline-Build testen.
4. Die Template-Änderung als eigene, nachvollziehbare Version veröffentlichen.

### HCW-Format im Template aktualisieren

Auch das gemeinsame Quarto-Format wird nicht automatisch übernommen. Der
aktuell eingebundene Release-Tag steht in `hcw-format-version.txt`. Ein Update
ist ausschließlich für Vorlagenbetreuer:innen vorgesehen:

1. Im Repository `hcw-quarto-format` eine neue Version testen und mit einem Tag
   wie `v0.2.0` veröffentlichen.
2. In `hcw-format-version.txt` denselben Tag eintragen.
3. In VS Code den Task `Maintainer: HCW-Format aktualisieren` ausführen.
4. Die Änderungen unter `_extensions/FH-Campus-Wien/hcw/` mit `git diff`
   kontrollieren.
5. `Thesis: PDF erstellen` ausführen und die vollständige PDF visuell prüfen.
6. Versionsdatei und aktualisierte Extension gemeinsam committen.

Der Maintainer-Task ruft im Builder-Container das Skript
`scripts/update-hcw-format.sh` auf. Dieses installiert den angegebenen
Release, prüft Manifest, Version, Logo und LaTeX-Partials und bricht bei einer
unvollständigen Extension ab. Nur dieser bewusste Aktualisierungsschritt
benötigt Netzwerkzugriff; Schreiben, PDF-Erstellung und Vorschau bleiben
offlinefähig.

## Hinweis zur Erstellung

Diese Dokumentvorlage wurde mit Unterstützung von ChatGPT SOL 5.6 erstellt und
weiterentwickelt. Alle Inhalte und technischen Entscheidungen wurden von den
Projektverantwortlichen geprüft.
