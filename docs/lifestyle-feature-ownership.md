# Lifestyle feature ownership

CW automatically resolves two overlapping Lifestyle systems when their more
specialized owner mods are active. Both rules default to enabled, require no
manual setup, and stay dormant when either relevant mod is absent.

## Bathroom needs

When `LifestyleHobbies` and `NC_NaturesCall` are active, Nature's Call owns
urination and bowel needs. CW:

- forces Lifestyle's bladder progression multiplier to zero at runtime;
- clears saved Lifestyle `bathroomNeed` and `BladderNeed` state for the local
  character;
- prevents Lifestyle toilet and ground-relief actions from appearing by keeping
  that obsolete need inactive.

If Nature's Call is removed or its ownership setting is disabled, CW restores
Lifestyle's default bladder multiplier of `1` when an older preset left it at
zero. This fallback is also configurable, so servers that intentionally want
no bathroom need can disable it.

Nature's Call's `bladderFill`, `bowelFill`, accidents, wiping, gut health,
toilet state, and body soilage are not modified. Lifestyle cleaning, toilet
maintenance, bathing integration, grooming, embarrassment, and hobbies remain
available.

## Dental hygiene

When `LifestyleHobbies` and `BrushYourDamnTeeth` are active, Brush Your Damn
Teeth owns brushing, dental hygiene, item wear, and dental consequences. CW
suppresses Lifestyle's mirror and medicine-cabinet brushing actions while
preserving all other Lifestyle mirror, cabinet, grooming, and hygiene actions.

## Overrides

Server owners can opt out under **Sandbox Options > Chaosworld Compatibility -
Lifestyle Ownership**. Existing saves that do not yet contain the new settings
receive the enabled defaults. Clients and the server should use the same mod
list, order, and CW version. Restart after changing an ownership setting. If a
specialized owner mod is removed, its rule becomes dormant automatically and
Lifestyle resumes providing that feature.

The intended order is:

1. `NC_NaturesCall` and/or `BrushYourDamnTeeth`
2. `LifestyleHobbies`
3. `LifestyleHobbiesFix`, if used
4. `CWModpackCompatibility`
