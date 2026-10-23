"""Export the local ChaosWorldViewpoint sandbox preset as server SandboxVars.lua."""

import argparse
import json
import re
from collections import OrderedDict
from pathlib import Path


KEY = re.compile(r"[A-Za-z_][A-Za-z0-9_]*\Z")
NUMBER = re.compile(r"-?\d+(?:\.\d+)?\Z")
DEFAULT_SOURCE = Path.home() / "Zomboid" / "Sandbox Presets" / "ChaosWorldViewpoint.cfg"
DEFAULT_OUTPUT = Path(__file__).resolve().parents[1] / "docs" / "server-config" / "CWViewpointMP_SandboxVars.lua"


def lua_value(raw):
    if raw in ("true", "false") or NUMBER.fullmatch(raw):
        return raw
    # The preset's quoted text is itself the saved string value (for example, "").
    return json.dumps(raw, ensure_ascii=False)


def export(source):
    sections = OrderedDict()
    comments = []
    seen = set()
    count = 0

    for number, line in enumerate(source.read_text(encoding="utf-8-sig").splitlines(), 1):
        stripped = line.strip()
        if not stripped:
            comments.append("")
            continue
        if stripped.startswith("#"):
            comments.append("--" + stripped[1:])
            continue
        if stripped.startswith("--"):
            comments.append(stripped)
            continue
        if "=" not in line:
            raise ValueError(f"{source}:{number}: unrecognized line")

        key, value = line.split("=", 1)
        parts = key.split(".")
        if len(parts) > 2 or not all(KEY.fullmatch(part) for part in parts):
            raise ValueError(f"{source}:{number}: unsupported setting key {key!r}")
        if key in seen:
            raise ValueError(f"{source}:{number}: duplicate setting {key!r}")
        seen.add(key)
        count += 1
        section, name = (None, parts[0]) if len(parts) == 1 else parts
        if name == "Version" and section is None:
            name = "VERSION"
        sections.setdefault(section, []).append((comments, name, lua_value(value)))
        comments = []

    if comments and any(comment for comment in comments):
        raise ValueError(f"{source}: trailing comments without a setting")
    if (None not in sections or not sections[None] or sections[None][0][1] != "VERSION"):
        raise ValueError(f"{source}: expected Version as the first setting")

    output = ["-- Generated from Zomboid/Sandbox Presets/ChaosWorldViewpoint.cfg.",
              "-- Refresh with: python Scripts/export-sandbox-preset.py", "SandboxVars = {"]
    for section, entries in sections.items():
        indent = "    " if section is None else "        "
        if section is not None:
            output.append(f"    {section} = {{")
        for notes, name, value in entries:
            for note in notes:
                output.append(indent + note if note else "")
            output.append(f"{indent}{name} = {value},")
        if section is not None:
            output.append("    },")
    output.append("}")
    return "\n".join(output) + "\n", count


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, default=DEFAULT_SOURCE)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--check", action="store_true", help="Verify the output matches the current preset")
    args = parser.parse_args()
    content, count = export(args.source)
    if args.check:
        if not args.output.exists() or args.output.read_text(encoding="utf-8") != content:
            parser.error(f"{args.output} does not match {args.source}")
        print(f"Verified {count} settings in {args.output}")
    else:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(content, encoding="utf-8", newline="\n")
        print(f"Exported {count} settings to {args.output}")


if __name__ == "__main__":
    main()
