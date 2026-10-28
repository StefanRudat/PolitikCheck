# PolitikCheck für Linux

## Prüfstatus

Die Linux-Version wurde vom Projektteam noch nicht auf einem Linux-System installiert oder praktisch geprüft. Sie wird ausdrücklich als **nicht überprüft** bereitgestellt.

## Voraussetzungen

- Eine aktuelle 64-Bit-Linux-Distribution mit grafischer Desktop-Umgebung.
- Python 3 und Tkinter. Unter Ubuntu oder Debian: `sudo apt install python3 python3-tk xdg-utils`.
- Ollama für Linux: [ollama.com/download/linux](https://ollama.com/download/linux).
- Rund 3,4 GB freier Speicherplatz für Gemma 3 4B, zusätzlich zu Ollama und der App.

## Installation

1. Repository herunterladen oder klonen:

   ```bash
   git clone https://github.com/StefanRudat/PolitikCheck.git
   cd PolitikCheck
   ```

2. Ollama installieren und starten. Das Modell einmalig herunterladen:

   ```bash
   ollama pull gemma3:4b
   ```

3. PolitikCheck installieren:

   ```bash
   bash linux/install.sh
   ```

   Das Skript legt die Anwendung in `~/.local/share/politikcheck` ab, fügt einen Eintrag im Anwendungsmenü hinzu und registriert nach Möglichkeit `politikcheck://` für den Firefox-Helfer. Eine Systeminstallation mit Administratorrechten ist nicht erforderlich.

4. PolitikCheck im Anwendungsmenü öffnen. Kommentare können eingefügt oder auf Facebook markiert und über den Firefox-Helfer übergeben werden. Antworten werden automatisch in die Zwischenablage kopiert.

Die Antwortlänge lässt sich über den Regler von 0 (sehr kurz) bis 100 (länger) anpassen. Eigene Prompts werden als zusätzliche Vorgabe gespeichert. Die Einstellungen liegen unter `~/.config/politikcheck/settings.json` (oder unter dem Pfad aus `XDG_CONFIG_HOME`).

## Deinstallation

Im geklonten Projektordner ausführen:

```bash
bash linux/uninstall.sh
```

Ollama und heruntergeladene Modelle bleiben installiert. Je nach Desktop-Umgebung kann der Eintrag für `politikcheck://` noch in der MIME-Konfiguration des Benutzers stehen.
