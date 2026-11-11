# Projektstruktur und Konfiguration

[← Quick Start und Inhaltsverzeichnis](../../README.md)

Dateipfade beziehen sich auf den Projektstamm. Terminalbefehle werden dort ausgeführt.

## Ordnerstruktur und Arbeitsdateien

Die Arbeitsdateien und die interne Technik sind bewusst getrennt. Zum Schreiben
werden hauptsächlich `content/`, `setup.tex` und die persönlichen Angaben in
`_quarto.yml` benötigt. Die Dateien unter `internal/` werden normalerweise
nicht bearbeitet; einige davon werden aber bei jedem Build benötigt und dürfen
deshalb nicht gelöscht werden.

```text
hcw-template-thesis/
├── README.md
├── setup.tex                   Sprache, Abschlussart und Textausrichtung
├── content/                    eigene Inhalte
│   ├── chapters/
│   │   ├── de/                 deutsche Kapitel
│   │   └── en/                 englische Kapitel
│   ├── frontmatter/
│   │   ├── de/                 deutscher Vorspann
│   │   ├── en/                 englischer Vorspann
│   │   ├── kurzfassung.qmd     deutsche Zusammenfassung
│   │   └── abstract.qmd        englische Zusammenfassung
│   ├── backmatter/
│   │   ├── de/                 deutscher Nachspann
│   │   └── en/                 englischer Nachspann
│   ├── images/                 Abbildungen beider Sprachfassungen
│   └── references.bib          gemeinsame BibTeX-Literaturdatenbank
├── internal/                   interne Technik und Referenzen
│   ├── README.md               Überblick für Vorlagenbetreuer:innen
│   ├── scripts/                Build, Vorschau und Wartungswerkzeuge
│   ├── latex/                  Titelseite, Präambel und Hintergrundbild
│   ├── requirements/           offizielle Word-Referenzvorlagen
│   ├── docs/ROADMAP.md          Schritte bis zum stabilen Template v1.0.0
│   └── hcw-format-version.txt  übernommener Release-Tag des HCW-Formats
├── build/                      erzeugte PDF und weitere Ausgaben
├── _quarto.yml                 Titelseitenangaben und PDF-Einstellungen
├── _quarto-de.yml              deutsche Kapiteldateien und Reihenfolge
├── _quarto-en.yml              englische Kapiteldateien und Reihenfolge
├── index.qmd                   technische Startdatei des Quarto-Buchs
├── _extensions/                lokale Kopie des gemeinsamen HCW-Formats
├── .vscode/                    Editor-Einstellungen und Docker-Tasks
├── .gitattributes              einheitliche Zeilenenden für Git
└── .gitignore                  nicht zu versionierende generierte Dateien
```

Die Quarto-Konfigurationen, `index.qmd` und `_extensions/` bleiben an den
vorgesehenen Stellen im Projektstamm. Der versteckte Ordner `.quarto/` wird von
Quarto automatisch als Arbeitsverzeichnis angelegt; `build/` enthält die
fertigen Ausgaben. Beide gehören nicht in Git.

`.gitattributes` bleibt ebenfalls im Projektstamm: Sie sorgt insbesondere
dafür, dass Shell-Skripte auch nach einem Checkout unter Windows die für den
Linux-Container passenden `LF`-Zeilenenden haben. `.gitignore` hat eine andere
Aufgabe: Sie hält zum Beispiel generierte PDFs und Quarto-Zwischendateien aus
der Versionsverwaltung heraus.

Bearbeiten Sie ausschließlich die Dateien Ihrer Arbeitssprache:

| Auswahl in `setup.tex` | Kapitel bearbeiten | Vorspann und Nachspann |
|---|---|---|
| `\HCWLanguage` = `de` | `content/chapters/de/` | `content/frontmatter/de/` und `content/backmatter/de/` |
| `\HCWLanguage` = `en` | `content/chapters/en/` | `content/frontmatter/en/` und `content/backmatter/en/` |

Jede Kapiteldatei enthält nur eine Sprache. Überschriften, Erläuterungen und
Bildunterschriften werden direkt in dieser Datei bearbeitet. Die jeweils
andere Sprachfassung muss für eine eigene Arbeit nicht mitgepflegt werden.
Gemeinsam bleiben die Bilder unter `content/images/`, die Literaturdatenbank und die
zwei ausdrücklich vorgeschriebenen Zusammenfassungen: `content/frontmatter/kurzfassung.qmd`
und `content/frontmatter/abstract.qmd`.

Neue Kapitel werden in der Kapitelliste `book.chapters` des passenden Profils
`_quarto-de.yml` beziehungsweise `_quarto-en.yml` eingetragen. `index.qmd` im
Projektstamm bleibt als technische Startdatei bestehen; die Danksagung steht
in `content/frontmatter/de/danksagung.qmd` beziehungsweise
`content/frontmatter/en/acknowledgements.qmd`.
Diese beiden Dateien enthalten den Text der Danksagung. Die gemeinsame
Startdatei setzt die Überschrift aus `acknowledgements-title` im jeweiligen
Sprachprofil darüber.

## Seitenränder und Fließtext nach den V1-Vorlagen

Die vier verbindlichen V1-Word-Vorlagen unter `internal/requirements/`
verwenden dieselben Einstellungen. Die Titelseite hat ein eigenes Layout;
für die folgenden Seiten gilt:

| Abschnitt | Oben | Rechts | Unten | Links |
|---|---:|---:|---:|---:|
| Vorspann, einschließlich Inhaltsverzeichnis | 25 mm | 25 mm | 20 mm | 25 mm |
| Haupttext mit nummerierten Kapiteln | 25 mm | 25 mm | 25 mm | 25 mm |
| Nachspann ab Literaturverzeichnis | 25 mm | 25 mm | 20 mm | 25 mm |

Der normale Fließtext übernimmt die Word-Formatvorlage `Standard`:

- Schriftgröße: 12 pt, weiterhin mit TeX Gyre Heros als freier Schriftalternative.
- Zeilenabstand: 1,25-fach (`w:spacing`, `line="300"`, `lineRule="auto"`).
- Absatzabstand danach: 8 pt (`after="160"`); kein Erstzeileneinzug.

Einzelne erste oder letzte Absatzzeilen werden nicht allein auf einer Seite
platziert.

Kopf- und Fußzeilen liegen außerhalb des Textrandes. Der Randwechsel wird
automatisch vor den nummerierten Hauptkapiteln und vor den anschließenden
unnummerierten Nachspannkapiteln gesetzt. Kapitel beginnen ohne zusätzlichen
Vorabstand am oberen Textrand. Überschriften, Bildbeschriftungen, Tabellen,
Formeln und Code behalten ihre jeweiligen gesonderten Formatierungen.

Die Schriftgröße wird nur für die Thesis in `_quarto.yml` überschrieben.
Satzspiegel und Abstände stehen in `internal/latex/preamble.tex`; die
Abschnittswechsel setzt `internal/scripts/thesis-setup.lua`. Diese Werte sind
thesis-spezifisch und verändern das gemeinsame HCW-Format anderer Templates
nicht. Die Titelseite bleibt von den Fließtexteinstellungen ausgenommen.

## Titelseite für Bachelor- und Masterarbeiten

Die Titelseite folgt den offiziellen Word-Vorlagen für Bachelor- und
Masterarbeiten. Sie enthält das HCW-Logo, das helle Linienmotiv, den deutschen
und englischen Titel, Autor:in, akademischen Grad, Studiengang und Betreuung.
Die Grundeinstellungen werden am Anfang von `setup.tex` gewählt:

```latex
\newcommand{\HCWLanguage}{de}    % de oder en
\newcommand{\HCWThesisLevel}{ba} % ba oder ma
\newcommand{\HCWTextAlignment}{flattersatz} % Voreinstellung; alternativ blocksatz
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
`internal/latex/assets/hcw-thesis-title-background.jpg`. Es enthält bereits das Logo
und das Linienmotiv und wird nur auf der Titelseite eingesetzt. Die vier
V1-Word-Vorlagen unter `internal/requirements/` sind die verbindlichen Referenzen für
Deutsch/Englisch und Bachelor/Master. Sie werden zum Schreiben der
Quarto-Arbeit nicht benötigt.

## Textausrichtung: Flattersatz oder Blocksatz

Der Schalter `HCWTextAlignment` in `setup.tex` steuert die Ausrichtung des
Fließtexts, unabhängig von Sprache und Abschlussart:

- `flattersatz`: linksbündige Zeilen mit offenem rechten Rand; das ist die Voreinstellung.
- `blocksatz`: links und rechts bündige Zeilen.

Für Blocksatz wird die vorhandene Zeile so geändert:

```latex
\newcommand{\HCWTextAlignment}{blocksatz}
```

Die Silbentrennung bleibt auch im Flattersatz möglich. Dafür wird das im
Builder bereits vorhandene LaTeX-Paket `ragged2e` verwendet. Die Titelseite
bleibt linksbündig; Tabellen, Formeln und Bild-/Tabellenbeschriftungen behalten
ihre gesonderten Ausrichtungseinstellungen.

Nach der Änderung die PDF mit `Thesis: PDF erstellen` neu bauen oder die
laufende Vorschau stoppen und neu starten. Änderungen an `setup.tex` lösen
derzeit noch keinen automatischen Neubau der Vorschau aus.

## Inhalte und Kapitelstruktur aus den V1-Vorlagen

Der Originalwortlaut und die Kapitelstruktur der vier gültigen Word-Dateien
werden übernommen. Die generischen Kapitelüberschriften sind absichtliche
Platzhalter. Sie werden nicht mehr durch unsere eigene Gliederung ersetzt.
Die bisherige Aufteilung in Einleitung, Grundlagen, Methodik, Ergebnisse und
Fazit steht als Vorschlag in [Mögliche Kapitelaufteilung](../../content/chapters/README.md).

| Datei | Inhalt der offiziellen Vorlage |
|---|---|
| `content/chapters/de/01-kapitel.qmd` oder `content/chapters/en/01-chapter.qmd` | Sieben Gleichungsnummern, Zitieren und Fußnoten, Sputtern, Bilder und Teilabbildungen, Diagramme, Tabellen und Querformat |
| `content/chapters/de/02-kapitel.qmd` oder `content/chapters/en/02-chapter.qmd` | Kapitelaufteilung, Fibonacci-Programm, Kontrastvergleich und Unterabschnitte |
| `content/images/v1/` | Unveränderte Rasterbilder und in Vektor-PDFs konvertierte EMF-Grafiken |
| `content/references.bib` | Strukturierte Daten zu den fünf Originalquellen und ein zusätzliches, nicht zitiertes Syntaxbeispiel |

Die deutsche BA- und MA-Vorlage unterscheiden sich im Haupttext nur durch
„zu sehen.“ beziehungsweise „zu sehen ist.“ nach der langen Formel. Die
Blöcke `.hcw-ba` und `.hcw-ma` in der ersten deutschen Kapiteldatei werden
über den vorhandenen Schalter `HCWThesisLevel` gefiltert. Die englischen
Haupttexte sind identisch. Persönliche Titelseitenangaben bleiben editierbar.

Originale Word-Anweisungen bleiben stehen, auch wenn sie sich auf Word-Add-ins,
Tabellenrahmen oder Tastaturbefehle beziehen. Zusätzliche Hinweise zu unserer
Umsetzung folgen ausschließlich am Ende des betreffenden Kapitels unter
**Hinweise zu Latex**. Bei Bedarf stehen darunter weitere Unterabschnitte.
Auch die englische Fassung verwendet diese einheitliche Überschrift. Diese
Hinweise und die Beispielinhalte werden vor der Abgabe entfernt oder durch
eigene Inhalte ersetzt.

Für das aktuelle PDF sind Abbildungen und Tabellen wie in Word durchgehend
nummeriert; Gleichungen und Listings werden je Kapitel nummeriert. Die sieben
Gleichungsnummern werden mit LaTeX `equation` und `align` gesetzt. Das
Fibonacci-Beispiel verwendet `lstlisting` und TeX Gyre Cursor als freie
Courier-Alternative. Der Fließtext verwendet unverändert TeX Gyre Heros.
Die Einstellung `crossref.chapters: false` steht im Formatblock von
`_quarto.yml`; die LaTeX-Zähler werden in `internal/latex/preamble.tex` angepasst.

Verzeichnisse, Querverweise und Seitenzahlen werden neu erzeugt. Sie werden
nicht mit den zwischengespeicherten Zahlen aus Word gefüllt. Die Quellen
bleiben BibTeX-Einträge und werden mit `internal/csl/ieee.csl` numerisch
formatiert. Die Darstellung des Literaturverzeichnisses kann deshalb von
den gespeicherten Word-Zeilen abweichen. Dies ist keine inhaltliche Neufassung
der Vorlagentexte und keine Festlegung auf IEEE als einzig erlaubten Stil.

Die Herkunft der Grafiken ist unter `content/images/v1/README.md` und
`content/images/v1/manifest.json` dokumentiert. Die Quellen und technischen
Abweichungen der Inhaltsübernahme stehen in `internal/requirements/README.md`.

## Vorspann

Nach der Titelseite folgt in der deutschen Variante:

1. Danksagung (`content/frontmatter/de/danksagung.qmd`)
2. Kurzfassung (`content/frontmatter/kurzfassung.qmd`)
3. Abstract (`content/frontmatter/abstract.qmd`)
4. Abkürzungsverzeichnis (`content/frontmatter/de/abkuerzungsverzeichnis.qmd`)
5. Inhaltsverzeichnis (`content/frontmatter/de/inhaltsverzeichnis.qmd`)

In der englischen Variante stehen Acknowledgements und Abstract zuerst,
danach Kurzfassung, List of Abbreviations und Table of Contents. Die englischen
Dateien liegen unter `content/frontmatter/en/`. Kurzfassung und Abstract
werden gemeinsam genutzt; der englische Abstract-Platzhalter übernimmt den
passenden Originalwortlaut der deutschen beziehungsweise englischen Vorlage.

Die bisherigen freien Hinweise zum Schreiben eines Abstracts stehen nun in
der [Kapitel-README](../../content/chapters/README.md), nicht im Originaltext.
Der Vorspann verwendet römische Seitenzahlen. Mit dem ersten nummerierten
Kapitel beginnt die arabische Nummerierung bei 1.

## Nachspann

Die Reihenfolge entspricht den vier V1-Dateien:

```text
Literaturverzeichnis / Bibliography
Abbildungsverzeichnis / List of Figures
Tabellenverzeichnis / List of Tables
Listingverzeichnis / List of Listings
Übersicht verwendeter KI-Technologien / Overview of used AI Technologies
Anhang / Appendix (optional)
```

Die Dateien liegen im aktiven Sprachordner unter `content/backmatter/`.
Die Kapitellisten in `_quarto-de.yml` und `_quarto-en.yml` bestimmen ihre
Reihenfolge. Die KI-Übersicht übernimmt den Originaltext und die Beispieltabelle
aus Word. Die Beispielangaben werden durch die tatsächliche Verwendung ersetzt.

Eine Eigenständigkeitserklärung ist in keiner der vier V1-Word-Dateien
enthalten. Unser zusätzlicher Platzhalter ist deshalb aus der Vorlage entfernt.
Ob der Studiengang oder der Abgabeprozess eine gesonderte Erklärung verlangt,
muss unabhängig davon geklärt werden. Aus dem Fehlen in den Word-Dateien wird
keine Aussage über andere Abgabevorgaben abgeleitet.

[Zurück zum Inhaltsverzeichnis](../../README.md#inhaltsverzeichnis)
