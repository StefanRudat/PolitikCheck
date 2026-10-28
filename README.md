# PolitikCheck

PolitikCheck ist eine quelloffene Anwendung, die kurze, sachliche Gegendarstellungen zu politischen Kommentaren unterstützt. Die Textgenerierung läuft lokal mit Ollama und Gemma 3 4B – ohne API-Schlüssel und ohne laufende Gebühren für einen Cloud-KI-Dienst.

PolitikCheck soll einen respektvollen und faktenorientierten Austausch fördern. Der Anspruch ist, politische Argumente unabhängig von Partei oder Richtung nach denselben Maßstäben zu beurteilen. Als inhaltliche und ethische Orientierung dienen die Grundrechte und rechtsstaatlichen Prinzipien des Grundgesetzes für die Bundesrepublik Deutschland vom 23. Mai 1949 sowie die freiheitlich-demokratische Grundordnung.

Die Anwendung hat keinen Zugriff auf eine Live-Websuche. KI-Antworten können Fehler enthalten und ersetzen keine Prüfung aktueller Tatsachen anhand verlässlicher Quellen.

## Plattformen

- **macOS:** native SwiftUI-App, gebaut mit `./build.sh`.
- **Windows:** WinForms-App für .NET 10, Quellcode und Anleitung unter [`windows`](windows/) und [`INSTALLATION_WINDOWS.md`](INSTALLATION_WINDOWS.md). Die Windows-Version ist noch nicht auf Windows überprüft.
- **Linux:** Python-App mit Tkinter, Anleitung unter [`linux/README.md`](linux/README.md). Die Linux-Version ist noch nicht auf Linux überprüft.

Alle Plattformen verwenden denselben lokalen Ollama-Dienst und dasselbe Modell. Die Antwortlänge ist über einen Regler von 0 (sehr kurz) bis 100 (länger) einstellbar. Ein eigener Prompt kann als zusätzliche Vorgabe gespeichert werden. Diese Einstellungen bleiben lokal auf dem jeweiligen Gerät.

## macOS: Installation und erster Start

- macOS 14 Sonoma oder neuer
- Ollama für macOS: [ollama.com/download/mac](https://ollama.com/download/mac)
- Internet für die einmalige Installation und den Download des Modells (ca. 3,4 GB)

Ollama installieren und starten. Dann PolitikCheck öffnen und **Status prüfen** wählen. Sobald Ollama erreichbar ist, in der App **Modell herunterladen** klicken. Das Modell bleibt danach lokal verfügbar.

## macOS: Bauen

Mit Xcode Command Line Tools (`xcode-select --install`):

```bash
./build.sh
open "build/PolitikCheck.app"
```

## Firefox-Helfer für Facebook

Die Erweiterung im Ordner [`firefox-helper`](firefox-helper/README.md) übernimmt nur ausdrücklich markierte Facebook-Kommentare. Sie liest keine Timeline. Die Übergabe erfolgt über `politikcheck://`; Antwortgenerierung und Zwischenablage bleiben lokal. Der Helfer muss in Firefox als temporäres Add-on geladen werden und nach einem Firefox-Neustart erneut geladen werden. Hinweise stehen unter [Fehlerbehebung](firefox-helper/README.md#fehlerbehebung).

## Technische Übergabe

Für die Fortsetzung des Projekts durch eine andere Person oder KI gibt es [`HANDOFF_FOR_AI.md`](HANDOFF_FOR_AI.md). Darin stehen Architektur, Prüfstatus und offene Schritte.
