# Mögliche Kapitelaufteilung

Die gerenderten Beispieldateien übernehmen die beiden generischen Kapitel der
V1-Word-Vorlagen. Deren Überschriften sind Platzhalter, keine verpflichtende
Gliederung einer fertigen Bachelor- oder Masterarbeit.

Unsere bisherige Kapitelstruktur bleibt hier als möglicher Ausgangspunkt
erhalten. Die tatsächliche Gliederung wird mit der Betreuung abgestimmt.

| Kapitel | Möglicher Inhalt | Englische Bezeichnung |
|---|---|---|
| 1 Einleitung | Problem, Motivation, Zielsetzung, Forschungsfrage und Aufbau der Arbeit | Introduction |
| 2 Grundlagen | Fachliche und theoretische Grundlagen, Stand der Technik und verwandte Arbeiten | Theoretical background |
| 3 Methodik | Vorgehen, Versuchsaufbau, Materialien, Datenerhebung und Auswertung | Methodology |
| 4 Ergebnisse | Ergebnisse, Abbildungen und Tabellen; je nach Arbeit anschließend Diskussion oder ein eigenes Diskussionskapitel | Results |
| 5 Fazit und Ausblick | Forschungsfrage beantworten, Ergebnisse einordnen, Grenzen und nächste Schritte nennen | Conclusions and outlook |

Das ist ein Vorschlag, keine zusätzliche Hochschulvorgabe. Je nach Arbeit
können beispielsweise Anforderungsanalyse, Entwurf, Implementierung,
Evaluierung und Diskussion eigene Kapitel bilden.

## Eigene Gliederung anlegen

1. Nur den gewählten Sprachordner `de/` oder `en/` bearbeiten.
2. Neue `.qmd`-Dateien mit einer Kapitelüberschrift `# ...` anlegen.
3. Die Dateien unter `book.chapters` in `_quarto-de.yml` beziehungsweise
   `_quarto-en.yml` in die gewünschte Reihenfolge bringen.
4. Abschnitts- und Unterabschnittsüberschriften mit `##` und `###` schreiben.
5. Beim Umbenennen vorhandener Überschriften die Labels und Verweise beachten.

Die aktuelle Datei `01-kapitel.qmd` beziehungsweise `01-chapter.qmd` enthält die
offiziellen Formel-, Literatur-, Bild- und Tabellenbeispiele. Die zweite
Kapiteldatei enthält Programmcode und den Kontrastvergleich. Diese Beispiele
werden für die eigene Arbeit durch eigene Inhalte ersetzt; sie werden nicht
zusätzlich als Forschungsinhalt abgegeben.

## Zusammenfassungen

Die Dateien für Kurzfassung und Abstract enthalten zunächst die Platzhalter
aus Word. Als Merkhilfe für den eigenen Text bleibt unser bisheriger Vorschlag:

> Erst das Problem und warum es ein Problem ist. Dann die Lösung und warum sie
> eine Lösung ist.

## Zusätzliche Umsetzungshinweise

Zusätzliche Erklärungen zu Markdown, Quarto und LaTeX stehen im PDF immer am
Ende des betreffenden offiziellen Kapitels unter **Hinweise zu Latex**. Bei
weiterer Unterteilung stehen darunter Unterabschnitte. Auch die englische
Fassung verwendet diese einheitliche Überschrift.

Diese Hinweise gehören nicht zum Originaltext der Word-Vorlage und werden vor
der Abgabe zusammen mit den übrigen Beispielen entfernt.

[Quick Start und Dokumentation](../../README.md)
