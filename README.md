# Train Construction Site Manager

[![Factorio](https://img.shields.io/badge/Factorio-2.1-green)](https://factorio.com)
[![Version](https://img.shields.io/badge/version- 0.1.0--alpha-orange)]()
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)]()

> **⚠️ WIP – WORK IN PROGRESS – NOT FINISHED YET!**
>
> This mod is in active alpha development ( 0.1.0, June 28, 2026).
> Bugs, unfinished UI and missing features are expected.
> **Suggestions, ideas and bug reports are VERY welcome!**

Central management dashboard for **TrainConstructionSite** in Factorio 2.1 / Space Age.

**GitHub:** https://github.com/Marcel1853/trainConstructionSiteManager  
**Author:** Marcel171297

---

## What does this mod do?

**TrainConstructionSite Manager (TCSM)** is a pure interface / QoL companion mod for **trainConstructionSiteFork**.

Instead of walking to every single Depot, Builder and Assembler on the map:

**One window. All depots. All surfaces.**

- **Central Dashboard**
  Full overview of all TCS-Depots, Builders and Assemblers – sorted by force & surface. Works on Nauvis, all Space Age planets and space platforms.

- **3 Tabs**
  - **Depots:** Name, Location, Status, Trains (built / requested)
  - **Builders:** Active build status
  - **Assemblers:** Train assembly plants

- **Quick actions right from the table**
  - **Show on map:** jumps via remote controller to the entity
  - **Ping:** highlights the entity on the surface
  - Location coordinates (X/Y) optionally toggleable

- **Shortcut Bar Integration**
  Dedicated TCS-Manager button in the shortcut bar.
  Hotkey: **ALT + T**

- **FactoryLib GUI**
  Draggable main window, built with the FactoryLib GUI layout engine. Compact, right-aligned header buttons: Coords toggle / Refresh / Close.

- **Fully localized**
  German & English complete.

Train building itself is still 100% handled by **TrainConstructionSite / trainConstructionSiteFork**. TCSM only reads the depot data and gives you a central UI.

---

## Installation

1. Install **trainConstructionSiteFork >= 0.5.6**
2. Install **FactoryLib >= 0.2.2**
3. Add **trainConstructionSiteManager  0.1.0** to your mods folder
4. Start the game

Open with: Shortcut bar button **“Open TCS Manager”** or **ALT + T**

---

## Dependencies

```
base >= 2.1
trainConstructionSiteFork >= 0.5.6
FactoryLib >= 0.2.2
```

---

## Current Status – 0.1.0 alpha (June 28, 2026)

**Working:**
- Central dashboard with full visibility over all TCS Depots, Builders, Assemblers
- Shortcut bar tool + ALT+T hotkey toggle
- Draggable main window (FactoryLib)
- Interactive table buttons: Jump to map / highlight entity
- Full German and English localization

**WIP / Known issues:**
- **Train status / time display is not always correct yet**
- UI buttons (X/Y coords toggle, Refresh, Close) – layout is being reworked, will be smaller and pushed further right
- No sorting / filtering / search in tables yet
- List gets slow with >50 depots
- Tooltips partially missing
- Space Age surface icons not final

This is the `first commit` state – intentionally marked as alpha.

---

## Feedback & Suggestions – absolutely wanted!

> **I gladly accept suggestions!**

Best via:
- **GitHub Issues:** https://github.com/Marcel1853/trainConstructionSiteManager/issues
- Factorio Mod Portal Discussion
- Discord / Forum DM: Marcel171297

Looking for:
- Which columns / info are you missing in the manager?
- Filter / search / grouping – how do you need it?
- UI feedback: button positions, size, layout
- Warning system: “Builder blocked”, “No material”, “Depot full”?
- Presets / export-import for depot configs?
- LTN / Cybersyn compatibility wanted?

No suggestion is too small. The mod should be really usable for large bases with 20+ depots.

---

## Compatibility

- **Multiplayer:** Yes
- **Existing saves:** Yes, can be added / removed at any time
- **Space Age:** Yes, multi-surface support
- **Other train mods:** Neutral, only reads TCS depot data

---

## Credits

- Base Mod: **TrainConstructionSite** by lovely_santa & Voske_123
- Fork: **trainConstructionSiteFork** – https://github.com/Marcel1853/trainConstructionSiteFork
- Manager UI: **Marcel171297**
- GUI Engine: **FactoryLib >= 0.2.2**

Thanks to all TCS testers!

---

## License

MIT

---
*Version  0.1.0-alpha – June 28, 2026 – Work in Progress*
