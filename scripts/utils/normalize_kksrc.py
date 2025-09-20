#!/usr/bin/env python3
"""Normalize KDE keyboard shortcuts file by sorting actions with multiple bindings."""

import re
import sys
from pathlib import Path


def normalize_kksrc(file_path: Path) -> None:
    content = file_path.read_text()
    lines = []
    modified = False

    for line in content.splitlines():
        match = re.match(r'^([^=]+)=(.+)$', line)
        if match and '; ' in match.group(2):
            action, bindings = match.groups()
            sorted_bindings = '; '.join(sorted(bindings.split('; ')))
            lines.append(f'{action}={sorted_bindings}')
            modified = True
        else:
            lines.append(line)

    file_path.write_text('\n'.join(lines) + '\n')
    if modified:
        print(f'Normalized {file_path}')


if __name__ == '__main__':
    if not len(sys.argv) > 1:
        raise ValueError('No path given')
    normalize_kksrc(Path(sys.argv[1]))
