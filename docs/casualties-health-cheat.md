# Casualties Undead debug healing

With Casualties Undead active and the health panel's Cheat switch enabled, right-click a body part in Health. **Full health** heals that part; **Full health (body)** heals all parts. Both commands appear at the top of the context menu and call Project Zomboid's existing cheat handlers, including its multiplayer command path. The patch does not change normal treatment or Casualties Undead's separate condition system.

The vanilla commands are already present under Cheat, but Casualties Undead adds enough procedure and debug options that the healing entries can be hard to reach. This client-only patch only adds the two shortcuts while `CasualtiesUndead` is active. Test in a disposable debug save by wounding one part, using each shortcut, and confirming other parts remain injured after the single-part command.
