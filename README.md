# PolitikCheck

PolitikCheck ist eine quelloffene Anwendung, die kurze, sachliche Gegendarstellungen zu politischen Kommentaren unterstützt. Als KI-Quelle lassen sich die lokale Ollama-Installation mit Gemma 3 4B, OpenRouter oder die Gemini API auswählen. Für die beiden externen Anbieter ist jeweils ein persönlicher API-Schlüssel erforderlich.

PolitikCheck soll einen respektvollen und faktenorientierten Austausch fördern. Der Anspruch ist, politische Argumente unabhängig von Partei oder Richtung nach denselben Maßstäben zu beurteilen. Als inhaltliche und ethische Orientierung dienen die Grundrechte und rechtsstaatlichen Prinzipien des Grundgesetzes für die Bundesrepublik Deutschland vom 23. Mai 1949 sowie die freiheitlich-demokratische Grundordnung.

Die Anwendung hat keinen Zugriff auf eine Live-Websuche. KI-Antworten können Fehler enthalten und ersetzen keine Prüfung aktueller Tatsachen anhand verlässlicher Quellen.

## Plattformen

- **macOS:** native SwiftUI-App, gebaut mit `./build.sh`.
- **Windows:** WinForms-App für .NET 10, Quellcode und Anleitung unter [`windows`](windows/) und [`INSTALLATION_WINDOWS.md`](INSTALLATION_WINDOWS.md). Die Windows-Version ist noch nicht auf Windows überprüft.
- **Linux:** Python-App mit Tkinter, Anleitung unter [`linux/README.md`](linux/README.md). Die Linux-Version ist noch nicht auf Linux überprüft.

In der App kann zwischen lokaler Verarbeitung mit Ollama, OpenRouter und Google Gemini umgeschaltet werden. Bei OpenRouter ist standardmäßig `openrouter/free` eingestellt. OpenRouter bietet kostenlose Modelle mit wechselnder Verfügbarkeit und begrenztem Kontingent; kostenlose Nutzung ist nicht garantiert. Die aktuell dokumentierte Grenze für kostenlose Modelle beträgt 50 Anfragen pro Tag und 20 pro Minute. Kostenpflichtige Modell-IDs werden von der App nicht automatisch ausgewählt. Die macOS-App verwendet standardmäßig `gemini-3.8-flash`; die Modell-ID lässt sich dort ändern, zum Beispiel auf `gemini-3.6-flash`. Kontingente, Preise und Modellverfügbarkeit können sich ändern.

Bei OpenRouter werden Kommentar und Prompt an OpenRouter und den ausgewählten Modellanbieter gesendet. Bei Gemini gehen Kommentar und Prompt direkt an Google. Anbieterbedingungen und Datenverarbeitung unterscheiden sich; keine vertraulichen oder personenbezogenen Inhalte eingeben, wenn diese nicht weitergegeben werden sollen. Googles Bedingungen verlangen für Gemini-API-Clients, die Nutzern im Europäischen Wirtschaftsraum, in der Schweiz oder im Vereinigten Königreich bereitgestellt werden, ein Projekt mit aktiver Cloud-Abrechnung. Bei unbezahlter Nutzung können Eingaben außerhalb der für EWR-Nutzer geltenden Paid-Service-Datenregeln zur Verbesserung von Google-Produkten verwendet und von Menschen geprüft werden. Vor der Nutzung die [Gemini-API-Bedingungen](https://ai.google.dev/gemini-api/terms) prüfen.

Antwortlänge (0–100), KI-Quelle und Prompts lassen sich in der App einstellen. Der externe Prompt ist mit dem vom Projekt bereitgestellten Counter-Speech-Prompt vorausgefüllt und veränderbar. Gemini- und OpenRouter-Schlüssel werden getrennt gespeichert. Die Schlüsselablage erfolgt auf macOS im Schlüsselbund, unter Windows mit Windows DPAPI geschützt und unter Linux in der nur für den aktuellen Benutzer lesbaren Konfigurationsdatei.

## Gemini einrichten

1. Unter [Google AI Studio – API-Schlüssel](https://aistudio.google.com/api-keys) einen Gemini-API-Schlüssel erstellen.
2. In PolitikCheck **Google Gemini (extern)** auswählen und den Schlüssel ohne Anführungszeichen in das Gemini-Feld eintragen.
3. In der macOS-App die gewünschte Modell-ID eintragen. Standard ist `gemini-3.8-flash`; `gemini-3.6-flash` ist ebenfalls verfügbar, indem die Modell-ID geändert wird. Der externe Prompt lässt sich direkt darunter bearbeiten. Die Antwort wird automatisch in die Zwischenablage kopiert.

Für API-Clients, die Nutzern im EWR, in der Schweiz oder im Vereinigten Königreich bereitgestellt werden, verlangen Googles aktuelle Bedingungen ein aktives Cloud-Abrechnungskonto. Das Aktivieren der Abrechnung kann Kosten ermöglichen; die konkrete Nutzung und Preise richten sich nach Googles Kontingenten und Preisseite. Unbezahlte Gemini-Nutzung hat zusätzlich eigene Datenregeln. Details stehen in den [Gemini-API-Bedingungen](https://ai.google.dev/gemini-api/terms) und der [Preisdokumentation](https://ai.google.dev/gemini-api/docs/pricing).

### Fehlerbehebung: Gemini

- **503 `UNAVAILABLE` / „currently experiencing high demand“:** Google meldet, dass der Dienst vorübergehend überlastet oder nicht verfügbar ist. Später erneut versuchen. Das ist kein Beleg für einen ungültigen Schlüssel oder einen falschen Modellnamen. In der macOS-App kann die Modell-ID auf `gemini-3.8-flash` oder `gemini-3.6-flash` geändert werden. Ein Modellwechsel kann bei modellbezogener Auslastung helfen, garantiert aber keine Verfügbarkeit.
- **Antwort endet mitten im Satz:** Gemini zählt interne Denk-Tokens zum `maxOutputTokens`-Limit. PolitikCheck 1.5 setzt ein größeres Limit und `thinkingLevel: low`. Falls Google dennoch `MAX_TOKENS` meldet, zeigt die App einen Warnhinweis und kopiert den unvollständigen Text nicht automatisch.
- **401 oder 403:** Schlüssel und Projektberechtigungen in Google AI Studio prüfen. Den API-Schlüssel nicht in Issues, Screenshots oder Chats veröffentlichen.

## OpenRouter einrichten

1. Unter [openrouter.ai/keys](https://openrouter.ai/keys) einen API-Schlüssel erstellen.
2. In PolitikCheck **Extern mit OpenRouter** auswählen und den vollständigen Schlüssel eintragen. In das Feld gehört ausschließlich der Schlüssel (typischerweise beginnend mit `sk-or-v1-`), nicht `Bearer`, kein Beispielcode und keine Anführungszeichen. PolitikCheck setzt den `Bearer`-Header selbst.
3. Den externen Prompt bei Bedarf im Textfeld anpassen. Als Modell wird `openrouter/free` verwendet.

Kostenlose Modelle und deren Limits können sich ändern oder zeitweise nicht verfügbar sein. Die aktuelle Liste steht unter [OpenRouter Free Models](https://openrouter.ai/collections/free-models). Für jeden externen Aufruf ist eine Internetverbindung erforderlich. Der eingegebene Kommentar wird an OpenRouter und den jeweiligen Modellanbieter übertragen.

## Fehlerbehebung: OpenRouter

- **401 „Missing Authentication header“:** Prüfen, ob **Extern mit OpenRouter** ausgewählt ist und das Schlüsselfeld den vollständigen API-Schlüssel enthält. Den Schlüssel ohne `Bearer` neu einfügen.
- **401 „User not found“:** Den Schlüssel unabhängig von der App prüfen. Im macOS-Terminal fragt dieser Befehl den Schlüssel verdeckt ab und ruft OpenRouters Schlüsselstatus-Endpunkt auf; der Schlüssel wird nicht als Teil des Befehls in der Shell-History gespeichert:

  ```zsh
  read -s "OR_KEY?OpenRouter-Schlüssel: "
  echo
  curl -sS https://openrouter.ai/api/v1/key \
    -H "Authorization: Bearer $OR_KEY"
  unset OR_KEY
  ```

  Eine JSON-Antwort mit Kontoinformationen bestätigt, dass OpenRouter den Schlüssel akzeptiert. Kommt dort ebenfalls ein 401 zurück, den OpenRouter-Status prüfen oder den Support kontaktieren. Ist der Schlüssel dort gültig, PolitikCheck vollständig beenden, erneut öffnen und denselben vollständigen Schlüssel erneut in der aktuellen App-Version eintragen.
- **Andere OpenRouter-Fehler:** PolitikCheck zeigt die HTTP-Nummer und – sofern OpenRouter sie liefert – die Fehlermeldung direkt im OpenRouter-Bereich an. Kostenlose Modelle sind kontingentiert und können zeitweise nicht verfügbar sein. Den [OpenRouter-Status](https://status.openrouter.ai/) und die [Limits kostenloser Modelle](https://openrouter.ai/collections/free-models) prüfen.

API-Schlüssel niemals in öffentliche Issues, Screenshots oder Chats kopieren. Der macOS-Schlüssel wird im Schlüsselbund gespeichert.

## macOS: Installation und erster Start

- macOS 14 Sonoma oder neuer
- Für lokale Nutzung: Ollama für macOS ([ollama.com/download/mac](https://ollama.com/download/mac)) und etwa 3,4 GB Speicherplatz für das Modell.

Die vorgebaute Mac-App gibt es unter [Releases](https://github.com/StefanRudat/PolitikCheck/releases/latest) als ZIP. Der Download ist für Apple-Silicon-Macs (ARM64) gebaut und nicht von Apple notarisiert.

Für externe Nutzung ist Ollama nicht erforderlich. OpenRouter oder Gemini benötigen jeweils einen eigenen API-Schlüssel und eine Internetverbindung. Für lokale Nutzung Ollama starten, PolitikCheck öffnen und **Status prüfen** wählen. Sobald Ollama erreichbar ist, in der App **Modell herunterladen** klicken. Das Modell bleibt danach lokal verfügbar.

## macOS: Bauen

Mit Xcode Command Line Tools (`xcode-select --install`):

```bash
./build.sh
open "build/PolitikCheck.app"
```

Der macOS-Build enthält eine Statusanzeige für externe Anfragen sowie verständlichere Meldungen für OpenRouter-Fehler. Die App zeigt ihre Version in der Statusleiste und verlinkt dort die GitHub-Hilfe. Der Quellcode und Fehlerbehebungshinweise stehen im [GitHub-Projekt](https://github.com/StefanRudat/PolitikCheck); die App-Version steht in `Info.plist`.

## Firefox-Helfer für Facebook

Die Erweiterung im Ordner [`firefox-helper`](firefox-helper/README.md) übernimmt nur ausdrücklich markierte Facebook-Kommentare. Sie liest keine Timeline. Die Übergabe erfolgt über `politikcheck://`; die Antwortgenerierung läuft je nach Auswahl lokal oder über einen externen Anbieter. Hinweise stehen unter [Fehlerbehebung](firefox-helper/README.md#fehlerbehebung).

## Technische Übergabe

Für die Fortsetzung des Projekts durch eine andere Person oder KI gibt es [`HANDOFF_FOR_AI.md`](HANDOFF_FOR_AI.md). Darin stehen Architektur, Prüfstatus und offene Schritte.
