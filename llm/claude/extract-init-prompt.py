#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.10"
# ///
"""Extract the /init command prompt from the Claude Code binary.

The prompt is embedded as a JS template literal in the minified bundle, which can be identified by
a unique anchor string near the prompt definition.

Usage:
```sh
llm/claude/extract-init-prompt.py > llm/claude/commands/init.md
```
"""

import sys
import shutil
from pathlib import Path


ANCHOR = b'progressMessage:"analyzing your codebase"'
MARKER = b',text:`'
SEARCH_WINDOW = 2048
FRONTMATTER = """\
---
description: Initialize a new CLAUDE.md file with codebase documentation
---
"""


def read_claude_binary() -> bytes:
    claude = shutil.which('claude')
    if not claude:
        raise FileNotFoundError("'claude' not found in PATH")
    claude_path = Path(claude).resolve()
    print(f'Reading claude binary: {claude_path}', file=sys.stderr)
    return claude_path.read_bytes()


def extract_init_prompt() -> str:
    data = read_claude_binary()

    anchor_pos = data.find(ANCHOR)
    if anchor_pos < 0:
        raise ValueError(f'Anchor {ANCHOR!r} not found — binary structure may have changed')

    marker_pos = data.find(MARKER, anchor_pos, anchor_pos + SEARCH_WINDOW)
    if marker_pos < 0:
        raise ValueError(
            'Prompt start marker not found near anchor — binary structure may have changed'
        )

    return extract_template_literal(data, marker_pos + len(MARKER))


def extract_template_literal(data: bytes, start: int) -> str:
    """Read a JS template literal from `start`, returning its contents.

    Handles escaped backticks (\\`) and skips over ${...} interpolations
    so a lone `}` inside an expression doesn't confuse the parser.
    """
    it = iter(range(start, len(data)))
    depth = 0  # nesting depth of ${ ... } expressions
    for i in it:
        c = data[i]
        if c == ord('\\'):
            next(it, None)  # skip the escaped character
        elif c == ord('$') and i + 1 < len(data) and data[i + 1] == ord('{'):
            next(it, None)  # consume the "{"
            depth += 1
        elif c == ord('}') and depth > 0:
            depth -= 1
        elif c == ord('`') and depth == 0:
            return data[start:i].decode('utf-8', errors='replace').replace('\\`', '`')
    raise ValueError('Closing backtick not found — binary structure may have changed')


if __name__ == '__main__':
    prompt = extract_init_prompt()
    print(FRONTMATTER + prompt)
