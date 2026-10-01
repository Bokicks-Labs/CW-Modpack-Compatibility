# ZombieBuddy Java 25 network fix

This repository distributes a narrowly patched `ZombieBuddy.jar` through the
guarded `ZombieBuddy-Setup` helper. The input is Antikristianos temporary-fix
package 1.2 (`SHA-256 909D1FF579BE34AC2C3EE860A1A499B889A677D0DA74EB4A1D3632AE4E2ED102`),
which is based on upstream ZombieBuddy 2.3.3 and already carries the Build 42.21
`List` loader compatibility work.

## Local change

Only `KnownAuthors` and `SteamWorkshop` are recompiled. Their eager static
`HttpClient` fields are moved into initialization-on-demand holder classes.
This prevents agent class discovery during Java premain from constructing
those HTTP clients. It is a candidate fix for the observed hostname error.

The shaded Gson and Bouncy Castle package names are used when recompiling
against the existing fat JAR. Every other input entry remains unchanged. The
manifest adds:

```text
X-CW-Network-Fix: lazy-http-java25-1
```

Output SHA-256:

```text
6A986C9E4CA962D184D7B87B9F0976DBD8C7399551A61736F0079DD84C9EE572
```

The source change is [lazy-http-java25.patch](lazy-http-java25.patch), applied
to upstream tag `v2.3.3` (`0ddf161`). The imports in that patch target the
shaded dependencies inside the existing temporary-fix JAR. Rebuild by applying
the patch to a disposable upstream checkout, compiling `KnownAuthors.java` and
`SteamWorkshop.java` with JDK 17 against the input JAR, copying the input JAR,
and updating the copy with the compiled `me/zed_0xff/zombie_buddy` classes.
Add the manifest marker shown above. The resulting JAR must pass the output
hash check before it is distributed or installed.

## Validation performed

- Compiled the replacement classes for Java 17, matching the original class
  version and remaining compatible with PZ 42.21's bundled Java 25 runtime.
- Confirmed initializing the two outer classes does not initialize either
  `HttpClient` holder.
- Loaded the patched JAR as a real Java agent using PZ's bundled Java 25.
- Confirmed DNS resolution for `localhost`, `raw.githubusercontent.com`, and
  `api.steampowered.com` after agent installation.
- Confirmed the output contains no stale JAR signature files.

The same minimal DNS probe also passes with the unpatched JAR. It is a safety
check, not a reproduction of the game failure or proof of the fix.

The final acceptance test is a normal client launch followed by a multiplayer
join. Client, Coop host, and dedicated-server installations should use the same
verified JAR.
