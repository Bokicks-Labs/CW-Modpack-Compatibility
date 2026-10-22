# Installed mod compatibility review — October 13, 2026

Scope: the 356 IDs in the latest Sandbox save's `mods.txt`, the installed
Workshop files, and `2026-10-13_21-21_DebugLog.txt`. This is a static and log
review; no save or upstream Workshop file was changed.

## Viewpoint QOL Java transform

The log records Byte Buddy rejecting advice for `viewpoint.interact.LootTargets.aimed`
with `Cannot assign class java.lang.Object to class viewpoint.interact.LootTargets$Target`.
The installed Project Viewpoint QOL JAR contains `Patch_LootTargetsContainers`,
annotated for that exact class and method. Its mutable `@Patch.Return` argument
has Java type `Object`. This is a concrete signature mismatch with the installed
Viewpoint method. CW's separate `LootTargets.people` advice transforms successfully
in the same log. The QOL `aimed` advice should be updated to use Viewpoint's
current return type by its maintainer or in a separately maintained replacement.
Until then, the affected QOL container-target override cannot be trusted. A
disposable-save comparison with QOL disabled can confirm its player-visible effect.

## Martial arts and throwables

Senator's Martial Arts Core equips virtual weapons listed as `weaponType` in
its style registry. The installed styles currently share
`SenatorMartialArts.BoxingHands`; future styles may use other proxy types.
Viewpoint - Advanced Throwables classifies the equipped primary-hand item and
provides the public `ViewpointThrowables.excludeItem` API. CW now reads
Senator's complete style registry and excludes every distinct proxy type when
both mods are active. The exclusion is in shared Lua so client and server apply
the same rule. It has not
yet been exercised in game; verify after a full restart that style attacks work,
the style cannot be thrown, and an ordinary throwable still works.

## Missing animation bones

The latest log repeats five missing helper-bone names 957 times each during
animation import. A binary string scan found those names in installed GLB
assets from RadArchery (39 files), PZ The Mutants (12), Brush Your Damn Teeth
(10 in each of two payload modules), and Cye's Push Doors (8). All four are
active in the latest save. This narrows the candidate assets but does not
establish which clip emitted each error or whether animation visibly fails.
The asset owner must export a compatible skeleton or omit unsupported helper
bones. Isolate in a disposable save, one candidate mod at a time, only if a
visible animation problem or startup cost warrants it. Do not alter a main save
or Workshop asset based on the log alone.

