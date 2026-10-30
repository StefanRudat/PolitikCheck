# PolitikCheck

PolitikCheck ist eine quelloffene Anwendung, die kurze, sachliche Gegendarstellungen zu politischen Kommentaren unterstützt. Als KI-Quelle lässt sich entweder die lokale Ollama-Installation mit Gemma 3 4B oder OpenRouter auswählen. Lokal ist kein API-Schlüssel nötig; OpenRouter benötigt einen persönlichen API-Schlüssel.

PolitikCheck soll einen respektvollen und faktenorientierten Austausch fördern. Der Anspruch ist, politische Argumente unabhängig von Partei oder Richtung nach denselben Maßstäben zu beurteilen. Als inhaltliche und ethische Orientierung dienen die Grundrechte und rechtsstaatlichen Prinzipien des Grundgesetzes für die Bundesrepublik Deutschland vom 23. Mai 1949 sowie die freiheitlich-demokratische Grundordnung.

Die Anwendung hat keinen Zugriff auf eine Live-Websuche. KI-Antworten können Fehler enthalten und ersetzen keine Prüfung aktueller Tatsachen anhand verlässlicher Quellen.

## Plattformen

- **macOS:** native SwiftUI-App, gebaut mit `./build.sh`.
- **Windows:** WinForms-App für .NET 10, Quellcode und Anleitung unter [`windows`](windows/) und [`INSTALLATION_WINDOWS.md`](INSTALLATION_WINDOWS.md). Die Windows-Version ist noch nicht auf Windows überprüft.
- **Linux:** Python-App mit Tkinter, Anleitung unter [`linux/README.md`](linux/README.md). Die Linux-Version ist noch nicht auf Linux überprüft.

In der App kann zwischen lokaler Verarbeitung mit Ollama und externer Verarbeitung über OpenRouter umgeschaltet werden. Bei OpenRouter ist standardmäßig `openrouter/free` eingestellt. OpenRouter bietet kostenlose Modelle mit wechselnder Verfügbarkeit und begrenztem Kontingent; kostenlose Nutzung ist nicht garantiert. Die aktuell dokumentierte Grenze für kostenlose Modelle beträgt 50 Anfragen pro Tag und 20 pro Minute. Kostenpflichtige Modell-IDs werden von der App nicht automatisch ausgewählt.

Bei externer Verarbeitung wird der eingegebene Kommentar an OpenRouter und den von OpenRouter ausgewählten Modellanbieter gesendet. Deren Datenverarbeitung ist je nach Anbieter unterschiedlich. Keine vertraulichen oder personenbezogenen Inhalte eingeben, wenn diese nicht weitergegeben werden sollen. OpenRouter verwendet Eingaben laut eigener Datenschutzerklärung nicht zum Trainieren eigener Modelle; der jeweilige Modellanbieter hat jedoch eigene Bedingungen.

Antwortlänge (0–100), KI-Quelle und Prompts lassen sich in der App einstellen. Der externe Prompt ist mit dem vom Projekt bereitgestellten Counter-Speech-Prompt vorausgefüllt und veränderbar. Der OpenRouter-Schlüssel wird auf macOS im Schlüsselbund und unter Windows mit Windows DPAPI geschützt; Linux speichert ihn in der nur für den aktuellen Benutzer lesbaren Konfigurationsdatei.

## OpenRouter einrichten

1. Unter [openrouter.ai/keys](https://openrouter.ai/keys) einen API-Schlüssel erstellen.
2. In PolitikCheck **Extern mit OpenRouter** auswählen und den Schlüssel eintragen.
3. Den externen Prompt bei Bedarf im Textfeld anpassen. Als Modell wird `openrouter/free` verwendet.

Kostenlose Modelle und deren Limits können sich ändern oder zeitweise nicht verfügbar sein. Die aktuelle Liste steht unter [OpenRouter Free Models](https://openrouter.ai/collections/free-models). Für jeden externen Aufruf ist eine Internetverbindung erforderlich. Der eingegebene Kommentar wird an OpenRouter und den jeweiligen Modellanbieter übertragen.

## macOS: Installation und erster Start

- macOS 14 Sonoma oder neuer
- Für lokale Nutzung: Ollama für macOS ([ollama.com/download/mac](https://ollama.com/download/mac)) und etwa 3,4 GB Speicherplatz für das Modell.

Die vorgebaute Mac-App gibt es unter [Releases](https://github.com/StefanRudat/PolitikCheck/releases/latest) als ZIP. Der Download ist für Apple-Silicon-Macs (ARM64) gebaut und nicht von Apple notarisiert.

Für externe Nutzung ist Ollama nicht erforderlich, aber ein OpenRouter-Schlüssel und eine Internetverbindung werden benötigt. Für lokale Nutzung Ollama starten, PolitikCheck öffnen und **Status prüfen** wählen. Sobald Ollama erreichbar ist, in der App **Modell herunterladen** klicken. Das Modell bleibt danach lokal verfügbar.

## macOS: Bauen

Mit Xcode Command Line Tools (`xcode-select --install`):

```bash
./build.sh
open "build/PolitikCheck.app"
```

## Firefox-Helfer für Facebook

Die Erweiterung im Ordner [`firefox-helper`](firefox-helper/README.md) übernimmt nur ausdrücklich markierte Facebook-Kommentare. Sie liest keine Timeline. Die Übergabe erfolgt über `politikcheck://`; die Antwortgenerierung läuft je nach Auswahl lokal oder über OpenRouter. Hinweise stehen unter [Fehlerbehebung](firefox-helper/README.md#fehlerbehebung).

## Technische Übergabe

Für die Fortsetzung des Projekts durch eine andere Person oder KI gibt es [`HANDOFF_FOR_AI.md`](HANDOFF_FOR_AI.md). Darin stehen Architektur, Prüfstatus und offene Schritte.
