# Version 1.1.13

## Automatic Lifestyle feature ownership

- Nature's Call now owns bladder and bowel needs when it is enabled alongside
  Lifestyle. CW disables Lifestyle bladder progression, clears obsolete saved
  Lifestyle bladder state, and prevents its duplicate relief actions from
  appearing.
- Brush Your Damn Teeth now owns dental hygiene when it is enabled alongside
  Lifestyle. CW suppresses Lifestyle's duplicate mirror and medicine-cabinet
  brushing actions while preserving its other grooming and hygiene features.
- Both ownership rules are enabled by default, require no subscriber setup, and
  can be overridden under **Chaosworld Compatibility - Lifestyle Ownership** in
  Sandbox Options. Restart after changing them.
- Each rule stays dormant unless both affected mods are active.
- When Nature's Call ownership is inactive, CW can restore Lifestyle's default
  bladder multiplier if an older modpack preset left it at zero. This fallback
  is enabled by default and can be disabled independently.
