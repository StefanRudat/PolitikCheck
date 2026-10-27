# PolitikCheck unter Windows installieren

## Hinweis zum Prüfstatus

Die Windows-Version und diese Installationsschritte wurden vom Projektteam noch nicht auf einem Windows-PC gebaut oder praktisch überprüft. Sie werden daher ausdrücklich als **nicht überprüft** bereitgestellt. Es gibt derzeit keinen signierten Installer. Bitte vor einer regelmäßigen Nutzung selbst prüfen und Fehler im GitHub-Projekt melden.

## Voraussetzungen

- Windows 10 oder Windows 11, 64 Bit.
- Ollama für Windows: [ollama.com/download/windows](https://ollama.com/download/windows).
- .NET 10 SDK zum Bauen der Anwendung: [Microsoft .NET Downloads](https://dotnet.microsoft.com/download/dotnet/10.0).
- Firefox für die Browser-Erweiterung, optional.
- Rund 3,4 GB freier Speicherplatz für das Gemma-3-4B-Modell, zusätzlich zum Speicher für Ollama und die Anwendung.

## 1. Ollama und das Modell installieren

1. Ollama von der offiziellen Download-Seite installieren und starten.
2. PowerShell öffnen und das Modell einmalig laden:

   ```powershell
   ollama pull gemma3:4b
   ```

   Der erste Download benötigt eine Internetverbindung. Danach bleibt das Modell lokal gespeichert. Ollama stellt der App die lokale API unter `http://127.0.0.1:11434` bereit.

## 2. PolitikCheck herunterladen und bauen

1. Das Repository [StefanRudat/PolitikCheck](https://github.com/StefanRudat/PolitikCheck) öffnen.
2. Über **Code → Download ZIP** den Quellcode laden und entpacken. Alternativ Git verwenden:

   ```powershell
   git clone https://github.com/StefanRudat/PolitikCheck.git
   cd PolitikCheck\windows
   ```

   Bei einem ZIP-Download den Ordner `windows` im entpackten Projekt öffnen.
3. Im Datei-Explorer mit Rechtsklick auf `build.ps1` **Mit PowerShell ausführen** wählen. Alternativ PowerShell in diesem Ordner öffnen und starten:

   ```powershell
   .\build.ps1
   ```

   Das Skript erstellt eine selbstständige 64-Bit-Version im Unterordner `publish\win-x64`. Die App benötigt dadurch keine gesonderte .NET Desktop Runtime.

## 3. Installieren und starten

1. Im selben Ordner `Install.ps1` mit PowerShell ausführen:

   ```powershell
   .\Install.ps1
   ```

   Die Installation erfolgt im eigenen Benutzerkonto unter `%LOCALAPPDATA%\Programs\PolitikCheck`, benötigt also normalerweise keine Administratorrechte. Das Skript legt außerdem einen Startmenü-Eintrag an und registriert `politikcheck://` für den Firefox-Helfer.
2. PolitikCheck über das Startmenü starten. Falls Ollama bereits läuft und das Modell vorhanden ist, zeigt die App den Status **Bereit**.
3. Kommentar einfügen und **Gegendarstellung erstellen** wählen. Die Antwort wird automatisch in die Zwischenablage kopiert. Im Facebook-Antwortfeld mit Rechtsklick **Einfügen** wählen.

## Firefox-Helfer optional einrichten

Die Erweiterung liegt in `firefox-helper`. In Firefox `about:debugging#/runtime/this-firefox` öffnen und unter **Dieses Firefox** auf **Temporäres Add-on laden…** klicken. Die Datei `PolitikCheck-Firefox-Helfer.xpi` aus dem Projektordner wählen. Danach auf Facebook einen Kommentar markieren und per Rechtsklick **Für PolitikCheck übernehmen** wählen. Firefox fragt beim ersten Öffnen gegebenenfalls, ob es die externe App starten darf.

Temporäre Firefox-Erweiterungen werden nach einem Firefox-Neustart entfernt und müssen erneut geladen werden. Eine dauerhaft installierbare Version benötigt die Mozilla-Signierung.

## Deinstallation

Im Ordner `windows` das Skript `Uninstall.ps1` ausführen. Es entfernt die App, den Startmenü-Eintrag und die Protokollregistrierung. Ollama und das heruntergeladene Modell bleiben installiert.

## Datenschutz und Grenzen

Die App sendet den eingegebenen Kommentar an den lokalen Ollama-Dienst auf demselben PC. Sie verwendet keinen Cloud-KI-Anbieter und hat keine Live-Websuche. Aktuelle Tatsachenbehauptungen müssen vor dem Veröffentlichen anhand verlässlicher Quellen geprüft werden. Das Modell kann Fehler machen.
