# PolitikCheck für Linux

## Prüfstatus

Die Linux-Version wurde vom Projektteam noch nicht auf einem Linux-System installiert oder praktisch geprüft. Sie wird ausdrücklich als **nicht überprüft** bereitgestellt.

## Voraussetzungen

- Eine aktuelle 64-Bit-Linux-Distribution mit grafischer Desktop-Umgebung.
- Python 3 und Tkinter. Unter Ubuntu oder Debian: `sudo apt install python3 python3-tk xdg-utils`.
- Für lokale Nutzung: Ollama für Linux ([ollama.com/download/linux](https://ollama.com/download/linux)) und rund 3,4 GB Speicherplatz für Gemma 3 4B.

## Installation

1. Repository herunterladen oder klonen:

   ```bash
   git clone https://github.com/StefanRudat/PolitikCheck.git
   cd PolitikCheck
   ```

2. Nur für lokale Nutzung: Ollama installieren und starten. Das Modell einmalig herunterladen:

   ```bash
   ollama pull gemma3:4b
   ```

   Wenn du OpenRouter oder Gemini verwenden möchtest, kannst du diesen Schritt überspringen und stattdessen den passenden API-Schlüssel in der App eintragen.

3. PolitikCheck installieren:

   ```bash
   bash linux/install.sh
   ```

   Das Skript legt die Anwendung in `~/.local/share/politikcheck` ab, fügt einen Eintrag im Anwendungsmenü hinzu und registriert nach Möglichkeit `politikcheck://` für den Firefox-Helfer. Eine Systeminstallation mit Administratorrechten ist nicht erforderlich.

4. PolitikCheck im Anwendungsmenü öffnen. Kommentare können eingefügt oder auf Facebook markiert und über den Firefox-Helfer übergeben werden. Antworten werden automatisch in die Zwischenablage kopiert.

Über **KI-Quelle** wechselst du zwischen Ollama lokal, OpenRouter und Google Gemini. OpenRouter braucht einen eigenen Schlüssel; voreingestellt ist `openrouter/free`. Kostenlose Modelle haben Limits und können wechseln oder zeitweise ausfallen. Gemini nutzt `gemini-3.6-flash`; der eigene Gemini-Schlüssel lässt sich über den Link in der App erstellen. Für Gemini-API-Clients, die Nutzern im EWR, in der Schweiz oder im Vereinigten Königreich bereitgestellt werden, verlangen Googles Bedingungen ein Projekt mit aktiver Cloud-Abrechnung. Kontingente und Preise können sich ändern.

Der externe Prompt ist mit dem Projekt-Prompt für demokratische Gegenrede vorausgefüllt und lässt sich ändern. Antwortlänge, Quelle, Prompts und getrennte OpenRouter-/Gemini-Schlüssel werden unter `~/.config/politikcheck/settings.json` gespeichert (oder unter dem Pfad aus `XDG_CONFIG_HOME`). Die Datei wird mit Dateirechten 0600 angelegt und ist damit nur für den aktuellen Benutzer lesbar. Die API-Schlüssel sind dort nicht verschlüsselt.

Bei OpenRouter-Auswahl werden Kommentar und Prompt über OpenRouter an den jeweiligen Modellanbieter übertragen. Bei Gemini-Auswahl gehen beide direkt an Google. Prüfe die Datenschutz- und Nutzungsbedingungen des Anbieters und gib keine vertraulichen Inhalte ein. Googles EWR-Bedingungen verlangen für bereitgestellte API-Clients ein Projekt mit aktiver Cloud-Abrechnung. Bei lokaler Auswahl wird der Kommentar an Ollama auf demselben PC gesendet.

## Deinstallation

Im geklonten Projektordner ausführen:

```bash
bash linux/uninstall.sh
```

Ollama und heruntergeladene Modelle bleiben installiert. Je nach Desktop-Umgebung kann der Eintrag für `politikcheck://` noch in der MIME-Konfiguration des Benutzers stehen.
