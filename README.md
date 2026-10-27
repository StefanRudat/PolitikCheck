# PolitikCheck für macOS

Eine SwiftUI-App für kurze, sachliche Gegendarstellungen. Die Textgenerierung läuft mit Ollama und Gemma 3 4B lokal auf dem Mac. Es ist kein API-Schlüssel und kein kostenpflichtiger Cloud-Dienst nötig.

## Voraussetzungen und erster Start

- macOS 14 Sonoma oder neuer
- Ollama für macOS: [ollama.com/download/mac](https://ollama.com/download/mac)
- Internet für die einmalige Installation und den Download des Modells (ca. 3,4 GB)

Ollama installieren und starten. Dann PolitikCheck öffnen und **Status prüfen** wählen. Sobald Ollama erreichbar ist, in der App **Modell herunterladen** klicken. Das Modell bleibt danach lokal verfügbar.

## Bauen

Mit Xcode Command Line Tools (`xcode-select --install`):

```bash
cd politik-check
./build.sh
open "build/PolitikCheck.app"
```

Die App kommuniziert nur mit dem lokalen Ollama-Dienst unter `127.0.0.1`. Kommentare werden nicht an einen KI-Anbieter übertragen. Fertige Antworten werden automatisch in die macOS-Zwischenablage kopiert und können im Facebook-Antwortfeld über Rechtsklick → **Einfügen** eingefügt werden. Die lokale Generierung bietet keine Live-Websuche und kann aktuelle Tatsachen nicht selbst überprüfen; aktuelle oder strittige Aussagen bitte anhand verlässlicher Quellen prüfen.

## Firefox-Helfer für Facebook

Die Erweiterung im Ordner [`firefox-helper`](firefox-helper/README.md) kann markierte Facebook-Kommentare per Kontextmenü an PolitikCheck übergeben. Der Import startet die lokale Prüfung automatisch. Sie liest keine Timeline und verwendet nur den vom Benutzer ausgewählten Text.
