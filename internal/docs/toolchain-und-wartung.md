# Toolchain und Wartung (Advanced)

[← Quick Start und Inhaltsverzeichnis](../../README.md)

Dateipfade beziehen sich auf den Projektstamm. Terminalbefehle werden dort ausgeführt.

## Überblick und Versionsstand

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
`content/frontmatter/de/inhaltsverzeichnis.qmd` beziehungsweise
`content/frontmatter/en/table-of-contents.qmd` eingefügt, damit zuvor Danksagung,
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
und die offizielle BA-/MA-Titelseite. `internal/latex/title.tex` überschreibt deshalb
nur in diesem Repository die allgemeine Titelseite des gemeinsamen Formats.
Diese Ergänzungen stehen in `_quarto.yml` und unter `internal/latex/`. Damit bleibt
die Trennung klar: allgemeines Hochschuldesign im Format-Repository,
inhaltsspezifische Regeln im Thesis-Template.

Die Quarto-Format-Extension ist nicht mit der gleichnamigen
VS-Code-Erweiterung zu verwechseln. Die VS-Code-Erweiterung unterstützt das
Bearbeiten von `.qmd`-Dateien; `hcw-pdf` bestimmt die PDF-Gestaltung innerhalb
des Docker-Containers.

## Was ist Quarto?

[Quarto](https://quarto.org/) ist ein quelloffenes Publikationssystem für
technische und wissenschaftliche Dokumente. Es erweitert Markdown um Funktionen
wie Dokumentmetadaten, Kapitel, Querverweise, nummerierte Abbildungen und
Tabellen, Literaturzitate, Formeln sowie verschiedene Ausgabeformate.

Quarto ist dabei weder ein Texteditor noch eine eigene Textsatz-Engine. Es
koordiniert die einzelnen Verarbeitungsschritte und liest die
Projektkonfiguration aus `_quarto.yml`. Dateien mit der Endung `.qmd` sind
Quarto-Markdown-Dateien: größtenteils normales Markdown, ergänzt um
Quarto-spezifische Syntax und YAML-Metadaten.

## Komponenten

Die Vorlage verwendet folgende Werkzeuge:

- **Visual Studio Code** ist ausschließlich der Editor. Die Arbeit kann auch mit
  jedem anderen UTF-8-fähigen Texteditor bearbeitet werden.
- **Quarto** liest `_quarto.yml` und das gewählte Sprachprofil, verbindet die
  Kapitel in der festgelegten Reihenfolge und steuert die Konvertierung.
- **Pandoc** wandelt Quarto-Markdown in LaTeX um.
- **Pandoc Citeproc** liest `content/references.bib`, löst Zitationsschlüssel auf und
  formatiert Zitate sowie das Literaturverzeichnis.
- **LaTeX** übernimmt den professionellen Textsatz, darunter Seitenaufteilung,
  Überschriften, Verzeichnisse, Tabellen und Formeln.
- **LuaLaTeX** ist die konkret verwendete LaTeX-Engine und erzeugt die PDF.
- **Docker** stellt Quarto, Pandoc, TeX Live und alle LaTeX-Pakete in einer
  reproduzierbaren Linux-Umgebung bereit.

## Verarbeitungskette

```text
setup.tex
      │
      ├── internal/scripts/thesis.sh
      └── _quarto-de.yml oder _quarto-en.yml
               │
               ▼
_quarto.yml
      │
      ├── index.qmd (technische Startdatei)
      ├── content/chapters/de/*.qmd oder content/chapters/en/*.qmd
      ├── content/frontmatter/ und content/backmatter/ der gewählten Sprache
      ├── content/references.bib
      ├── _extensions/FH-Campus-Wien/hcw/
      └── internal/latex/preamble.tex
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

1. `internal/scripts/thesis.sh` liest die Arbeitssprache aus `setup.tex`.
2. Das passende Quarto-Sprachprofil `de` oder `en` aktivieren.
3. `_quarto.yml` und die Kapitelliste des aktiven Sprachprofils einlesen.
4. Alle Kapitel in der angegebenen Reihenfolge zusammenführen.
5. Markdown, Querverweise und Zitationen verarbeiten.
6. Ein temporäres LaTeX-Dokument erzeugen.
7. Gemeinsames HCW-Format, `setup.tex` und `internal/latex/preamble.tex` einbinden.
8. LuaLaTeX so oft ausführen, wie es für Verzeichnisse und Referenzen nötig ist.
9. Die fertige PDF im Verzeichnis `build/` ablegen.

Die temporäre `.tex`-Datei wird standardmäßig nicht behalten. Für die Analyse
von LaTeX-Problemen kann in `_quarto.yml` vorübergehend Folgendes gesetzt werden:

```yaml
format:
  hcw-pdf:
    keep-tex: true
```

## Rolle des Docker-Images

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

## Warum funktioniert der Build offline?

Der erste `docker pull` beziehungsweise `docker run` benötigt Internet, um das
fertige Builder-Image herunterzuladen. Danach befinden sich alle Programme und
Pakete im lokalen Image. `docker run` verwendet diese lokale Kopie und benötigt
für normale PDF-Builds keine Netzwerkverbindung.

Die Reproduzierbarkeit entsteht durch den fest angegebenen Image-Tag `1.3.0`.
Eine neue Quarto-Version oder geänderte LaTeX-Pakete werden zuerst im separaten
Builder-Repository getestet und als neue Version veröffentlicht. Erst danach
wird ein Template bewusst auf diese neue Version umgestellt und erneut als PDF
getestet.

## Builder-Version im Template aktualisieren

Eine neue Builder-Version wird nicht automatisch übernommen. Für ein geplantes
Update sind folgende Schritte erforderlich:

1. Den neuen Release im Builder-Repository samt Smoke-Test veröffentlichen.
2. Den vollständigen Image-Tag in `.vscode/tasks.json` und in den
   Betriebssystem-Beispielen unter [Build und Vorschau](build-und-vorschau.md#ohne-vs-code) gemeinsam ändern.
3. PDF-Erzeugung, Vorschau, Vorschau-Neustart und Offline-Build testen.
4. Die Template-Änderung als eigene, nachvollziehbare Version veröffentlichen.

## HCW-Format im Template aktualisieren

Auch das gemeinsame Quarto-Format wird nicht automatisch übernommen. Der
aktuell eingebundene Release-Tag steht in `internal/hcw-format-version.txt`. Ein Update
ist ausschließlich für Vorlagenbetreuer:innen vorgesehen:

1. Im Repository `hcw-quarto-format` eine neue Version testen und mit einem Tag
   wie `v0.2.0` veröffentlichen.
2. In `internal/hcw-format-version.txt` denselben Tag eintragen.
3. In VS Code den Task `Maintainer: HCW-Format aktualisieren` ausführen.
4. Die Änderungen unter `_extensions/FH-Campus-Wien/hcw/` mit `git diff`
   kontrollieren.
5. `Thesis: PDF erstellen` ausführen und die vollständige PDF visuell prüfen.
6. Versionsdatei und aktualisierte Extension gemeinsam committen.

Der Maintainer-Task ruft im Builder-Container das Skript
`internal/scripts/update-hcw-format.sh` auf. Dieses installiert den angegebenen
Release, prüft Manifest, Version, Logo und LaTeX-Partials und bricht bei einer
unvollständigen Extension ab. Nur dieser bewusste Aktualisierungsschritt
benötigt Netzwerkzugriff; Schreiben, PDF-Erstellung und Vorschau bleiben
offlinefähig.

## Hinweis zur Erstellung

Diese Dokumentvorlage wurde mit Unterstützung von ChatGPT SOL 5.6 erstellt und
weiterentwickelt. Alle Inhalte und technischen Entscheidungen wurden von den
Projektverantwortlichen geprüft.

[Zurück zum Inhaltsverzeichnis](../../README.md#inhaltsverzeichnis)
