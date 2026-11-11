# Abbildungen aus den offiziellen V1-Vorlagen

Die vier BA-/MA-Vorlagen für Deutsch und Englisch unter `internal/requirements/`
enthalten dieselben neun Bilddateien für die Inhaltsbeispiele. Sie werden hier
gemeinsam gepflegt. `manifest.json` dokumentiert die Quelldateien,
OOXML-Paketpfade und SHA-256-Prüfsummen.

| Datei | Verwendung |
|---|---|
| `magnetron-sputtern.png` | Magnetron-Sputterprozess, Quelle Hishimone et al. (2020) |
| `buecher.png` | kleines Grafikbeispiel zur Einbindung und Beschriftung |
| `fertigungsstrasse.jpeg` | Teilabbildung einer Fertigungsstraße, Quelle HCW |
| `3d-druck-stuetzmaterial.jpeg` | Teilabbildung eines 3D-Drucks, Quelle HCW |
| `sinussignal.pdf` | Signaldiagramm mit Amplitude, Periode und Phase |
| `kontrast-schlecht.png` | Kontrastbeispiel auf dunklem Hintergrund |
| `kontrast-gut.png` | dasselbe Diagramm auf hellem Hintergrund |
| `dft-fft-aufwand.pdf` | als Grafik importierte Tabelle zum Rechenaufwand |
| `wahrscheinlichkeitsverteilungen.pdf` | große Tabelle für eine Querformatseite |

Rasterdateien wurden bytegetreu extrahiert. Die drei EMF-Dateien wurden mit
LibreOffice in Vektor-PDFs konvertiert; anschließend wurden ausschließlich die
weißen Seitenränder entfernt. Bildinhalte und eingebettete Beschriftungen
bleiben so erhalten wie in den Referenzen. Die sichtbaren Bildunterschriften
und Erläuterungen werden durch `setup.tex` auf Deutsch oder Englisch gewählt.

Die Referenzen nennen für das Bücherbild, das Signaldiagramm, die beiden
Kontrastbilder und die Tabellen keine zusätzliche externe Quelle. Deren
Herkunft ist hier deshalb ausdrücklich die bereitgestellte V1-Vorlage.

In der Verteilungsübersicht fehlt beim Varianzsymbol der Gleichverteilung
das Quadrat.
Die Originalgrafik bleibt erhalten; „Hinweise zu Latex“ am Ende des ersten
Kapitels erläutert die korrekte Schreibweise in beiden Sprachen.

Vorlagenbetreuer:innen können die Extraktion mit
`internal/scripts/import-v1-images.py` wiederholen. Dafür werden Python mit Pillow und
pypdf sowie LibreOffice und Poppler benötigt; die Pfade können mit
`--soffice` und `--pdftoppm` angegeben werden. Diese Programme werden für
normale Docker-Builds nicht zusätzlich benötigt.

## Hinweis zur Erstellung

Diese Dokumentvorlage wurde ursprünglich mit Unterstützung von
ChatGPT SOL 5.6 erstellt. Die bereitgestellten
V1-Referenzdateien sind die Quelle der hier verwendeten Originalbilder.
