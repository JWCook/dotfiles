# Project notes
- Check repo for a `.notes` directory. That may contain `.CLAUDE.md` and optionally plan and summary documents.
- If you're creating `CLAUDE.md`/plans/summaries, place them under `.notes/`.

# General Principles
- **Incremental progress over big bangs** - Small changes that compile and pass tests
- **Learn from existing code** - Study and plan before implementing
- **Clear intent over clever code** - Be explicit and obvious. Prefer simple, clean, maintainable solutions over clever or complex ones, even if the latter are more concise or contain micro-optimizations. Readability and maintainability are primary concerns.
- Make the smallest reasonable changes to get to the desired outcome. You MUST ask permission before reimplementing features or systems from scratch instead of updating the existing implementation.
- Single responsibility per function/class
- Avoid premature abstractions. Consider the cognitive load for a new developer trying to understand your code for the first time.

# Development guidelines
- NEVER make code changes that aren't directly related to the task you're currently assigned. If you notice something that should be fixed but is unrelated to your current task, document it in a new issue instead of fixing it immediately.
- Comments:
    - NEVER remove code comments unless you can prove that they are actively false. Comments are important documentation and should be preserved even if they seem redundant or unnecessary.
    - Omit simple comments that are redundant with code
    - Omit comments that refer to edit history or past states; only describe the current state
- Dependencies: for more complex tasks, suggest additional dependencies that would make the job easier. Stop and ask for confirmation, and if applicable, provide a few different options of libraries to choose from.

## Python-specific guidelines
- Always use type hints
- Error handling: use appropriately scoped exception types instead of bare `except` or `except Exception`
- Paths: use `pathlib.Path` instead of string paths
- Use current python language features where relevant. Check `pyproject.toml` for minimum supported version; if
missing, default to latest stable version.

# Testing
- Examine existing tests and follow the established style and structure.
- Be careful to test behavior, and not implementation details. Focus on the public API. Some coupling (via mocking)
may be unavoidable, but as much as possible, tests should still pass if implementation changes but the API remains the
same.
- When running tests to verify new/changed behavior, run relevant test modules and skip unrelated test modules (especially slower ones like integration tests and stress tests)

## Python testing
- Test file structure: Test files should be grouped by source module. For example, for `src/subpackage/main.py`, create tests for that module in `test/subpackage/test_main.py`.
- When possible, combine multiple similar tests, using pytest parametrization to run the same test for multiple input/expected output sets.
- Use test functions, rather than classes/methods, unless explicitly stated.

# Debugging
- When debugging an issue or testing something out, please run everything from a file (`.py` for python), rather than an inline shell command (like `python -c '...'`), so if something crashes we have history of what we ran. Basic shell commands are fine to be run directly, though.
- Create scripts in a `.debug/` folder, For example, `.debug/race_condition.py`. Begin the file with a docstring/comments explaining the issue you are trying to debug and a summary of the information the script will provide.

# Tools
- For searching a large number of files for text, use ripgrep (`rg` command).
