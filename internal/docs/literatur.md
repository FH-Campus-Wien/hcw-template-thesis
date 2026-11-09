# Literatur und Zitate mit BibTeX

[← Quick Start und Inhaltsverzeichnis](../../README.md)

Dateipfade beziehen sich auf den Projektstamm. Terminalbefehle werden dort ausgeführt.

Alle Literaturangaben werden zentral in `content/references.bib` gespeichert. Die Datei
verwendet das BibTeX-Format und kann manuell bearbeitet oder aus einer
Literaturverwaltung wie Zotero exportiert werden.

Die Datei ist in `_quarto.yml` eingebunden:

```yaml
bibliography: content/references.bib
```

Das Literaturverzeichnis wird automatisch in
`content/backmatter/de/literaturverzeichnis.qmd` beziehungsweise
`content/backmatter/en/bibliography.qmd` erzeugt. Die Datei steht in der Kapitelliste
des jeweiligen Sprachprofils an der gewünschten Position.

## BibTeX-Einträge anlegen

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

## In Markdown zitieren

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
`content/references.bib` übereinstimmen. Groß- und Kleinschreibung sollte ebenfalls
beibehalten werden.

## Literaturverzeichnis

Die Datei `content/backmatter/de/literaturverzeichnis.qmd` beziehungsweise
`content/backmatter/en/bibliography.qmd` enthält den Platzhalter für alle im Text verwendeten
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

Mit `@*` werden alle Einträge aus `content/references.bib` aufgenommen:

```yaml
---
nocite: |
  @*
---
```

## Verarbeitung und Zitierstil

`content/references.bib` ist eine normale BibTeX-Datei. Die Zitate werden in dieser
Vorlage von Pandoc Citeproc verarbeitet; Studierende müssen `bibtex` oder
`biber` nicht selbst aufrufen. Die komplette Verarbeitung erfolgt beim normalen
Docker-Build.

Ein verbindlicher Zitierstil kann später als CSL-Datei in das Projekt gelegt
und in `_quarto.yml` aktiviert werden:

```yaml
bibliography: content/references.bib
csl: citation-style.csl
```

Ohne CSL-Datei verwendet Quarto den voreingestellten Zitierstil.

## Export aus Zotero

In Zotero können ausgewählte Quellen oder eine ganze Sammlung über
**Exportieren → BibTeX** ausgegeben werden. Die exportierte Datei wird als
`content/references.bib` im Projekt gespeichert. Bereits vorhandene manuelle Einträge
sollten vor dem Ersetzen gesichert oder in Zotero übernommen werden.

Nach Änderungen wird die PDF wie gewohnt mit `Ctrl+Shift+B` in VS Code oder mit
dem dokumentierten `docker run`-Befehl neu erstellt.

## Häufige Fehler

- `citeproc: citation ... not found`: Der Schlüssel fehlt in `content/references.bib`
  oder ist anders geschrieben.
- Eine Quelle fehlt im Literaturverzeichnis: Sie wurde nicht zitiert und nicht
  über `nocite` aufgenommen.
- Namen werden falsch dargestellt: Personen mit `and` trennen; Institutionen
  in doppelte geschweifte Klammern setzen.
- Sonderzeichen sind beschädigt: `content/references.bib` als UTF-8 speichern.
- Änderungen erscheinen nicht: PDF erneut bauen und die Ausgabe im Ordner
  `build/` kontrollieren.

[Zurück zum Inhaltsverzeichnis](../../README.md#inhaltsverzeichnis)
