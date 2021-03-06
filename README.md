# [Leeloo](https://clicketysplit.ca/pages/leeloo)

_NOTE:_ this is definitely a WIP as I continue to document and define my keymaps.

### Build/Flash

Builds and flashes zmk firmware via Docker.

```sh
# WIP (do not use this yet):
make build        # Build only [alias: make b]
make flash-left   # Build and flash left [alias: make l]
make flash-right  # Build and flash right [alias: make r]
```

### Macros

> Coming soon

### Layout

#### Layer 0: _`DEFAULT`_

```devicetree
  ╭─────┬─────┬─────┬─────┬─────┬─────┬───────╮    ╭───────┬─────┬─────┬─────┬─────┬─────┬─────╮
  │  `~ │  1! │  2@ │  3# │  4$ │  5% │       │    │       │ 6^  │ 7&  │ 8*  │ 9(  │ 0)  │ -_  │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │ TAB │  Q  │  W  │  E  │  R  │  T  │       │    │       │  Y  │  U  │  I  │  O  │  P  │ \|  │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │ LC/⎋│  A  │  S  │  D  │ F/L2│  G  │       │    │       │  H  │  J  │  K  │  L  │ ;:  │ '"  │
  ├─────┼─────┼─────┼─────┼─────┼─────┤╭─────╮│    │╭─────╮├─────┼─────┼─────┼─────┼─────┼─────┤
  │ LSH │  Z  │  X  │  C  │  V  │  B  ││  L3 ││    ││ L3  ││  N  │  M  │ ,<  │ .>  │ /?  │ RSH │
  ╰─────┴─────┴─────┼─────┼─────┼─────┤╰─────╯│    │╰─────╯├─────┼─────┼─────┼─────┴─────┴─────╯
                    │  ⌥  │  ⌘  │SP/L1│╭─────╮│    │╭─────╮│ SPC │ BSP │ DEL │
                    ╰─────┴─────┴─────┤│ F19 ││    ││ENTER│├─────┴─────┴─────╯
                                      │╰─────╯│    │╰─────╯│
                                      ╰───────╯    ╰───────╯
  [LAYERS]
  L1  LOWER (QW_L)
  L2  RAISE (QW_R)
  L3  FIRMWARE (QW_F)

  [REFERENCE]
  ⌘   Command (or CMD/LGUI/LG)
  ⇧   Shift (or SH/LSH/RSH)
  ⌥   Option (or OPT/ALT/LA)
  ⌃   Control (or CTRL/LC)
  ⎋   Escape (or ESC)
```

<details>
<summary>Layer 1: <em><strong><code>LOWER</code></strong></em></summary>

```devicetree
  ╭─────┬─────┬─────┬─────┬─────┬─────┬───────╮    ╭───────┬─────┬─────┬─────┬─────┬─────┬─────╮
  │     │  F1 │  F2 │  F3 │  F4 │  F5 │       │    │       │ F6  │ F7  │ F8  │ F9  │ F10 │ =+  │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │  W→ │     │     │     │       │    │       │     │     │     │ [{  │ ]}  │     │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │     │     │     │     │       │    │       │  ←  │  ↓  │  ↑  │  →  │     │     │
  ├─────┼─────┼─────┼─────┼─────┼─────┤╭─────╮│    │╭─────╮├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │     │     │     │  W← ││     ││    ││     ││     │     │     │     │     │     │
  ╰─────┴─────┴─────┼─────┼─────┼─────┤╰─────╯│    │╰─────╯├─────┼─────┼─────┼─────┴─────┴─────╯
                    │  ⌥  │  ⌘  │ SPC │╭─────╮│    │╭─────╮│     │     │     │
                    ╰─────┴─────┴─────┤│     ││    ││ENTER│├─────┴─────┴─────╯
                                      │╰─────╯│    │╰─────╯│
                                      ╰───────╯    ╰───────╯
  [MACROS]
  W→    LA(RIGHT)
  W←    LA(LEFT)

  [TAP DANCE]
  ~SCRSH td_SCRNSHT~

  [REFERENCE]
  ⌘     Command (or CMD/LGUI/LG)
  ⇧     Shift (or SH/LSH/RSH)
  ⌥     Option (or OPT/ALT/LA)
  ⌃     Control (or CTRL/LC)
  ⎋     Escape (or ESC)
```

</details>

<details>
<summary>Layer 2: <em><strong><code>RAISE</code></strong></em></summary>

```devicetree
  ╭─────┬─────┬─────┬─────┬─────┬─────┬───────╮    ╭───────┬─────┬─────┬─────┬─────┬─────┬─────╮
  │     │  F1 │  F2 │  F3 │  F4 │  F5 │       │    │       │ F6  │ F7  │ F8  │ F9  │ F10 │ =+  │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │  W→ │     │     │     │       │    │       │     │VOLM │VOL↓ │VOL↑ │NT/PR│PL/PA│
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │     │     │     │     │       │    │       │  ←  │  ↓  │  ↑  │  →  │     │     │
  ├─────┼─────┼─────┼─────┼─────┼─────┤╭─────╮│    │╭─────╮├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │     │     │     │  W← ││     ││    ││     ││     │     │     │     │     │     │
  ╰─────┴─────┴─────┼─────┼─────┼─────┤╰─────╯│    │╰─────╯├─────┼─────┼─────┼─────┴─────┴─────╯
                    │  ⌥  │  ⌘  │ SPC │╭─────╮│    │╭─────╮│     │     │     │
                    ╰─────┴─────┴─────┤│     ││    ││ENTER│├─────┴─────┴─────╯
                                      │╰─────╯│    │╰─────╯│
                                      ╰───────╯    ╰───────╯
  [MACROS]
  W→    LA(RIGHT)
  W←    LA(LEFT)

  [TAP DANCE]
  ~SCRSH td_SCRNSHT~
  NT/PR td_NEXT_PREV

  [REFERENCE]
  ⌘     Command (or CMD/LGUI/LG)
  ⇧     Shift (or SH/LSH/RSH)
  ⌥     Option (or OPT/ALT/LA)
  ⌃     Control (or CTRL/LC)
  ⎋     Escape (or ESC)
```
