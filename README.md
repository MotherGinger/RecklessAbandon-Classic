# Reckless Abandon Classic

A WoW Classic addon that lets you quickly (and _recklessly_) abandon quests.

# Current Features

- Abandon individual quests with a single click
- Abandon all zone quests with a single click (prompts for confirmation by default)
- Command line option to abandon your entire quest log (disabled by default)
- Command line option to abandon groups of quests based on qualifiers (disabled by default)
  - Available Qualifiers: `dungeon`, `elite`, `failed`, `gray`, `green`, `group`, `heroic`, `orange`, `pvp`, `raid`, `red`, `yellow`
- Exclude individual quests from group abandons
- Automation options to abandon quests automatically
- Configuration panel to toggle confirmations, hide/show abandon buttons, and setup keybindings
- Super tiny, less than 1MB of memory

# Upcoming features

Take a look at our [issue board](https://github.com/MotherGinger/RecklessAbandon-Classic/labels/enhancement) for scheduled enhancements and feature requests, or [submit your own](https://github.com/MotherGinger/RecklessAbandon-Classic/issues/new?assignees=&labels=enhancement&template=feature_request.md&title=%5BFeature+Request%5D) if you have an idea.

---

# Usage

The following outlines how to use Reckless Abandon

## Quest Log

All quest log abandon buttons are shown by default

### Abandoning a Quest

Left click the abandon button next to a quest

### Abandoning All Quests in a Zone

Left click the abandon button next to a zone header

### Excluding a Quest From Group Abandons

Right click the abandon button for an individual quest
Right click the abandon button again to include it

## Opening the Configuration Panel

To open the configuration panel run `/reckless config`

## Command Line Usage

All commands are disabled by default. You can enable them in the configuration panel.

### List all quests

`/reckless list all`

### Abandon all quests

`/reckless abandon all`

### Abandon a quest by quest ID

`/reckless abandon <questId>`

### Abandon a quest by qualifier

`/reckless abandon <qualifier>`

### Exclude a quest from group abandons by questID

`/reckless exclude <questID>`

### Include a quest in group abandons by questID

`/reckless include <questID>`

---

# Contributing

Take a look at our [contribution guidelines](https://github.com/MotherGinger/RecklessAbandon-Classic/blob/main/CONTRIBUTING.md).

# Reporting an Issue

To report an issue please fill out a [bug report](https://github.com/MotherGinger/RecklessAbandon-Classic/issues/new?assignees=MotherGinger&labels=&template=bug_report.md&title=%5BBug+Report%5D). Reports should typically be reviewed within 24 hours.

# Frequently Asked Questions

- **Does Reckless Abandon only work with ElvUI?**
  - _No, I just happen to use ElvUI so the screenshots are skinned. Reckless Abandon works with or without ElvUI._
- **Does Reckless Abandon work for retail?**
  - _Yes! Checkout the retail version on [CurseForge](https://www.curseforge.com/wow/addons/reckless-abandon) or [Github](https://github.com/MotherGinger/RecklessAbandon)_
- **Does Reckless Abandon work for Burning Crusade Classic?**
  - _Yes! At the current moment, each release contains a BCC version_
