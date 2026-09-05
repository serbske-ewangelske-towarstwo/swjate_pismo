#!/usr/bin/env python3

import argparse
import difflib
import re


def normalize(text):
    """Entfernt Leerzeichen, Tabs und Zeilenumbrüche."""
    return re.sub(r"\s+", "", text)


def show_diff(file1, file2):
    with open(file1, "r", encoding="utf-8") as f:
        old = normalize(f.read())

    with open(file2, "r", encoding="utf-8") as f:
        new = normalize(f.read())

    matcher = difflib.SequenceMatcher(None, old, new)

    print(f"--- {file1}")
    print(f"+++ {file2}")

    for tag, i1, i2, j1, j2 in matcher.get_opcodes():

        if tag == "equal":
            continue

        if tag == "delete":
            print(f"- {old[i1:i2]}")

        elif tag == "insert":
            print(f"+ {new[j1:j2]}")

        elif tag == "replace":
            print(f"- {old[i1:i2]}")
            print(f"+ {new[j1:j2]}")


def main():
    parser = argparse.ArgumentParser(
        description=(
            "Vergleicht zwei Textdateien und ignoriert "
            "Leerzeichen und Zeilenumbrüche."
        )
    )

    parser.add_argument("datei1")
    parser.add_argument("datei2")

    args = parser.parse_args()

    show_diff(args.datei1, args.datei2)


if __name__ == "__main__":
    main()
