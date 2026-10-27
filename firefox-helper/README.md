# PolitikCheck Facebook-Helfer für Firefox

Die Erweiterung übernimmt nur Text, den du auf Facebook selbst markierst. Sie liest keine Timeline und sendet nichts an Facebook. Die Auswahl geht per `politikcheck://` an die PolitikCheck-App; die Antwort wird mit Ollama lokal auf dem Mac erzeugt.

## Einmalig einrichten

1. Firefox öffnen und `about:debugging#/runtime/this-firefox` in die Adresszeile eingeben.
2. **Dieses Firefox** auswählen und auf **Temporäres Add-on laden…** klicken.
3. Die Datei `PolitikCheck-Firefox-Helfer.xpi` auswählen (oder direkt `manifest.json` aus diesem Ordner).
4. PolitikCheck einmal neu bauen und starten, damit macOS das URL-Schema `politikcheck://` registriert.

## Benutzen

1. Auf Facebook den gewünschten Kommentar markieren.
2. Rechtsklick → **Für PolitikCheck übernehmen**.
3. Firefox öffnet PolitikCheck mit dem Kommentar. Falls Firefox die App nicht direkt startet, öffnet sich eine Übergabeseite mit einer Schaltfläche **PolitikCheck starten**.

Alternativ kannst du das Erweiterungsfenster öffnen, auf **Markierung aus Facebook übernehmen** klicken und anschließend **In PolitikCheck öffnen** wählen.

Die Erweiterung wird als temporäres Add-on bei einem Firefox-Neustart entfernt und muss danach erneut in `about:debugging` geladen werden. Für eine dauerhaft installierbare Firefox-Erweiterung ist eine Mozilla-Signierung erforderlich.

Wichtig: `popup.html` nicht direkt im Browser als `file://` öffnen. Nur das als temporäres Add-on geladene XPI erhält Zugriff auf Firefox-Auswahl, Kontextmenü und Erweiterungs-APIs.

## Fehlerbehebung

### „Für PolitikCheck übernehmen“ fehlt im Rechtsklick-Menü

Der Firefox-Helfer ist ein temporäres Add-on. Firefox entfernt es nach einem Neustart. Lade es dann erneut:

1. `about:debugging#/runtime/this-firefox` in Firefox öffnen.
2. **Dieses Firefox** wählen und auf **Temporäres Add-on laden…** klicken.
3. `PolitikCheck-Firefox-Helfer.xpi` aus dem Projektordner auswählen. Alternativ `manifest.json` im Ordner `firefox-helper` laden.
4. Auf Facebook Text markieren und mit der rechten Maustaste direkt auf die Markierung klicken.

Der Menüpunkt erscheint nur bei markiertem Text auf Facebook. Prüfe außerdem unter `about:addons`, ob der PolitikCheck-Helfer aktiviert ist. Nach jedem Firefox-Neustart muss das temporäre Add-on erneut geladen werden.
