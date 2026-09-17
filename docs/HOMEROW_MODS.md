# Left home-row mods

Active configuration lives in `config/leeloo.keymap` under `hml: home_row_mod_left`.

## Current mapping

| Key | Tap | Hold |
| --- | --- | --- |
| A | A | Left GUI/Command |
| S | S | Left Shift |
| D | D | Left Alt/Option |

The right-hand `hmr` behavior is defined for reference but is not bound on the active QWERTY layer.

## Current timing

```dts
hml: home_row_mod_left {
  compatible = "zmk,behavior-hold-tap";
  #binding-cells = <2>;
  flavor = "balanced";
  tapping-term-ms = <350>;
  quick-tap-ms = <200>;
  require-prior-idle-ms = <200>;
  bindings = <&kp>, <&kp>;
  hold-trigger-key-positions = <
    6 7 8 9 10 11
    18 19 20 21 22 23
    30 31 32 33 34 35
    43 44 45 46 47 48 49
    54 55 56 57
  >;
  hold-trigger-on-release;
};
```

These values deliberately favor taps over holds:

- `tapping-term-ms = <350>` requires a longer solo hold before A becomes Command.
- `quick-tap-ms = <200>` keeps repeated taps as letters.
- `require-prior-idle-ms = <200>` forces a tap when the home-row key follows recent typing.
- Opposite-hand trigger positions prevent same-hand rolls from resolving an early hold.
- `hold-trigger-on-release` permits modifier combinations while retaining positional filtering.

## Why Command can still misfire

The `balanced` flavor can resolve a hold before 350 ms when another key is pressed and released while A remains down. Increasing only `tapping-term-ms` cannot prevent every cross-hand roll from becoming Command.

Test common A-leading words after flashing. If accidental Command shortcuts remain, change only left `hml` to:

```dts
flavor = "tap-preferred";
```

`tap-preferred` ignores interrupting keys during the tapping term. Tradeoff: deliberate Command chords require holding A past 350 ms before pressing the shortcut key.

## Tuning order

1. Start with balanced `350/200/200`.
2. Increase `require-prior-idle-ms` to 225 ms if fast typing still causes holds.
3. Change `hml` to `tap-preferred` if cross-hand rolls still trigger Command.
4. Reduce `tapping-term-ms` only if deliberate modifiers feel too slow.

Change one setting at a time, build, flash both halves from the same run, and test before adjusting again.

## Leeloo position map

Positions follow the 58 bindings in `config/leeloo.keymap`:

```text
Left half                           Right half
 0  1  2  3  4  5                   6  7  8  9 10 11
12 13 14 15 16 17                  18 19 20 21 22 23
24 25 26 27 28 29                  30 31 32 33 34 35
36 37 38 39 40 41 42            43 44 45 46 47 48 49
             50 51 52 53        54 55 56 57
```

Left home-row modifiers list only right-side positions in `hold-trigger-key-positions`.

## Verification

After flashing:

1. Tap A, S, and D normally. Each should emit its letter immediately during normal typing.
2. Type A-leading words and cross-hand rolls repeatedly.
3. Hold A, then invoke a Command shortcut with the opposite hand.
4. Confirm S produces Shift and D produces Option only when intentionally held.

## References

- [ZMK hold-tap behavior](https://zmk.dev/docs/keymaps/behaviors/hold-tap)
- [Precondition's home-row mods guide](https://precondition.github.io/home-row-mods)
- [urob's ZMK configuration](https://github.com/urob/zmk-config)
