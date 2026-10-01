# Version 1.1.14

## Optional Windows setup bundle for Project Viewpoint

- Added an inert, user-launched `ZombieBuddy-Setup` folder to the CW Workshop
  payload. Enabling CW never executes the included CMD or PowerShell files.
- Added an explicit, hash-pinned download of Zed's official ZombieBuddy Windows
  installer v4.2 and bundled the temporary Project Zomboid 42.21 compatibility
  JAR maintained by Antikristianos. The EXE itself is not included because the
  Project Zomboid Workshop uploader forbids executable files.
- Added a guarded PowerShell helper that verifies pinned SHA-256 hashes, finds
  the actual PZ installation, refuses writes while that installation is
  running, backs up the existing JAR, stages and verifies the replacement, and
  supports status, `-WhatIf`, explicit server paths, and restoration.
- The helper does not alter saves, Workshop subscriptions, Java-mod approvals,
  Steam launch options, execution policy, or unrelated mods. Zed's interactive
  installer remains responsible for the initial native agent and launcher setup.
- Added licenses, upstream links, authorship credit, binary provenance, and a
  clear disclosure that the downloaded official installer is not
  Authenticode-signed.

Project Viewpoint itself remains third-party client-side rendering software.
Every player must deliberately approve its exact Java JAR through ZombieBuddy.
