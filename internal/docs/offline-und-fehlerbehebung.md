# Offline verwenden und Fehler beheben

[← Quick Start und Inhaltsverzeichnis](../../README.md)

Dateipfade beziehen sich auf den Projektstamm. Terminalbefehle werden dort ausgeführt.

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


### Quarto-Preview meldet eine fehlende CLI

Die Vorschau-Schaltfläche der Quarto-Erweiterung erwartet eine lokale Quarto-CLI.
Für diese Docker-Vorlage stattdessen den Task `Thesis: Vorschau starten` verwenden;
eine lokale Quarto-Installation ist nicht nötig. Siehe [Build und Vorschau](build-und-vorschau.md).

[Zurück zum Inhaltsverzeichnis](../../README.md#inhaltsverzeichnis)
