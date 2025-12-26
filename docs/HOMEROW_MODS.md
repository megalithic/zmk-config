# Homerow Mods Guide

Homerow mods place modifier keys (Ctrl, Alt, Shift, Cmd) on the home row, activated by holding instead of tapping. This keeps your fingers on the home row while accessing modifiers.

## What Are Homerow Mods?

Instead of reaching for modifier keys, you hold home row keys:

```
Standard typing:  tap A = 'a'
With homerow mod: hold A = Left GUI (Cmd)
                  tap A = 'a'
```

## Common Homerow Mod Layout

A typical QWERTY setup (modifiers on ASDF and JKL;):

```
Left Hand (tap / hold):
  A = A / Left GUI (Cmd)
  S = S / Left Alt (Option)
  D = D / Left Ctrl
  F = F / Left Shift

Right Hand (tap / hold):
  J = J / Right Shift
  K = K / Right Ctrl
  L = L / Right Alt (Option)
  ; = ; / Right GUI (Cmd)
```

## The Problem with Basic Hold-Tap

The default `&mt` (mod-tap) behavior often causes misfires:
- Typing "as" quickly might trigger Alt+S instead
- Rolling keys (common in fast typing) triggers holds unexpectedly

## Timeless Homerow Mods (Recommended)

The "timeless" configuration minimizes timing dependency and misfires. It uses:

1. **Balanced flavor** - Resolves on key release, not press
2. **Positional hold-tap** - Only triggers hold when pressing keys on the *opposite* hand
3. **require-prior-idle-ms** - Ignores holds when typing quickly
4. **hold-trigger-on-release** - Allows combining multiple modifiers

### Implementation

Add this to your keymap file:

```dts
/ {
  behaviors {
    // Left hand homerow mods
    hml: home_row_mod_left {
      compatible = "zmk,behavior-hold-tap";
      #binding-cells = <2>;
      flavor = "balanced";
      tapping-term-ms = <280>;
      quick-tap-ms = <175>;
      require-prior-idle-ms = <150>;
      bindings = <&kp>, <&kp>;
      // Key positions on the RIGHT side of the keyboard
      // Adjust these numbers for your specific keyboard layout
      hold-trigger-key-positions = <6 7 8 9 10 11 18 19 20 21 22 23 30 31 32 33 34 35 42 43 44 45 46 47>;
      hold-trigger-on-release;
    };

    // Right hand homerow mods
    hmr: home_row_mod_right {
      compatible = "zmk,behavior-hold-tap";
      #binding-cells = <2>;
      flavor = "balanced";
      tapping-term-ms = <280>;
      quick-tap-ms = <175>;
      require-prior-idle-ms = <150>;
      bindings = <&kp>, <&kp>;
      // Key positions on the LEFT side of the keyboard
      // Adjust these numbers for your specific keyboard layout
      hold-trigger-key-positions = <0 1 2 3 4 5 12 13 14 15 16 17 24 25 26 27 28 29 36 37 38 39 40 41>;
      hold-trigger-on-release;
    };
  };
};
```

### Using in Your Keymap

Replace home row keys with the homerow mod behaviors:

```dts
default_layer {
  bindings = <
    // ... other keys ...
    &hml LGUI A    &hml LALT S    &hml LCTRL D   &hml LSHFT F   // Left hand
    &hmr RSHFT J   &hmr RCTRL K   &hmr LALT L    &hmr RGUI SEMI // Right hand
    // ... other keys ...
  >;
};
```

## Configuration Options Explained

### `flavor`

| Flavor | Behavior |
|--------|----------|
| `hold-preferred` | Hold triggers on any interrupting key press |
| `balanced` | Hold triggers when interrupt key is pressed AND released |
| `tap-preferred` | Only timing determines hold vs tap |
| `tap-unless-interrupted` | Tap unless key pressed during tapping-term |

**Recommendation**: `balanced` for homerow mods

### `tapping-term-ms`

How long to hold before triggering the hold behavior (in milliseconds).

- Default: 200ms
- For homerow mods: 280ms (gives more time, less accidental taps)

### `quick-tap-ms`

If you tap the key again within this time, it always produces a tap. Useful for double-tapping letters.

- Recommended: 175ms

### `require-prior-idle-ms`

If another key was pressed within this time before the hold-tap, it immediately produces a tap. This is the key to avoiding misfires when typing quickly.

- Recommended: 125-175ms

### `hold-trigger-key-positions`

Array of key positions that trigger the hold behavior. For homerow mods, set this to keys on the **opposite** hand.

### `hold-trigger-on-release`

Delays the hold-trigger-key-positions check until key release. Allows combining multiple modifiers on the same hand.

## Key Position Reference for Leeloo

For the Leeloo 4x6+5 layout, positions are numbered left-to-right, top-to-bottom:

```
Left Half:                          Right Half:
 0   1   2   3   4   5              6   7   8   9  10  11
12  13  14  15  16  17             18  19  20  21  22  23
24  25  26  27  28  29             30  31  32  33  34  35
36  37  38  39  40  41             42  43  44  45  46  47
        48  49  50  51  52     53  54  55  56  57
```

For left-hand homerow mods, `hold-trigger-key-positions` should be the right side: `6 7 8 9 10 11 18 19 20 21 22 23 30 31 32 33 34 35 42 43 44 45 46 47 53 54 55 56 57`

For right-hand homerow mods, `hold-trigger-key-positions` should be the left side: `0 1 2 3 4 5 12 13 14 15 16 17 24 25 26 27 28 29 36 37 38 39 40 41 48 49 50 51 52`

## Alternative: Index Finger Only

If full homerow mods feel like too much, try just index fingers:

```dts
// Just F and J as shift
&hml LSHFT F    // Left index
&hmr RSHFT J    // Right index
```

This is less prone to misfires and easier to learn.

## Tips for Learning Homerow Mods

1. **Start slow** - Don't expect to type at full speed immediately
2. **Practice deliberately** - Focus on the modifier usage, not speed
3. **Adjust timing** - If you get misfires, increase `require-prior-idle-ms`
4. **Consider fewer mods** - Start with just Shift, add others later
5. **Be patient** - It takes 1-2 weeks to feel natural

## Troubleshooting

### Too Many Accidental Holds

- Increase `require-prior-idle-ms` (try 175-200ms)
- Increase `tapping-term-ms` (try 300-320ms)
- Ensure `hold-trigger-key-positions` is correct

### Can't Trigger Holds When I Want To

- Decrease `tapping-term-ms` (try 240-260ms)
- Decrease `require-prior-idle-ms` (try 100-125ms)
- Make sure you're pressing the opposite hand key

### Same-Hand Modifiers Don't Work

- Add `hold-trigger-on-release;` to your behavior
- Include same-hand modifier positions in `hold-trigger-key-positions`

## References

- [ZMK Hold-Tap Documentation](https://zmk.dev/docs/keymaps/behaviors/hold-tap)
- [Precondition's Homerow Mods Guide](https://precondition.github.io/home-row-mods)
- [ZMK Discord](https://zmk.dev/community/discord/invite) - Great for getting help
