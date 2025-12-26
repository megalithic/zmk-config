# Homerow Mods Guide

Homerow mods place modifier keys (Ctrl, Alt, Shift, Cmd) on the home row, activated by holding instead of tapping. This keeps your fingers on the home row while accessing modifiers.

## What Are Homerow Mods?

Instead of reaching for modifier keys, you hold home row keys:

```
Standard typing:  tap A = 'a'
With homerow mod: hold A = Left GUI (Cmd)
                  tap A = 'a'
```

## Why Use Homerow Mods?

- **Ergonomics**: No reaching for corner modifier keys (reduces pinky strain)
- **Speed**: Modifiers are instantly accessible without moving hands
- **All modifiers available**: Ctrl+Shift+Alt+Cmd combos become trivial
- **Enables smaller keyboards**: Essential for 34-40 key layouts

## Modifier Order Options

The order you place modifiers on the home row matters. Common arrangements:

### GACS (Gui-Alt-Ctrl-Shift) - Recommended for Windows/Linux

```
Left:   A=Gui  S=Alt  D=Ctrl  F=Shift
Right:  J=Shift  K=Ctrl  L=Alt  ;=Gui
```

- Most frequently used mods (Shift, Ctrl) on strongest fingers
- Used by the popular [Miryoku](https://github.com/manna-harbour/miryoku) layout

### GASC (Gui-Alt-Shift-Ctrl)

```
Left:   A=Gui  S=Alt  D=Shift  F=Ctrl
Right:  J=Ctrl  K=Shift  L=Alt  ;=Gui
```

- Shift+Ctrl are adjacent for easy chording
- Good for Ctrl+Shift+Letter shortcuts

### CAGS (Ctrl-Alt-Gui-Shift) - Recommended for macOS

```
Left:   A=Ctrl  S=Alt  D=Gui  F=Shift
Right:  J=Shift  K=Gui  L=Alt  ;=Ctrl
```

- Command (Gui) in strong middle finger position
- Matches macOS shortcut frequency

## The Problem with Basic Hold-Tap

The default `&mt` (mod-tap) behavior often causes misfires:
- Typing "as" quickly might trigger Alt+S instead
- Rolling keys (common in fast typing) triggers holds unexpectedly
- You must hold for exactly the right duration

## "Timeless" Homerow Mods (Recommended)

The "timeless" configuration, popularized by [urob's zmk-config](https://github.com/urob/zmk-config), minimizes timing sensitivity. The key insight: set a very long `tapping-term-ms` but use other options to short-circuit decisions.

### How It Works

1. **`balanced` flavor**: Triggers "hold" when another key is pressed AND released (not just pressed)
2. **`require-prior-idle-ms`**: If you just typed something, immediately produce a tap (no delay)
3. **Positional hold-tap**: Only trigger hold for keys on the *opposite* hand
4. **`hold-trigger-on-release`**: Wait until next key is released to decide (allows combining mods)

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
      hold-trigger-key-positions = <6 7 8 9 10 11 18 19 20 21 22 23 30 31 32 33 34 35 42 43 44 45 46 47 53 54 55 56 57>;
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
      hold-trigger-key-positions = <0 1 2 3 4 5 12 13 14 15 16 17 24 25 26 27 28 29 36 37 38 39 40 41 48 49 50 51 52>;
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

## Configuration Options Reference

| Option | Purpose | Recommended |
|--------|---------|-------------|
| `flavor` | How to decide hold vs tap | `balanced` |
| `tapping-term-ms` | Max time before becoming a mod | 280ms |
| `quick-tap-ms` | Double-tap always produces tap | 175ms |
| `require-prior-idle-ms` | Tap immediately if typed recently | 150ms |
| `hold-trigger-key-positions` | Only trigger hold for these keys | Opposite hand |
| `hold-trigger-on-release` | Delay decision until key release | Yes |

### Flavor Comparison

| Flavor | Behavior | Use Case |
|--------|----------|----------|
| `hold-preferred` | Hold on any interrupting key press | Ctrl/Esc key |
| `balanced` | Hold when interrupt key pressed AND released | **Homerow mods** |
| `tap-preferred` | Only timing determines hold vs tap | Layer-taps |
| `tap-unless-interrupted` | Tap unless key pressed during term | Rarely used |

### Calculating `require-prior-idle-ms`

Formula: `10500 / your_WPM`

| WPM | Recommended Value |
|-----|-------------------|
| 60 | 175ms |
| 70 | 150ms |
| 80 | 130ms |
| 100 | 105ms |

If you type faster, you can use a lower value. If you get misfires, increase it.

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

**Left-hand HRMs** (`hml`): trigger on right side positions
```
6 7 8 9 10 11 18 19 20 21 22 23 30 31 32 33 34 35 42 43 44 45 46 47 53 54 55 56 57
```

**Right-hand HRMs** (`hmr`): trigger on left side positions
```
0 1 2 3 4 5 12 13 14 15 16 17 24 25 26 27 28 29 36 37 38 39 40 41 48 49 50 51 52
```

## Alternative Approaches

### Index Finger Only (Easiest Start)

If full homerow mods feel like too much, start with just Shift on index fingers:

```dts
&hml LSHFT F    // Left index: tap=F, hold=Shift
&hmr RSHFT J    // Right index: tap=J, hold=Shift
```

This is less prone to misfires and easier to learn. Add other mods later.

### Callum-Style Mods (No Timing Issues)

Instead of hold-tap, use a dedicated thumb key to activate a modifier layer:

```dts
// Thumb key activates mod layer
&mo MOD_LAYER

// On MOD_LAYER, home row becomes pure modifiers
&kp LGUI  &kp LALT  &kp LCTRL  &kp LSHFT  ...
```

Pros:
- No timing/misfire issues
- Predictable behavior

Cons:
- Requires dedicated thumb key
- Sequential (layer then mod) instead of simultaneous

### Thumb Shift + Reduced HRMs

Use a sticky-shift or regular shift on thumb for capitalizing letters. Then only use HRMs for Ctrl, Alt, and Gui:

```dts
// Thumb
&sk LSHFT  // Sticky shift for capitals

// Home row (no Shift HRM)
&hml LGUI A   &hml LALT S   &hml LCTRL D   &kp F   // F is just F
```

This avoids the most common misfire scenario (Shift during fast typing).

## Troubleshooting

### Problem: Typing delay when tapping HRMs

**Symptom**: Noticeable pause before letters appear

**Solutions**:
- Increase `require-prior-idle-ms` (try 175-200ms)
- Check your typing speed and use the formula above

### Problem: Accidental modifier activation (same hand)

**Symptom**: Typing "df" produces Ctrl+F

**Solutions**:
- Ensure `hold-trigger-key-positions` only includes opposite hand
- Add `hold-trigger-on-release;`
- Increase `tapping-term-ms` (try 300-320ms)

### Problem: Accidental modifier activation (cross hand)

**Symptom**: Typing "fj" produces Shift+J

**Solutions**:
- Increase `require-prior-idle-ms`
- Try `tap-preferred` flavor (but you'll need to hold past tapping-term)

### Problem: Can't trigger mods when I want to

**Symptom**: Holding doesn't activate modifier

**Solutions**:
- Decrease `tapping-term-ms` (try 240-260ms)
- Decrease `require-prior-idle-ms` (try 100-125ms)
- Make sure you're pressing opposite hand keys

### Problem: Can't combine multiple modifiers

**Symptom**: Ctrl+Shift doesn't work

**Solutions**:
- Add `hold-trigger-on-release;` to behavior
- Include thumb keys in `hold-trigger-key-positions`

## Tips for Learning Homerow Mods

1. **Start with just Shift** - Add Ctrl, Alt, Gui one at a time over weeks
2. **Practice deliberately** - Spend 10 min/day focusing on modifier usage
3. **Use a typing tutor** - Sites like keybr.com help build muscle memory
4. **Quick, swift taps** - Don't linger on keys; tap briskly
5. **Consider thumb shift** - Use sticky-shift on thumb for capitals
6. **Disable for gaming** - Create a gaming layer without HRMs
7. **Be patient** - It takes 1-2 weeks to feel natural, 4+ weeks to master

## Gaming Considerations

Homerow mods and games don't mix well (WASD movement triggers mods). Solutions:

1. **Gaming layer**: Create a layer without HRMs, activate before gaming
2. **Dedicated gaming profile**: Use a separate Bluetooth profile with different firmware
3. **Toggle behavior**: Add a key to globally disable HRMs

## References

- [ZMK Hold-Tap Documentation](https://zmk.dev/docs/keymaps/behaviors/hold-tap)
- [Precondition's Homerow Mods Guide](https://precondition.github.io/home-row-mods) - Comprehensive guide (QMK-focused but concepts apply)
- [urob's zmk-config](https://github.com/urob/zmk-config) - Popular "timeless" HRM implementation
- [ZMK Discord](https://zmk.dev/community/discord/invite) - Great for getting help
