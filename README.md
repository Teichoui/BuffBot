# BuffBot — MacroQuest Lua Buff Bot

A MacroQuest Lua script that automatically casts level-appropriate buffs when hailed. Configured entirely through an in-game GUI — no INI editing required (though INI files are still supported).

## Supported Classes

| Class | Buffs | Special |
|---|---|---|
| Beastlord | HP, Attack, Mana | |
| Cleric | HP, Guard, Symbol, Haste | Rez on "rez"; Unity/combo spells (85+) |
| Druid | HP, Regen, DS, SoW | Ports (Zephyr) |
| Enchanter | Haste, Clarity | |
| Magician | DS, Grant items, Mod rods | Summons on keywords (see Commands) |
| Necromancer | Dead Man Floating | Corpse summon on "summon" |
| Paladin | HP | |
| Ranger | HP, DS, AC, Attack, SoW | |
| Shadow Knight | — | Corpse summon on "summon" |
| Shaman | HP, Regen, Proc, Haste, SoW | Talisman/Unity combo spells (all ranges) |
| Wizard | — | Ports (Translocate) |

## Features

- Casts level-appropriate buffs for level ranges: 1–45, 46–60, 61–70, 71–84, 85+
- **Combo spell support** — Shaman and Cleric can use single Unity/Unified Hand spells that cover multiple buff effects in one cast, with a per-range checkbox in the GUI
- Spell rank auto-resolution — automatically uses Rk. III > Rk. II > base when memming and casting
- Spell book validation on REBUILD — warns about any selected spells not in your spell book
- Per-character INI settings with automatic migration when version changes
- Account/balance system — charge players per buff, track balances, stop buffing if they can't pay
- Advertising mode — announces available commands when enabled
- Ports list built from your spell book automatically (Druid/Wizard)

## Commands (say or tell the bot)

| Who hears it | Command | Action |
|---|---|---|
| All | `hail` | Level-appropriate buffs |
| Druid / Wizard | `ports` | Port to a destination |
| Magician | `toys` | Summon pet toys |
| Magician | `toys N` (1–20) | Summon N pet toys |
| Magician | `invis` | Summon invis stone |
| Magician | `arrows` | Summon quiver/arrows |
| Magician | `rod` | Summon mod rod |
| Magician | `drod` | Summon damage rod |
| Magician | `other` | Summon invis stone, lev ring, mod rod, damage rod |
| Cleric | `rez` | Resurrect |
| Necromancer / Shadow Knight | `summon` | Summon corpse |

## Installation

1. Copy the `BuffBot` folder to your MacroQuest `lua` directory.
2. In-game: `/lua run BuffBot`
3. Configure spells and options in the GUI that opens.

Settings are saved per character to `config\BuffBot\Settings\BuffBot_<Name>_<Class>.ini`.

## Contributing

Fork the repo and submit pull requests. Open an issue for bugs, spell list corrections, or feature requests.

## Links

- [MacroQuest Lua Documentation](https://docs.macroquest.org/lua/)
- [RedGuides](https://www.redguides.com/community/)
- [RedGuides Discord](https://www.redguides.com/community/rg-discord/)
