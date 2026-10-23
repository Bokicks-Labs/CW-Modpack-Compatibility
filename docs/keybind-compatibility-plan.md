# Planned keybind compatibility submod

Status: **planned; not implemented**. This is the complete feature direction,
including detection, interactive resolution, shared keys, and integrations.
The goal is to make the large Chaosworld Build 42 modpack usable on a compact
keyboard without silently triggering two actions from one input.

## Player experience

Add an optional client-side submod with a **Keybinds & Conflicts** in-game menu.
The player can open it from Options, inspect all *discoverable* bindings, search
by action/mod/key, and filter unresolved conflicts. Each row shows the action,
owner, source menu, assigned key or chord, trigger type, and whether the submod
can safely edit or route it. The menu must distinguish confirmed exact duplicates,
possible overlaps, and bindings whose behavior cannot be determined. It must not
claim that an incomplete scan proves there are no conflicts.

Selecting a conflict shows the competing actions and offers the supported
resolutions: open the original setting, rebind or clear an editable binding,
assign an available modifier chord, or move an integrated action to tap, long
hold, or a radial-menu slot. Show a preview of the resulting assignments and
any new conflicts before the player applies them. Allow cancellation and
restore the previous values if applying a group of changes fails. Refresh the
inventory after applying changes and when the options screen is reopened.
For an action whose mod owns an inaccessible handler, explain the limitation
and offer navigation or guidance rather than presenting a nonfunctional fix.

Support a user-configurable hold threshold, initially about 350 ms. A short
press runs its tap action on release. Crossing the threshold runs the hold
action or opens the wheel; a wheel selection is committed on release. Holding
Shift, Ctrl, or Alt may select another assignment where its owner supports
that chord. Reserve direct, immediate bindings for time-critical actions
because waiting for release adds latency to tap actions. Ignore or cancel
routed input while typing or when another UI has keyboard focus; define
behavior for pause, death, vehicle transitions, and closing a wheel.

## Sources and compatibility boundary

1. Inventory the game's `MainOptions`/`keyBinding` entries, including the
   configured key and its supported single modifier.
2. Inventory PZAPI Mod Options entries of type `keybind`. Its base option
   saves a numeric key code, so a displayed modifier is not proof that the
   owning mod respects one.
3. Add a Viewpoint adapter for its separately managed keyboard chords and
   binding labels. Treat its controller bindings separately from keyboard
   conflicts.
4. Add adapters for other mod-specific menus and raw key handlers only after
   inspecting their current installed code. Keep source identity and adapter
   capability with each discovered action. Do not equate a default key in
   source with a player's saved binding.

Build 42's main binding page checks duplicates among the entries it knows;
it does not cover every mod-owned input path. A raw `OnKeyStartPressed`,
`OnKeyKeepPressed`, or `OnKeyPressed` handler may act before or independently
of our router. An inventory can report such a possible conflict, but assigning
a new chord, tap, or hold in our menu is safe only when the original action can
be disabled, rebound, or called through a verified adapter. Do not globally
intercept arbitrary keys or promise universal modifiers. Detect mouse buttons
and controller input as separate capabilities rather than assuming they behave
like keyboard keys.

## Implementation approach

- Define an action registry with stable owner/action IDs, display labels,
  source, current assignment, activation semantics (down, held, release),
  context, and capabilities: inspect, navigate, edit, disable, invoke, and
  route. Adapters own reads and writes to their respective mods; the UI does
  not patch another mod's settings file directly.
- Normalize keys and supported modifiers for comparison. Report exact
  duplicates, plain-key versus modifier overlap where a handler may ignore
  modifiers, and context-dependent overlaps separately. Preserve uncertainty
  when handler behavior is unknown. Recompute conflicts after each proposed
  change.
- Implement an in-game resolver on top of that registry. Start with edits to
  supported settings through their own APIs and a clear jump to the original
  menu for unsupported settings. Persist only on Apply; retain enough prior
  state to roll back failed writes and show a confirmation of the final mapping.
- Add an opt-in input router for actions with verified disable/rebind/invoke
  paths. Use real elapsed time for hold recognition, key-down to arm and
  key-release to finish. Ensure one physical press yields at most one routed
  action. Build the wheel with the game's radial-menu UI where suitable.
- Integrate Viewpoint first, then prioritize other mods based on actual
  conflicts found in the active mod list. Each adapter needs a supported-mod
  version check or a failure mode that leaves the original action intact.

The submod should follow this repository's optional client-submod structure.
When implementation starts, it needs its own ID, metadata, translations, and
unique `poster.png` and `icon.png`; test copies should use the existing local
dev workflow. Neither this plan nor the first implementation changes the
active server mod list automatically.

## Delivery phases and effort

These are working estimates for one developer with the current installed
Build 42 sources available. They include focused local testing, but not a
full playthrough or exhaustive coverage of every mod in the active CSV.

| Phase | Reviewable result | Estimated effort |
| --- | --- | ---: |
| Discovery and registry | Inventory game, PZAPI, and Viewpoint bindings with source and capability labels | 2-4 days |
| In-game report and resolver | Search/filter, conflict details, supported rebind/clear, preview, apply/rollback, and navigation for unsupported entries | 3-5 days |
| Shared-key router | Configurable tap/long hold, one modifier, radial selection, focus/context handling, and a pair of submod-owned demo actions | 3-5 days |
| Viewpoint adapter | Route selected Viewpoint actions without double activation and verify changed settings survive reload | 3-6 days |
| Broader mod adapters | Integrate the highest-value mods from the report | About 0.5-2 days per mod, depending on input ownership |
| Gameplay validation | Disposable-save UI and gameplay checks, keyboard layouts, SP/MP client behavior, and failure recovery | 2-4 days initially |

A narrower few-hour milestone is possible: a read-only in-game conflict list
for game and PZAPI bindings, with clearly incomplete coverage. Estimate
**3-5 hours** to build and check that slice; a Viewpoint inventory adapter
could follow in roughly **1-2 hours** if its current API remains usable.
That slice is a milestone, not the complete planned resolver. A useful first
release with interactive resolution and Viewpoint routing is roughly **3-5
weeks** at the phase estimates above; broader adapter coverage remains
ongoing work.

## Acceptance checks

- The menu identifies a duplicate between bindings from different supported
  menus, displays both owners, and correctly labels unknown overlap cases.
- A player can resolve an editable conflict in-game, preview the new mapping,
  apply it, reopen options or restart, and see the saved result.
- The menu never offers tap/hold/wheel routing for an action whose original
  handler cannot be disabled or coordinated; unsupported cases explain why.
- A routed key activates exactly one intended action for tap and for hold,
  including when a modifier is held. Wheel cancellation activates none.
- Typing in a text field, opening another UI, pausing, and switching player
  context do not trigger unintended actions.
- A failed adapter write leaves or restores the prior mapping, reports the
  error, and does not silently claim the conflict is resolved.
- Test with the current installed Build 42 and representative mod versions in
  a disposable save before treating static checks as gameplay validation.
