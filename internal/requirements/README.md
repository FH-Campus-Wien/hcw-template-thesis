# Verbindliche Inhaltsvorlagen

Für die Inhalte gelten diese vier Dateien, nicht die älteren `_03.dotx`-Dateien:

- `HCW_BA_Abschlussarbeit_deutsch_V1.dotx`
- `HCW_MA_Abschlussarbeit_deutsch_V1.dotx`
- `HCW_BA_Abschlussarbeit_englisch_V1.dotx`
- `HCW_MA_Abschlussarbeit_englisch_V1.dotx`

## Übernahme in Quarto

Kapitelüberschriften, Reihenfolge und erklärende Originaltexte einschließlich
Word-spezifischer Anweisungen sind übernommen. Deutsche und englische Texte
werden nicht neu übersetzt. BA und MA verwenden dieselben Beispiele; die
deutsche MA-Fassung endet den Absatz zur langen Formel mit „zu sehen ist.“,
die BA-Fassung mit „zu sehen.“. Der vorhandene Schalter in `setup.tex` wählt
auch diesen Wortlaut aus.

Zusätzlich gelten folgende technisch bedingte Unterschiede:

- Inhaltsverzeichnis, Verzeichnisse, Nummern und Querverweise werden neu
  berechnet. Zwischengespeicherte Word-Seitenzahlen werden nicht kopiert.
- Word-Gleichungstabellen werden durch editierbare LaTeX-Gleichungen ersetzt.
  Die sieben Gleichungsnummern und der mathematische Inhalt bleiben erhalten.
  Einheiten und Konstanten werden entsprechend dem Originaltext aufrecht gesetzt.
- Rasterbilder bleiben unverändert; EMF-Dateien liegen als Vektor-PDFs vor.
- Das Literaturverzeichnis wird weiterhin aus `content/references.bib`
  erzeugt, jetzt mit der lokal eingebundenen IEEE-CSL-Datei. Formatierung und
  strukturierte Autorenangaben können deshalb vom gespeicherten Word-Auszug
  abweichen. Die fünf Originalquellen bleiben erhalten.
- Programmcode verwendet TeX Gyre Cursor als freie Courier-Alternative;
  die bestehende Schriftalternative für den Fließtext bleibt TeX Gyre Heros.
- Persönliche Angaben auf der Titelseite bleiben editierbare Platzhalter in
  `_quarto.yml` und `setup.tex`, keine fest eingefügten Word-Textfelder.

Zusätzliche Hinweise zur Umsetzung stehen am Ende des zugehörigen Kapitels
unter **Hinweise zu Latex**. Dazu gehört auch der Hinweis zum fehlerhaften
Varianzsymbol in der unverändert übernommenen Verteilungsgrafik. Diese Hinweise
sind nicht Teil des Originalwortlauts.

Die vier Dateien enthalten keine Eigenständigkeitserklärung. Ein gesonderter
Abgabeprozess kann zusätzliche Dokumente verlangen; das wird mit dem
Studiengang geklärt und nicht aus der Abwesenheit in der Vorlage abgeleitet.

## Zitierstil

`internal/csl/ieee.csl` ist eine unveränderte Kopie des
[IEEE-Stils des Citation Style Language-Projekts](https://github.com/citation-style-language/styles/blob/master/ieee.csl)
(übernommen am 11. November 2026). Urheber:innen und die Lizenz
CC BY-SA 3.0 stehen im Kopf der Datei. Die Datei wird lokal mitgeliefert;
beim Dokument-Build ist kein Download erforderlich. Die Auswahl bildet die
numerischen Beispiele der Word-Dateien nach, sie macht IEEE nicht zur
einzig erlaubten Zitierweise.
