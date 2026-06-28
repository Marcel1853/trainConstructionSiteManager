# Train Construction Site Manager

[![Factorio](https://img.shields.io/badge/Factorio-2.1-green)](https://factorio.com)
[![Version](https://img.shields.io/badge/version- 0.1.0--alpha-orange)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)]()

> **⚠️ WIP – WORK IN PROGRESS / NOCH NICHT FERTIG!**
>
> Diese Mod ist in aktiver Entwicklung (Alpha  0.1.0, 28.06.2026).
> Es gibt noch Bugs, unfertiges UI und fehlende Features.
> **Vorschläge, Ideen und Bugreports nehme ich SEHR gerne an!**

Zentrales Management-Dashboard für **TrainConstructionSite** in Factorio 2.1 / Space Age.

**GitHub:** https://github.com/Marcel1853/trainConstructionSiteManager  
**Autor:** Marcel171297

---

## Was macht die Mod?

**TrainConstructionSite Manager (TCSM)** ist ein reines Interface / QoL-Addon für **trainConstructionSiteFork**.

Statt jedes Depot, jeden Builder und jede Montageanlage einzeln auf der Karte abzulaufen:

**Ein Fenster. Alle Depots. Alle Oberflächen.**

- **Zentrales Dashboard**
  Übersicht über alle TCS-Depots, Builder und Assembler – sortiert nach Force & Oberfläche. Funktioniert auf Nauvis, allen Space-Age-Planeten und Space-Plattformen.

- **3 Tabs**
  - **Depots:** Name, Standort, Status, Züge (gebaut/angefordert)
  - **Builder:** Aktiver Bau-Status
  - **Assembler:** Zug-Montageanlagen

- **Schnell-Aktionen direkt aus der Tabelle**
  - **Auf Karte zeigen:** springt per Remote-Controller zur Entity
  - **Ping:** highlightet die Entity auf der Oberfläche
  - Standort-Koordinaten (X/Y) optional einblendbar

- **Shortcut Bar Integration**
  Eigener TCS-Manager-Button in der Shortcut-Bar.
  Hotkey: **ALT + T** zum Umschalten.

- **FactoryLib GUI**
  Draggable Hauptfenster, gebaut mit der FactoryLib GUI Layout Engine. Kompakte, rechtsbündige Header-Buttons: Koordinaten-Toggle / Aktualisieren / Schließen.

- **Voll lokalisiert**
  Deutsch & Englisch komplett.

Der eigentliche Zugbau läuft weiter 100% über **TrainConstructionSite / trainConstructionSiteFork**. TCSM liest nur die Depot-Daten aus und gibt dir ein zentrales UI.

---

## Installation

1. **trainConstructionSiteFork >= 0.5.6** installieren
2. **FactoryLib >= 0.2.2** installieren
3. **trainConstructionSiteManager  0.1.0** in den mods-Ordner
4. Spiel starten

Öffnen: Shortcut-Bar Button **„TCS Manager öffnen“** oder **ALT + T**

---

## Abhängigkeiten

```
{
  "name": "trainConstructionSiteManager",
  "version": " 0.1.0",
  "factorio_version": "2.1",
  "author": "Marcel171297",
  "dependencies": [
    "base >= 2.1",
    "trainConstructionSiteFork >= 0.5.6",
    "FactoryLib >= 0.2.2"
  ]
}
```

---

## Aktueller Stand – 0.1.0 alpha (28.06.2026)

**Funktioniert:**
- Central dashboard mit voller Sicht auf alle TCS Depots, Builder, Assembler
- Shortcut bar tool + ALT+T Hotkey
- Draggable main window (FactoryLib)
- Interactive table buttons: Jump to map / highlight entity
- DE / EN Lokalisierung komplett

**WIP / Bekannte Probleme:**
- **Zug-Status / Zeit-Anzeige wird noch nicht immer korrekt angezeigt**
- UI-Buttons (X/Y Koordinaten-Toggle, Aktualisieren, Schließen) – Layout wird noch überarbeitet, sollen kleiner und weiter rechts stehen
- Keine Sortierung / Filter / Suche in den Tabellen
- Bei >50 Depots wird die Liste langsam
- Tooltips fehlen teilweise
- Space-Age Oberflächen-Icons noch nicht final

Das ist genau der Stand aus dem `first commit` – bewusst als Alpha markiert.

---

## Feedback & Vorschläge – unbedingt erwünscht!

> **Ich nehme Vorschläge SEHR gerne an!**

Am liebsten:
- **GitHub Issues:** https://github.com/Marcel1853/trainConstructionSiteManager/issues
- Factorio Mod Portal Discussion


Gesucht:
- Welche Spalten / Infos fehlen euch im Manager?
- Filter / Suche / Gruppierung – wie braucht ihr es?
- UI-Feedback: Button-Positionen, Größe, Layout
- Warnsystem: „Builder blockiert“, „Kein Material“, „Depot voll“?
- Presets / Export-Import für Depot-Konfigurationen?
- LTN / Cybersyn Kompatibilität gewünscht?

Kein Vorschlag ist zu klein. Die Mod soll für große Bases mit 20+ Depots wirklich brauchbar werden.

---

## Kompatibilität

- **Multiplayer:** Ja
- **Bestehende Saves:** Ja, kann jederzeit hinzugefügt / entfernt werden
- **Space Age:** Ja, Multi-Surface Support
- **Andere Zug-Mods:** Neutral, greift nur auf TCS-Depotdaten zu

---

## Credits

- Base Mod: **TrainConstructionSite** von lovely_santa & Voske_123
- Fork: **trainConstructionSiteFork** – https://github.com/Marcel1853/trainConstructionSiteFork
- Manager UI: **Marcel171297**
- GUI Engine: **FactoryLib >= 0.2.2**

Danke an alle TCS-Tester!

---

## License

MIT

---

## English Summary

**Train Construction Site Manager** – Central management dashboard for TrainConstructionSite (Fork) – Factorio 2.1

One window to control all your TCS depots, builders and assemblers across all surfaces.

- Central dashboard – full visibility over all TCS Depots, Builders, Assemblers
- Shortcut bar tool + **ALT + T** hotkey toggle
- Draggable main window built with FactoryLib GUI layout engine
- Interactive table buttons: Jump to map location & highlight entity
- Tabs: Depots / Builders / Assemblers
- Full German and English localization

**Status:  0.1.0-alpha – WIP – NOT FINISHED YET**
Bugs expected. Train status/time display is still inaccurate. UI buttons are being reworked.

**Suggestions very welcome!**
Open an issue: https://github.com/Marcel1853/trainConstructionSiteManager/issues

Dependencies: `base >= 2.1`, `trainConstructionSiteFork >= 0.5.6`, `FactoryLib >= 0.2.2`  
Author: Marcel171297

---
*Version  0.1.0-alpha – 28.06.2026 – Work in Progress*
