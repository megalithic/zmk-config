# [Leeloo](https://clicketysplit.ca/pages/leeloo)

_NOTE:_ this is definitely a WIP as I continue to document and define my keymaps.

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
                    │  ⌥  │  ⌘  │SP/L2│╭─────╮│    │╭─────╮│ SP  │ BSP │ DEL │
                    ╰─────┴─────┴─────┤│ F19 ││    ││RT/L2│├─────┴─────┴─────╯
                                      │╰─────╯│    │╰─────╯│
                                      ╰───────╯    ╰───────╯
  (REFERENCE)
  ⌘ Command (or Cmd)
  ⇧ Shift
  ⌥ Option (or Alt)
  ⌃ Control (or Ctrl)
  ⎋ Escape (or Esc)
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
                    │     │     │     │╭─────╮│    │╭─────╮│     │     │     │
                    ╰─────┴─────┴─────┤│     ││    ││ TD1 │├─────┴─────┴─────╯
                                      │╰─────╯│    │╰─────╯│
                                      ╰───────╯    ╰───────╯
  (MACROS)
  W→  LA(RIGHT)
  W←  LA(LEFT)

  (TAP DANCE)
  TD1 td_SCRNSHT

  (REFERENCE)
  ⌘   Command (or Cmd)
  ⇧   Shift
  ⌥   Option (or Alt)
  ⌃   Control (or Ctrl)
  ⎋   Escape (or Esc)
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
                    │     │     │     │╭─────╮│    │╭─────╮│     │     │     │
                    ╰─────┴─────┴─────┤│     ││    ││ TD1 │├─────┴─────┴─────╯
                                      │╰─────╯│    │╰─────╯│
                                      ╰───────╯    ╰───────╯
  (MACROS)
  W→  LA(RIGHT)
  W←  LA(LEFT)

  (TAP DANCE)
  TD1 td_SCRNSHT

  (REFERENCE)
  ⌘   Command (or Cmd)
  ⇧   Shift
  ⌥   Option (or Alt)
  ⌃   Control (or Ctrl)
  ⎋   Escape (or Esc)
```

</details>

<details>
<summary>Layer 3: <em><strong><code>FIRMWARE</code></strong></em></summary>

```devicetree
  ╭─────┬─────┬─────┬─────┬─────┬─────┬───────╮    ╭───────┬─────┬─────┬─────┬─────┬─────┬─────╮
  │     │     │     │     │     │     │       │    │       │     │     │     │     │     │     │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │     │     │     │     │       │    │       │     │     │     │     │     │     │
  ├─────┼─────┼─────┼─────┼─────┼─────┤       │    │       ├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │     │     │     │     │       │    │       │     │     │     │     │     │     │
  ├─────┼─────┼─────┼─────┼─────┼─────┤╭─────╮│    │╭─────╮├─────┼─────┼─────┼─────┼─────┼─────┤
  │     │     │     │     │     │     ││     ││    ││     ││     │     │     │     │     │     │
  ╰─────┴─────┴─────┼─────┼─────┼─────┤╰─────╯│    │╰─────╯├─────┼─────┼─────┼─────┴─────┴─────╯
                    │     │     │     │╭─────╮│    │╭─────╮│     │     │     │
                    ╰─────┴─────┴─────┤│     ││    ││     │├─────┴─────┴─────╯
                                      │╰─────╯│    │╰─────╯│
                                      ╰───────╯    ╰───────╯
  (REFERENCE)
  ⌘ Command (or Cmd)
  ⇧ Shift
  ⌥ Option (or Alt)
  ⌃ Control (or Ctrl)
  ⎋ Escape (or Esc)
```

</details>

### Attribution

- Big up to Joey at [Clickety Split](https://clicketysplit.ca) for crafting this split!
- Equally huge thanks to [@evantravers](https://evantravers.com) for his vast wealth of knowledge in all things keebs, qmk, zmk, vim, and the list goes on.
