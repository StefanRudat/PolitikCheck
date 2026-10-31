# Übergabe an eine andere KI: PolitikCheck

## Projektziel

PolitikCheck erstellt kurze, sachliche deutschsprachige Gegendarstellungen zu politischen Kommentaren. Die Ausgabe soll direkt in Online-Diskussionen verwendbar sein, ohne Beleidigungen oder Markdown-Formatierung. Das Modell soll keine Quellen, Zahlen oder persönlichen Erfahrungen erfinden und Unsicherheit bei aktuellen Behauptungen kenntlich machen.

## Repository-Aufbau

- `PolitikCheck.swift`, `Info.plist`, `build.sh`: bestehende native macOS-App (SwiftUI).
- `firefox-helper/`: Firefox-Erweiterung. Sie übergibt ausgewählten Facebook-Text per `politikcheck://check?text=...` an die Desktop-App.
- `windows/`: neue Windows-App (C# WinForms, .NET 10), Build-, Installations- und Deinstallationsskripte.
- `linux/`: Linux-App (Python/Tkinter) samt Benutzerinstallation und Deinstallation.
- `INSTALLATION_WINDOWS.md`: Windows-Installationsanleitung mit ausdrücklichem Hinweis auf den ungeprüften Status.
- `linux/README.md`: Linux-Installationsanleitung und Prüfstatus.
- `HANDOFF_FOR_AI.md`: diese technische Übergabe.

## Windows-Implementierung

Die WinForms-App kann zwischen lokalem Ollama/Gemma, OpenRouter und Gemini wechseln. Lokal nutzt sie `http://127.0.0.1:11434` mit `/api/tags`, `/api/pull` und `/api/chat`. OpenRouter verwendet `/api/v1/chat/completions` mit `openrouter/free`; Gemini nutzt Googles `generateContent`-Endpunkt mit `gemini-3.6-flash`. Der externe Counter-Speech-Prompt ist bearbeitbar. Beide Schlüssel werden getrennt mit DPAPI pro Windows-Benutzer verschlüsselt und als Base64 in `%APPDATA%\PolitikCheck\settings.json` gespeichert. Die Antwort wird automatisch in die Windows-Zwischenablage kopiert. Beim Start akzeptiert `Program.cs` die registrierte URI `politikcheck://check?text=...`; ein benannter Mutex und eine Named Pipe leiten weitere Kommentare an die laufende Instanz.

`windows/build.ps1` veröffentlicht eine selbstständige win-x64-App. `windows/Install.ps1` kopiert sie in `%LOCALAPPDATA%\Programs\PolitikCheck`, registriert das URI-Protokoll im Benutzerzweig der Registry und erstellt einen Startmenü-Link. `windows/Uninstall.ps1` entfernt diese Einträge.

Die Linux-App nutzt nur die Python-Standardbibliothek und Tkinter. Sie bietet lokale Ollama-, OpenRouter- und Gemini-Auswahl. Gemini verwendet ebenfalls `gemini-3.6-flash` über `generateContent`. Beide externen Anbieter verwenden den bearbeitbaren Counter-Speech-Prompt; die Schlüssel werden getrennt in der Benutzer-Konfigurationsdatei mit Berechtigung 0600 gespeichert, aber nicht verschlüsselt. Einstellungen liegen unter `$XDG_CONFIG_HOME/politikcheck/settings.json` oder `~/.config/politikcheck/settings.json`. Sie verwendet einen Benutzer-Lock und einen lokalen Unix-Socket, um URL-Übergaben an die aktive App-Instanz weiterzuleiten.

Alle drei Oberflächen bieten einen Antwortlängen-Regler (0–100), einen Provider-Schalter sowie Prompt-Felder für lokale und externe KI. Gemini- und OpenRouter-Schlüssel werden getrennt gespeichert. Auf macOS liegen beide im Schlüsselbund, unter Windows werden sie mit DPAPI verschlüsselt und unter Linux in einer nur für den aktuellen Benutzer lesbaren Konfigurationsdatei gespeichert. Gemini-Kommentare und Prompts werden direkt an Google gesendet. Google verlangt laut aktuellen Bedingungen für Gemini-API-Clients, die EWR-Nutzern bereitgestellt werden, aktive Cloud-Abrechnung; Bedingungen und Datenverwendung vor Veröffentlichung prüfen. Beim Mac verwendet die SwiftUI-Szene `handlesExternalEvents`, um `politikcheck://check` an ein offenes Fenster zu routen. Eingehende neue Kommentare sollen eine gerade laufende Antwort verwerfen und im vorhandenen Fenster neu erzeugt werden.

## Bekannter Prüfstatus und nächste Schritte

### macOS / OpenRouter

Die macOS-App unterstützt OpenRouter über `https://openrouter.ai/api/v1/chat/completions` und verwendet standardmäßig `openrouter/free`. Der Schlüssel wird im macOS-Schlüsselbund gespeichert. Die OpenRouter-Ansicht zeigt während und nach einer Anfrage den Status sowie HTTP-Fehlermeldungen an; verschachtelte OpenRouter-Fehlerobjekte werden ausgelesen. Der veröffentlichte macOS-Build trägt Version 1.2. Der aktuelle Arbeitsstand hat Version 1.3 in `Info.plist` und ergänzt Gemini; diese Änderungen sind noch nicht in einem GitHub-Release.

Beim Supportfall mit HTTP 401 „User not found“ bestätigte `GET https://openrouter.ai/api/v1/key` für den vom Nutzer verwendeten Schlüssel ein gültiges Konto und Freikontingent. Wenn das in der App weiter auftritt, den neuesten Build öffnen, den Schlüssel vollständig und ohne `Bearer` erneut eintragen und verifizieren, dass Keychain-Wert und API-Key identisch sind. Niemals den vollständigen Schlüssel in Logs, GitHub oder Chatverläufe aufnehmen.

Die Windows-Version wurde auf dem Entwicklungsrechner nicht gebaut, nicht auf Windows ausgeführt und nicht mit Ollama oder Firefox praktisch geprüft. Die Linux-Version wurde ebenfalls nicht auf Linux installiert oder praktisch geprüft. Beide sind auf GitHub ausdrücklich als **nicht überprüft** gekennzeichnet. Behaupte nicht, dass sie funktionieren oder getestet wurden, bevor die jeweiligen Plattform-Prüfungen erfolgt sind.

### Gemini-Anbindung

Alle Oberflächen verwenden `https://generativelanguage.googleapis.com/v1beta/models/gemini-3.6-flash:generateContent` und den Header `x-goog-api-key`. Der Schlüssel wurde vom Nutzer separat mit einem erfolgreichen `generateContent`-Aufruf gegen `gemini-3.6-flash` bestätigt; der API-Key selbst liegt Codex nicht vor. Die Antwort wird aus `candidates[0].content.parts[*].text` zusammengesetzt. macOS speichert den Schlüssel separat im Schlüsselbund; Windows verschlüsselt ihn mit DPAPI; Linux speichert ihn getrennt in `settings.json` mit Dateimodus 0600. Die Linux-/Windows-Integration wurde nicht auf den Zielplattformen ausgeführt. Googles aktuelle Bedingungen und EWR-Anforderungen stehen in der README; diese Dokumentation vor öffentlicher Freigabe aktuell halten.

Vor einer Freigabe sollte eine andere KI oder ein Windows-Benutzer mindestens:

1. `windows/build.ps1` mit dem .NET 10 SDK auf einem sauberen Windows-10/11-x64-System ausführen und Buildfehler beheben.
2. Die erzeugte `PolitikCheck.exe` starten, Ollama-Verbindung, Modellstatus, Einstellungen und einzelnen Fensterprozess prüfen.
3. Unter einer aktuellen Linux-Distribution Python 3, Tkinter und Ollama bereitstellen, `bash linux/install.sh` ausführen und GUI, Einstellungen sowie Zwischenablage prüfen.
4. Modell-Download, Chat-Antwort, Status-/Fehlerfälle und automatisches Zwischenablage-Kopieren auf Windows und Linux prüfen.
5. Windows-`Install.ps1`/`Uninstall.ps1` sowie Linux-`install.sh`/`uninstall.sh` ohne systemweite Änderungen prüfen.
6. Den Firefox-Helfer temporär installieren und `politikcheck://` mit App geschlossen und geöffnet testen; bei offener App muss das vorhandene Fenster wiederverwendet und der neue Kommentar verarbeitet werden.
7. README und Installationsanleitungen um bestätigte Ergebnisse ergänzen und den ungeprüften Hinweis erst nach realer Prüfung aktualisieren.

## Arbeitsregeln für Folgeänderungen

- macOS- und Windows-Apps sollen dasselbe Faktencheck-Ziel und dieselbe vorsichtige politische Sprache behalten.
- Kommentare und Antworten dürfen keine erfundenen Belege enthalten.
- Standardmäßig ist die lokale KI ausgewählt. Bei ausdrücklich gewählter OpenRouter-Quelle werden Kommentar und Prompt an OpenRouter und den gewählten Modellanbieter übertragen; diese Weitergabe muss in UI und Dokumentation sichtbar bleiben.
- Keine privaten Dokumente aus dem übergeordneten Arbeitsverzeichnis ins Repository aufnehmen.
- Vor jedem Push den Git-Status und den Inhalt des Diffs prüfen. GitHub-Repository: <https://github.com/StefanRudat/PolitikCheck>.
