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

Die WinForms-App ruft ausschließlich `http://127.0.0.1:11434` auf. Sie prüft `/api/tags`, lädt bei Bedarf `gemma3:4b` über `/api/pull` und erstellt Antworten mit `/api/chat`. Die Antwort wird automatisch in die Windows-Zwischenablage kopiert. Die Antwortlänge (0–100) und ein ergänzender Prompt werden unter `%APPDATA%\PolitikCheck\settings.json` gespeichert. Beim Start akzeptiert `Program.cs` die registrierte URI `politikcheck://check?text=...`; ein benannter Mutex und eine Named Pipe leiten weitere Kommentare an die laufende Instanz.

`windows/build.ps1` veröffentlicht eine selbstständige win-x64-App. `windows/Install.ps1` kopiert sie in `%LOCALAPPDATA%\Programs\PolitikCheck`, registriert das URI-Protokoll im Benutzerzweig der Registry und erstellt einen Startmenü-Link. `windows/Uninstall.ps1` entfernt diese Einträge.

Die Linux-App nutzt nur die Python-Standardbibliothek und Tkinter. Einstellungen liegen unter `$XDG_CONFIG_HOME/politikcheck/settings.json` oder `~/.config/politikcheck/settings.json`. Sie verwendet einen Benutzer-Lock und einen lokalen Unix-Socket, um URL-Übergaben an die aktive App-Instanz weiterzuleiten.

Alle drei Oberflächen bieten einen Antwortlängen-Regler (0–100) und ein Textfeld für einen ergänzenden, lokal gespeicherten Prompt. Beim Mac verwendet die SwiftUI-Szene `handlesExternalEvents`, um `politikcheck://check` an ein offenes Fenster zu routen. Eingehende neue Kommentare sollen eine gerade laufende Antwort verwerfen und im vorhandenen Fenster neu erzeugt werden.

## Bekannter Prüfstatus und nächste Schritte

Die Windows-Version wurde auf dem Entwicklungsrechner nicht gebaut, nicht auf Windows ausgeführt und nicht mit Ollama oder Firefox praktisch geprüft. Die Linux-Version wurde ebenfalls nicht auf Linux installiert oder praktisch geprüft. Beide sind auf GitHub ausdrücklich als **nicht überprüft** gekennzeichnet. Behaupte nicht, dass sie funktionieren oder getestet wurden, bevor die jeweiligen Plattform-Prüfungen erfolgt sind.

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
- Das Projekt sendet keine Daten an einen Cloud-KI-Dienst; keine solchen Abhängigkeiten ohne ausdrückliche Produktentscheidung ergänzen.
- Keine privaten Dokumente aus dem übergeordneten Arbeitsverzeichnis ins Repository aufnehmen.
- Vor jedem Push den Git-Status und den Inhalt des Diffs prüfen. GitHub-Repository: <https://github.com/StefanRudat/PolitikCheck>.
