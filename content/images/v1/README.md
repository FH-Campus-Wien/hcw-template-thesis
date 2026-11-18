# Abbildungen aus den offiziellen V1-Vorlagen

Die vier ursprünglichen BA-/MA-Vorlagen für Deutsch und Englisch enthalten
dieselben neun Bilddateien für die Inhaltsbeispiele. Diese Bilder werden hier
gemeinsam gepflegt. Die Word-Dateien werden nicht mehr mit dem Repository
ausgeliefert und bleiben bei den Vorlagenbetreuer:innen nur lokal vorhanden.
`manifest.json` dokumentiert die ursprünglichen Quelldateien, OOXML-Paketpfade
und SHA-256-Prüfsummen; die Quellpfade sind Herkunftsnachweise, keine
Dateiverweise innerhalb eines neuen Klons.

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

Das bisherige Extraktionsskript `internal/scripts/import-v1-images.py`
bleibt ebenfalls nur lokal bei den Vorlagenbetreuer:innen und gehört nicht
zum ausgelieferten Template. Seine zusätzlichen Werkzeuge (Python mit Pillow
und pypdf, LibreOffice und Poppler) sind nur für eine erneute Extraktion nötig.
Normale Docker-Builds verwenden die hier enthaltenen fertigen Bilder und
benötigen weder das Skript noch die Word-Dateien oder diese Zusatzprogramme.

## Hinweis zur Erstellung

Diese Dokumentvorlage wurde ursprünglich mit Unterstützung von
ChatGPT SOL 5.6 erstellt. Die bereitgestellten
V1-Referenzdateien sind die Quelle der hier verwendeten Originalbilder.
