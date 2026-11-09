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

## Titelseite für Bachelor- und Masterarbeiten

Die Titelseite folgt den offiziellen Word-Vorlagen für Bachelor- und
Masterarbeiten. Sie enthält das HCW-Logo, das helle Linienmotiv, den deutschen
und englischen Titel, Autor:in, akademischen Grad, Studiengang und Betreuung.
Die Grundeinstellungen werden am Anfang von `setup.tex` gewählt:

```latex
\newcommand{\HCWLanguage}{de}    % de oder en
\newcommand{\HCWThesisLevel}{ba} % ba oder ma
\newcommand{\HCWTextAlignment}{blocksatz} % blocksatz oder flattersatz
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

- `blocksatz`: links und rechts bündige Zeilen; das ist die Voreinstellung.
- `flattersatz`: linksbündige Zeilen mit offenem rechten Rand.

Für Flattersatz wird die vorhandene Zeile so geändert:

```latex
\newcommand{\HCWTextAlignment}{flattersatz}
```

Die Silbentrennung bleibt auch im Flattersatz möglich. Dafür wird das im
Builder bereits vorhandene LaTeX-Paket `ragged2e` verwendet. Die Titelseite
bleibt linksbündig; Tabellen, Formeln und Bild-/Tabellenbeschriftungen behalten
ihre gesonderten Ausrichtungseinstellungen.

Nach der Änderung die PDF mit `Thesis: PDF erstellen` neu bauen oder die
laufende Vorschau stoppen und neu starten. Änderungen an `setup.tex` lösen
derzeit noch keinen automatischen Neubau der Vorschau aus.

## Bilder, Formeln und Erklärungen aus den V1-Vorlagen

Die Inhaltsbeispiele wurden mit allen vier V1-Dateien verglichen. Bachelor-
und Mastervorlage verwenden dieselben mathematischen Beispiele und Bilder.
Die Erläuterungen und Bildunterschriften erscheinen passend zu
`HCWLanguage` auf Deutsch oder Englisch. Die Auswahl `ba`/`ma` verwendet
dieselben Beispiele mit der passenden Titelseite und Abschlussbezeichnung.

| Datei | Beispiele |
|---|---|
| `content/chapters/de/03-methodik.qmd` oder `content/chapters/en/03-methodology.qmd` | Fourier-Transformation und inverse Transformation, lineares Gleichungssystem, ausgerichtete Spannungsgleichungen, Logarithmusreihe mit Summen und Brüchen |
| `content/chapters/de/04-ergebnisse.qmd` oder `content/chapters/en/04-results.qmd` | Magnetron-Sputtern, kleines Grafikbeispiel, zwei Teilabbildungen, Cosinussignal mit Periodendauer, Kontrastvergleich sowie Tabellen und Querformat |
| `content/images/v1/` | neun gemeinsam verwendete Bilddateien aus den vier Referenzen |
| `content/references.bib` | die fünf Quellen der übernommenen V1-Beispiele |

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

Herkunft und Prüfsummen sind unter `content/images/v1/README.md` und
`content/images/v1/manifest.json` dokumentiert. Das dort beschriebene
`internal/scripts/import-v1-images.py` ist ein optionales Werkzeug für
Vorlagenbetreuer:innen; für das Schreiben ist keine Extraktion erforderlich.

Die deutschen und englischen Erklärungen stehen in getrennten Dateien unter
`content/chapters/de/` und `content/chapters/en/`. Formeln und Bildunterschriften werden in der
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

## Vorspann (Front Matter)

Nach der Titelseite folgt dieselbe Grundreihenfolge wie in den
Referenzvorlagen. In der deutschen Variante lautet sie:

1. `content/frontmatter/de/danksagung.qmd`: Danksagung
2. `content/frontmatter/kurzfassung.qmd`: deutsche Kurzfassung
3. `content/frontmatter/abstract.qmd`: englischer Abstract
4. `content/frontmatter/de/abkuerzungsverzeichnis.qmd`: optionales
   Abkürzungsverzeichnis
5. `content/frontmatter/de/inhaltsverzeichnis.qmd`: Inhaltsverzeichnis

In der englischen Variante werden `Acknowledgements` und `Abstract` zuerst
ausgegeben; danach folgen die deutsche `Kurzfassung`, `List of Abbreviations`
und `Table of Contents`. Die englischen Dateien liegen unter
`content/frontmatter/en/`; Kurzfassung und Abstract werden von beiden Varianten
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
unter `content/backmatter/de/eigenstaendigkeitserklaerung.qmd` beziehungsweise
`content/backmatter/en/declaration.qmd` und steht am Ende der jeweiligen Kapitelliste.
Ein allfälliger Anhang wird ebenfalls vor der Eigenständigkeitserklärung eingereiht.

## Dokumentation eingesetzter KI-Werkzeuge

Die Nutzung von KI-Werkzeugen ist kein Bestandteil des Vorspanns und keine
Gestaltungsregel des gemeinsamen Quarto-Formats. Sie wird als inhaltlicher
Bestandteil der jeweiligen Arbeit unter
`content/backmatter/de/ki-werkzeuge.qmd` beziehungsweise `content/backmatter/en/ai-tools.qmd`
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

[Zurück zum Inhaltsverzeichnis](../../README.md#inhaltsverzeichnis)
