# Lifestyle feature ownership

CW automatically resolves overlapping Lifestyle systems when their more
specialized owner mods are active. The Nature's Call and BYDT rules default to
enabled and stay dormant when their relevant mod is absent. The optional
Lifestyle personal hygiene rule is also enabled by default.

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

**Disable Lifestyle personal hygiene need** is on by default. When enabled,
CW holds only Lifestyle's `hygieneNeed` at its neutral value of `50` and clears
its `HygieneGood` and `HygieneBad` moodles. Lifestyle's cleaning actions and
Cleaning skill remain enabled. Nature's Call, TASAB body grime, and BYDT dental
state are untouched. PZ Pulse Expanded omits the Lifestyle hygiene bar when
this option is enabled; its other bars remain. Turning the option off and
restarting resumes Lifestyle hygiene progression.

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
