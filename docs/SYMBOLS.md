# Symbol Layer Design for Programmers and Writers

This guide covers symbol layer design principles, strategies, and specific recommendations
for the Leeloo keyboard. It synthesizes research from popular ZMK configurations (urob,
Miryoku, Sunaku) and community best practices.

## Table of Contents

- [Your Current Setup](#your-current-setup)
- [Design Philosophies](#design-philosophies)
- [For Programmers](#for-programmers)
- [For Writers](#for-writers)
- [Recommended Symbol Layer](#recommended-symbol-layer)
- [ZMK Implementation](#zmk-implementation)
- [Alternative Approaches](#alternative-approaches)
- [References](#references)

---

## Your Current Setup

The Leeloo has 58 keys (4x6+5 per side), which is **more generous** than minimal layouts
like Corne (42 keys) or Miryoku (36 keys). This means:

- You have a dedicated number row (no numpad layer needed)
- Symbols via Shift+number are already available
- Lower/Raise layers can be dedicated to actual functionality

**Current layer usage:**
| Layer | Purpose | Observation |
|-------|---------|-------------|
| 0 (Main) | QWERTY + numbers | Good base layer |
| 1 (Lower) | F-keys, arrows, brackets | Underutilized |
| 2 (Raise) | F-keys, arrows, media | Nearly identical to Lower |
| 3 (Firmware) | BT, bootloader | Good |

**Opportunity:** Lower and Raise are nearly identical. Consider:
- **Lower** → Dedicated symbol layer
- **Raise** → Navigation + media (current media keys work well)

---

## Design Philosophies

### Mirroring (Bracket Symmetry)
Place opening brackets on left hand, closing on right, same finger position:
```
Left Hand        Right Hand
    (       →        )
    [       →        ]
    {       →        }
    <       →        >
```
**Pros:** Intuitive, predictable  
**Cons:** Can't type `()` as a single-hand roll

### Clustering (Functional Groups)
Group related symbols together:
- Math operators: `+ - * / = %`
- Brackets: `() [] {} <>`
- String delimiters: `" ' \``
- Logical operators: `& | ! ^`

### Frequency-Based Placement
Most-used symbols on strongest fingers (index, middle):

| Finger Strength | Best For |
|-----------------|----------|
| Index | `= - _ ( )` |
| Middle | `[ ] { }` |
| Ring | `< > $ %` |
| Pinky | Rarely used: `~ \` |` |

### Mnemonic Placement
Symbols where they "make sense":
- `$` on D/S (Dollar)
- `%` on P (Percent)
- `#` on H (Hash)
- `@` on A (At)

---

## For Programmers

### Symbol Frequency by Language

**Most Common Across All Languages:**
```
= ( ) ; : _ - + * / { } [ ] " ' < >
```

**Language-Specific Priorities:**

| Language | High Priority | Unique Needs |
|----------|--------------|--------------|
| JavaScript/TS | `=>` `===` `${}` | Template literals, arrow functions |
| Python | `:` `_` `#` `**` | Indentation-based, snake_case |
| Rust | `::` `->` `&` `'` `<>` | Lifetimes, references, generics |
| Go | `:=` `{}` | Short declaration |
| Ruby | `@` `#{}` `\|` | Instance vars, string interpolation |
| Shell | `$` `\|` `>` `<` `&` | Pipes, redirection |

### Recommended Programmer Symbol Layer

Optimized for inward rolls and common bigrams:

```
┌──────┬──────┬──────┬──────┬──────┬──────┐   ┌──────┬──────┬──────┬──────┬──────┬──────┐
│  ~   │  !   │  @   │  #   │  $   │  %   │   │  ^   │  &   │  *   │  `   │      │      │
├──────┼──────┼──────┼──────┼──────┼──────┤   ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │  <   │  [   │  {   │  (   │  +   │   │  =   │  )   │  }   │  ]   │  >   │  |   │
├──────┼──────┼──────┼──────┼──────┼──────┤   ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │      │      │  _   │  -   │      │   │      │  :   │  ;   │      │  \   │      │
└──────┴──────┴──────┴──────┴──────┴──────┘   └──────┴──────┴──────┴──────┴──────┴──────┘
```

**Design Rationale:**
1. **Top row** mirrors Shift+number positions (muscle memory)
2. **Home row** has ALL brackets in nesting order: `< [ { (` → `) } ] >`
3. **Index fingers** get `( )` - most frequent brackets
4. **Bottom row** has `_ -` on strong left fingers (snake_case, kebab-case)
5. **Colon/semicolon** on right index (statement terminators)

### Useful Macros for Programmers

```c
// Arrow function =>
ZMK_MACRO(arrow_fn,
    bindings = <&kp EQUAL &kp GT>;
)

// Double colon :: (Rust/C++)
ZMK_MACRO(dbl_colon,
    bindings = <&kp COLON &kp COLON>;
)

// Template literal ${} with cursor inside
ZMK_MACRO(template_lit,
    bindings = <&kp DLLR &kp LBRC &kp RBRC &kp LEFT>;
)

// Triple equals ===
ZMK_MACRO(triple_eq,
    bindings = <&kp EQUAL &kp EQUAL &kp EQUAL>;
)

// Not equals !==
ZMK_MACRO(not_eq,
    bindings = <&kp EXCL &kp EQUAL &kp EQUAL>;
)
```

### Tap-Dance for Related Symbols

```c
// Single tap: = | Double tap: ==
ZMK_TAP_DANCE(td_eq,
    bindings = <&kp EQUAL>, <&dbl_eq>;
)

// Single tap: & | Double tap: &&
ZMK_TAP_DANCE(td_amp,
    bindings = <&kp AMPS>, <&dbl_amp>;
)

// Single tap: | | Double tap: ||
ZMK_TAP_DANCE(td_pipe,
    bindings = <&kp PIPE>, <&dbl_pipe>;
)
```

---

## For Writers

### Typography Characters

Writers benefit from easy access to typographically correct characters:

| Character | Name | macOS Shortcut | Unicode |
|-----------|------|----------------|---------|
| " | Left double quote | `Opt+[` | U+201C |
| " | Right double quote | `Opt+Shift+[` | U+201D |
| ' | Left single quote | `Opt+]` | U+2018 |
| ' | Right single quote / apostrophe | `Opt+Shift+]` | U+2019 |
| — | Em dash | `Opt+Shift+-` | U+2014 |
| – | En dash | `Opt+-` | U+2013 |
| … | Ellipsis | `Opt+;` | U+2026 |
| « » | Guillemets | `Opt+\` / `Opt+Shift+\` | U+00AB/BB |

### ZMK Macros for Typography

```c
// Em dash (—) - for interruptions, parenthetical statements
em_dash: em_dash {
    compatible = "zmk,behavior-macro";
    #binding-cells = <0>;
    bindings = <&kp LA(LS(MINUS))>;
};

// En dash (–) - for ranges (1–10)
en_dash: en_dash {
    compatible = "zmk,behavior-macro";
    #binding-cells = <0>;
    bindings = <&kp LA(MINUS)>;
};

// Ellipsis (…)
ellipsis: ellipsis {
    compatible = "zmk,behavior-macro";
    #binding-cells = <0>;
    bindings = <&kp LA(SEMI)>;
};

// Left double curly quote (")
l_dquote: l_dquote {
    compatible = "zmk,behavior-macro";
    #binding-cells = <0>;
    bindings = <&kp LA(LBKT)>;
};

// Right double curly quote (")
r_dquote: r_dquote {
    compatible = "zmk,behavior-macro";
    #binding-cells = <0>;
    bindings = <&kp LA(LS(LBKT))>;
};
```

### Writer's Navigation Layer

Writers benefit from word/line/paragraph navigation:

```
┌──────┬──────┬──────┬──────┬──────┬──────┐   ┌──────┬──────┬──────┬──────┬──────┬──────┐
│      │      │      │      │      │      │   │      │      │      │      │      │      │
├──────┼──────┼──────┼──────┼──────┼──────┤   ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │ Undo │ Cut  │ Copy │Paste │ Redo │   │ Home │ PgDn │ PgUp │ End  │      │      │
├──────┼──────┼──────┼──────┼──────┼──────┤   ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │ SelA │      │ W←   │ W→   │      │   │  ←   │  ↓   │  ↑   │  →   │      │      │
├──────┼──────┼──────┼──────┼──────┼──────┤   ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │      │      │ L←   │ L→   │      │   │ Doc↑ │      │      │ Doc↓ │      │      │
└──────┴──────┴──────┴──────┴──────┴──────┘   └──────┴──────┴──────┴──────┴──────┴──────┘

Legend:
  W← = Word Left (Opt+←)      W→ = Word Right (Opt+→)
  L← = Line Start (Cmd+←)     L→ = Line End (Cmd+→)
  Doc↑ = Document Start       Doc↓ = Document End
  SelA = Select All
```

### Macros for Navigation

```c
#define WORD_LEFT  LA(LEFT)
#define WORD_RIGHT LA(RIGHT)
#define LINE_START LG(LEFT)
#define LINE_END   LG(RIGHT)
#define DOC_START  LG(UP)
#define DOC_END    LG(DOWN)
#define SEL_ALL    LG(A)
#define UNDO       LG(Z)
#define REDO       LG(LS(Z))
#define CUT        LG(X)
#define COPY       LG(C)
#define PASTE      LG(V)
```

---

## Recommended Symbol Layer

Here's a **unified symbol layer** that works for both programmers and writers:

### ASCII Diagram

```
LOWER LAYER (Symbol Layer) - Hold Space
┌──────┬──────┬──────┬──────┬──────┬──────┐   ┌──────┬──────┬──────┬──────┬──────┬──────┐
│  ~   │  !   │  @   │  #   │  $   │  %   │   │  ^   │  &   │  *   │  `   │  —   │  =   │
├──────┼──────┼──────┼──────┼──────┼──────┤   ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │  <   │  [   │  {   │  (   │  +   │   │  =   │  )   │  }   │  ]   │  >   │  |   │
├──────┼──────┼──────┼──────┼──────┼──────┤   ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │      │  …   │  _   │  -   │  =>  │   │  ::  │  :   │  ;   │  –   │  \   │      │
├──────┼──────┼──────┼──────┼──────┼──────┤   ├──────┼──────┼──────┼──────┼──────┼──────┤
│      │      │      │      │ ▓▓▓▓ │      │   │      │      │      │      │      │      │
└──────┴──────┴──────┴──────┴──────┴──────┘   └──────┴──────┴──────┴──────┴──────┴──────┘

Key Features:
- Top row: Standard shifted number row (muscle memory)
- Home row: ALL brackets in nesting order, plus operators
- Bottom row: Underscores, dashes, macros for => and ::
- Writer extras: Em dash (—), en dash (–), ellipsis (…)
```

### Layer Positions Reference

```
Position Map (for combos/behaviors):
┌──────┬──────┬──────┬──────┬──────┬──────┐   ┌──────┬──────┬──────┬──────┬──────┬──────┐
│  0   │  1   │  2   │  3   │  4   │  5   │   │  6   │  7   │  8   │  9   │  10  │  11  │
├──────┼──────┼──────┼──────┼──────┼──────┤   ├──────┼──────┼──────┼──────┼──────┼──────┤
│  12  │  13  │  14  │  15  │  16  │  17  │   │  18  │  19  │  20  │  21  │  22  │  23  │
├──────┼──────┼──────┼──────┼──────┼──────┤   ├──────┼──────┼──────┼──────┼──────┼──────┤
│  24  │  25  │  26  │  27  │  28  │  29  │   │  30  │  31  │  32  │  33  │  34  │  35  │
├──────┼──────┼──────┼──────┼──────┼──────┤   ├──────┼──────┼──────┼──────┼──────┼──────┤
│  36  │  37  │  38  │  39  │  40  │  41  │   │  42  │  43  │  44  │  45  │  46  │  47  │
└──────┴──────┴──────┴──────┴──────┴──────┘   └──────┴──────┴──────┴──────┴──────┴──────┘
                    ┌──────┬──────┬──────┬──────┬──────┐   ┌──────┬──────┬──────┬──────┬──────┐
     Thumbs:        │  48  │  49  │  50  │  51  │  52  │   │  53  │  54  │  55  │  56  │  57  │
                    └──────┴──────┴──────┴──────┴──────┘   └──────┴──────┴──────┴──────┴──────┘
```

---

## ZMK Implementation

### Complete Symbol Layer Code

Add these macros to your keymap:

```c
// ( MACROS ) ------------------------------------------------------------------
// Existing macros
#define SCRN   LG(LS(LC(N4)))
#define SCR2   LG(LS(N4))
#define WLEFT  LA(LEFT)
#define WRIGHT LA(RIGHT)

// Typography macros (for writers)
#define EM_DASH    LA(LS(MINUS))  // —
#define EN_DASH    LA(MINUS)       // –
#define ELLIPSIS   LA(SEMI)        // …
```

Add these behaviors:

```c
behaviors {
    // ... existing behaviors ...

    // Arrow function macro: =>
    arrow_fn: arrow_fn {
        compatible = "zmk,behavior-macro";
        #binding-cells = <0>;
        bindings = <&kp EQUAL>, <&kp GT>;
    };

    // Double colon macro: ::
    dbl_colon: dbl_colon {
        compatible = "zmk,behavior-macro";
        #binding-cells = <0>;
        bindings = <&kp COLON>, <&kp COLON>;
    };
};
```

Replace your lower_layer with:

```c
lower_layer { // Symbol Layer
    bindings = <
&kp TILDE  &kp EXCL   &kp AT       &kp HASH   &kp DLLR   &kp PRCNT                    &kp CARET  &kp AMPS   &kp STAR   &kp GRAVE  &kp EM_DASH  &kp EQUAL
&trans     &kp LT     &kp LBKT     &kp LBRC   &kp LPAR   &kp PLUS                     &kp EQUAL  &kp RPAR   &kp RBRC   &kp RBKT   &kp GT       &kp PIPE
&trans     &trans     &kp ELLIPSIS &kp UNDER  &kp MINUS  &arrow_fn                    &dbl_colon &kp COLON  &kp SEMI   &kp EN_DASH &kp BSLH    &trans
&trans     &trans     &trans       &trans     &trans     &trans                       &trans     &trans     &trans     &trans     &trans       &trans
                      &trans       &trans     &trans     &trans     &trans   &trans   &trans     &trans     &trans     &trans
    >;
};
```

---

## Alternative Approaches

### urob's Combo-Based Approach

Instead of a symbol layer, use **vertical combos**:

```c
// Top + Middle row = shifted number symbols
// W + R = @   (positions 2 + 14)
// F + S = #   (positions 3 + 15)
// etc.

combos {
    compatible = "zmk,combos";
    
    combo_at {
        timeout-ms = <30>;
        key-positions = <2 14>;   // W + R position
        bindings = <&kp AT>;
        require-prior-idle-ms = <150>;
    };
    
    combo_hash {
        timeout-ms = <30>;
        key-positions = <3 15>;   // F + S position
        bindings = <&kp HASH>;
        require-prior-idle-ms = <150>;
    };
    
    // Horizontal combos for brackets
    combo_lpar {
        timeout-ms = <20>;
        key-positions = <19 20>;  // J + K position
        bindings = <&kp LPAR>;
    };
    
    combo_rpar {
        timeout-ms = <20>;
        key-positions = <20 21>;  // K + L position
        bindings = <&kp RPAR>;
    };
};
```

**Pros:** Symbols always accessible without layer  
**Cons:** Requires precise timing; accidental triggers possible

### Mod-Morph for Related Symbols

Make Shift change a symbol to its "related" version:

```c
// Tap: , | Shift+tap: ;
comma_semi: comma_semicolon {
    compatible = "zmk,behavior-mod-morph";
    #binding-cells = <0>;
    bindings = <&kp COMMA>, <&kp SEMI>;
    mods = <(MOD_LSFT|MOD_RSFT)>;
};

// Tap: . | Shift+tap: :
dot_colon: dot_colon {
    compatible = "zmk,behavior-mod-morph";
    #binding-cells = <0>;
    bindings = <&kp DOT>, <&kp COLON>;
    mods = <(MOD_LSFT|MOD_RSFT)>;
};

// Tap: ( | Shift+tap: <
lpar_lt: lpar_less_than {
    compatible = "zmk,behavior-mod-morph";
    #binding-cells = <0>;
    bindings = <&kp LPAR>, <&kp LT>;
    mods = <(MOD_LSFT|MOD_RSFT)>;
};
```

### One-Shot Symbol Layer

For occasional symbol entry (useful for writers):

```c
// In behaviors
osl_sym: one_shot_symbol {
    compatible = "zmk,behavior-hold-tap";
    #binding-cells = <2>;
    flavor = "balanced";
    tapping-term-ms = <200>;
    bindings = <&mo>, <&sl>;  // Hold = momentary, Tap = one-shot
};

// In keymap - replace layer key
&osl_sym QW_L QW_L   // Hold for layer, tap for one-shot
```

### Hold-Tap Symbols on Letter Keys (Layer-Free Brackets)

Instead of using a layer for brackets, put symbols directly on letter keys via hold-tap.
This allows **instant bracket access** without activating a layer.

**Concept:**
- **Tap `O`** → `o`
- **Hold `O`** → `[`
- **Shift + Tap `O`** → `O`
- **Shift + Hold `O`** → `{`

#### Implementation Strategy

This requires combining **hold-tap** with **mod-morph** to handle the shifted variants:

```c
behaviors {
    // Mod-morph: [ normally, { when shifted
    lbkt_lbrc: left_bracket_brace {
        compatible = "zmk,behavior-mod-morph";
        #binding-cells = <0>;
        bindings = <&kp LBKT>, <&kp LBRC>;
        mods = <(MOD_LSFT|MOD_RSFT)>;
    };

    // Mod-morph: ] normally, } when shifted
    rbkt_rbrc: right_bracket_brace {
        compatible = "zmk,behavior-mod-morph";
        #binding-cells = <0>;
        bindings = <&kp RBKT>, <&kp RBRC>;
        mods = <(MOD_LSFT|MOD_RSFT)>;
    };

    // Hold-tap: tap = O, hold = [ or { (via mod-morph)
    ht_o: hold_tap_o {
        compatible = "zmk,behavior-hold-tap";
        #binding-cells = <2>;
        tapping-term-ms = <200>;
        flavor = "tap-preferred";
        bindings = <&lbkt_lbrc>, <&kp>;
    };

    // Hold-tap: tap = P, hold = ] or } (via mod-morph)
    ht_p: hold_tap_p {
        compatible = "zmk,behavior-hold-tap";
        #binding-cells = <2>;
        tapping-term-ms = <200>;
        flavor = "tap-preferred";
        bindings = <&rbkt_rbrc>, <&kp>;
    };
};
```

**Usage in keymap:**
```c
// Replace &kp O with:
&ht_o 0 O    // tap = O, hold = [ (or { with shift)

// Replace &kp P with:
&ht_p 0 P    // tap = P, hold = ] (or } with shift)
```

**Note:** The `0` parameter is a dummy value required by hold-tap syntax when using
a behavior that doesn't need parameters (like our mod-morph).

#### Suggested Hold-Tap Symbol Pairings

| Key | Tap | Hold | Shift+Hold | Rationale |
|-----|-----|------|------------|-----------|
| `O` | o | `[` | `{` | "O" looks like brackets |
| `P` | p | `]` | `}` | Adjacent to O, closing bracket |
| `I` | i | `\` | `\|` | Pipe/backslash on right hand |
| `U` | u | `_` | `-` | Underscore (common in code) |
| `9` | 9 | `(` | `<` | Standard paren position |
| `0` | 0 | `)` | `>` | Standard paren position |

#### Full Example: O and P with Brackets

```c
/ {
    behaviors {
        // Mod-morph for [ and {
        mm_lbkt: mod_morph_left_bracket {
            compatible = "zmk,behavior-mod-morph";
            #binding-cells = <0>;
            bindings = <&kp LBKT>, <&kp LBRC>;
            mods = <(MOD_LSFT|MOD_RSFT)>;
        };

        // Mod-morph for ] and }
        mm_rbkt: mod_morph_right_bracket {
            compatible = "zmk,behavior-mod-morph";
            #binding-cells = <0>;
            bindings = <&kp RBKT>, <&kp RBRC>;
            mods = <(MOD_LSFT|MOD_RSFT)>;
        };

        // Hold O for brackets, tap for O
        hto: hold_tap_o_bracket {
            compatible = "zmk,behavior-hold-tap";
            #binding-cells = <2>;
            tapping-term-ms = <200>;
            quick-tap-ms = <150>;
            flavor = "tap-preferred";
            bindings = <&mm_lbkt>, <&kp>;
        };

        // Hold P for brackets, tap for P
        htp: hold_tap_p_bracket {
            compatible = "zmk,behavior-hold-tap";
            #binding-cells = <2>;
            tapping-term-ms = <200>;
            quick-tap-ms = <150>;
            flavor = "tap-preferred";
            bindings = <&mm_rbkt>, <&kp>;
        };
    };

    keymap {
        default_layer {
            bindings = <
                // ... other keys ...
                &hto 0 O   &htp 0 P   // O and P with bracket hold
                // ... other keys ...
            >;
        };
    };
};
```

#### Considerations

**Pros:**
- No layer switching needed for common brackets
- Shift naturally gives you curly braces
- Letters remain easily tappable

**Cons:**
- Slight learning curve
- May feel awkward at first when typing words with O/P
- `quick-tap-ms` helps with repeated letters (e.g., "book" won't trigger brackets)

**Tip:** Set `quick-tap-ms` to allow fast repeated taps without triggering hold.
If you tap O, release, and tap again within 150ms, it will always output `o`.

---

## References

### Popular ZMK Configurations

| Repository | Stars | Key Features |
|------------|-------|--------------|
| [urob/zmk-config](https://github.com/urob/zmk-config) | 1.2k | Timeless HRMs, combos, mod-morph |
| [manna-harbour/miryoku_zmk](https://github.com/manna-harbour/miryoku_zmk) | 593 | Universal 36-key, GACS home row |
| [sunaku/glove80-keymaps](https://github.com/sunaku/glove80-keymaps) | 677 | Inward-roll optimization |

### Community Resources

- [precondition's Home Row Mods Guide](https://precondition.github.io/home-row-mods)
- [Pascal Getreuer's Symbol Layer Analysis](https://getreuer.info/posts/keyboards/symbol-layer/index.html)
- [r/ErgoMechKeyboards](https://reddit.com/r/ErgoMechKeyboards)
- [ZMK Discord](https://zmk.dev/community/discord/invite)

### macOS Typography Reference

| Action | Shortcut |
|--------|----------|
| Show Character Viewer | `Ctrl+Cmd+Space` or `Fn+E` |
| Em dash (—) | `Opt+Shift+-` |
| En dash (–) | `Opt+-` |
| Ellipsis (…) | `Opt+;` |
| Left double quote (") | `Opt+[` |
| Right double quote (") | `Opt+Shift+[` |
| Degree symbol (°) | `Opt+Shift+8` |

---

## Summary

**For your Leeloo with programming + writing use:**

1. **Convert Lower layer** to dedicated symbol layer
2. **Keep Raise layer** for navigation + media
3. **Add macros** for `=>`, `::`, and typography characters
4. **Consider combos** for your most-frequent symbols

Start with the recommended symbol layer, use it for a week, then customize based on what
you find yourself reaching for most often. The best layout is the one you'll actually use.
