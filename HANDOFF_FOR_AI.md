# Übergabe an eine andere KI: PolitikCheck

## Projektziel

PolitikCheck erstellt kurze, sachliche deutschsprachige Gegendarstellungen zu politischen Kommentaren. Die Ausgabe soll direkt in Online-Diskussionen verwendbar sein, ohne Beleidigungen oder Markdown-Formatierung. Das Modell soll keine Quellen, Zahlen oder persönlichen Erfahrungen erfinden und Unsicherheit bei aktuellen Behauptungen kenntlich machen.

## Repository-Aufbau

- `PolitikCheck.swift`, `Info.plist`, `build.sh`: bestehende native macOS-App (SwiftUI).
- `firefox-helper/`: Firefox-Erweiterung. Sie übergibt ausgewählten Facebook-Text per `politikcheck://check?text=...` an die Desktop-App.
- `windows/`: neue Windows-App (C# WinForms, .NET 10), Build-, Installations- und Deinstallationsskripte.
- `INSTALLATION_WINDOWS.md`: Windows-Installationsanleitung mit ausdrücklichem Hinweis auf den ungeprüften Status.
- `HANDOFF_FOR_AI.md`: diese technische Übergabe.

## Windows-Implementierung

Die WinForms-App ruft ausschließlich `http://127.0.0.1:11434` auf. Sie prüft `/api/tags`, lädt bei Bedarf `gemma3:4b` über `/api/pull` und erstellt Antworten mit `/api/chat`. Die Antwort wird automatisch in die Windows-Zwischenablage kopiert. Beim Start akzeptiert `Program.cs` die registrierte URI `politikcheck://check?text=...` und startet die Generierung, sobald Modell und Ollama bereit sind.

`windows/build.ps1` veröffentlicht eine selbstständige win-x64-App. `windows/Install.ps1` kopiert sie in `%LOCALAPPDATA%\Programs\PolitikCheck`, registriert das URI-Protokoll im Benutzerzweig der Registry und erstellt einen Startmenü-Link. `windows/Uninstall.ps1` entfernt diese Einträge.

## Bekannter Prüfstatus und nächste Schritte

Die Windows-Version wurde auf dem Entwicklungsrechner nicht gebaut, nicht auf Windows ausgeführt und nicht mit Ollama oder Firefox praktisch geprüft. Sie ist auf GitHub als **nicht überprüft** gekennzeichnet. Behaupte nicht, dass sie funktioniert oder getestet wurde, bevor Windows-Prüfungen erfolgt sind.

Vor einer Freigabe sollte eine andere KI oder ein Windows-Benutzer mindestens:

1. `windows/build.ps1` mit dem .NET 10 SDK auf einem sauberen Windows-10/11-x64-System ausführen und Buildfehler beheben.
2. Die erzeugte `PolitikCheck.exe` starten, Ollama-Verbindung und Modellstatus prüfen.
3. Modell-Download, Chat-Antwort, Status-/Fehlerfälle und automatisches Zwischenablage-Kopieren testen.
4. `Install.ps1` und `Uninstall.ps1` ohne Administratorrechte prüfen.
5. Den Firefox-Helfer temporär installieren und die Übergabe über `politikcheck://` testen, sowohl bei geschlossener als auch geöffneter App.
6. Die README und Installationsanleitung um bestätigte Windows-Ergebnisse ergänzen und den ungeprüften Hinweis erst nach realer Prüfung aktualisieren.

## Arbeitsregeln für Folgeänderungen

- macOS- und Windows-Apps sollen dasselbe Faktencheck-Ziel und dieselbe vorsichtige politische Sprache behalten.
- Kommentare und Antworten dürfen keine erfundenen Belege enthalten.
- Das Projekt sendet keine Daten an einen Cloud-KI-Dienst; keine solchen Abhängigkeiten ohne ausdrückliche Produktentscheidung ergänzen.
- Keine privaten Dokumente aus dem übergeordneten Arbeitsverzeichnis ins Repository aufnehmen.
- Vor jedem Push den Git-Status und den Inhalt des Diffs prüfen. GitHub-Repository: <https://github.com/StefanRudat/PolitikCheck>.
