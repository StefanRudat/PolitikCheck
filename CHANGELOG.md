# Änderungsprotokoll

## 1.7 – 31. Oktober 2026

- Hauptfenster wird nach dem App-Start und bei erneutem Klick auf das Dock-Symbol aktiv nach vorn geholt.

## 1.6 – 31. Oktober 2026

- Schlüssel aus dem macOS-Schlüsselbund werden erst nach dem ersten Fensteraufbau und im Hintergrund geladen. Eine macOS-Freigabeabfrage soll dadurch nicht mehr den Start der Oberfläche blockieren.
- Browser-Kommentare, die während des Ladens der Schlüssel übergeben werden, bleiben vorgemerkt und werden nach erfolgreichem Laden verarbeitet.

## 1.5 – 31. Oktober 2026

- Gemini erhält mehr Ausgabetoken und nutzt `thinkingLevel: low`, damit interne Denk-Tokens kurze Antworten nicht abschneiden.
- `MAX_TOKENS` wird erkannt; unvollständige Gemini-Antworten werden nicht mehr als fertig in die Zwischenablage kopiert.

## 1.4 – 31. Oktober 2026

- Gemini-Modell-ID in der macOS-App konfigurierbar; Standard auf `gemini-3.8-flash` aktualisiert.
- Gemini-503-Hinweis erklärt temporäre Überlastung und nennt den Modellwechsel als mögliche, nicht garantierte Ausweichoption.
- Versionshinweis `PolitikCheck v1.4` und direkter GitHub-Hilfelink in der App ergänzt.

## 1.2 — 30. Oktober 2026

- OpenRouter-Status und Fehlermeldungen werden direkt im externen KI-Bereich angezeigt.
- OpenRouter-Fehlerantworten mit verschachteltem `error.message` werden verständlicher ausgegeben.
- Beim Wechsel zu OpenRouter zeigt die App an, ob ein Schlüssel eingetragen werden muss oder die externe Quelle ausgewählt ist.
- README ergänzt: API-Schlüssel korrekt eintragen und OpenRouter-401-Fehler prüfen.

## 1.1

- OpenRouter als optionale externe KI-Quelle ergänzt.
- Einstellbare Antwortlänge und veränderbare externe Prompt-Vorlage.
