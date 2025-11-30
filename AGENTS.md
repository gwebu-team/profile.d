# AGENTS.md - Repository Guidelines for Agentic Coding

## Build & Development Commands
- `make help` - Show all available targets
- `make dist` - Create source distribution in dist/
- `make rpm` - Build RPM package
- `make podman_rpm` - Build RPM using podman (for MacOS)
- `make changelog` - Add changelog entry via ./changelog.sh
- `make clean` - Clean generated files
- Pre-commit hooks run automatically on commit (see .pre-commit-config.yaml)

## Code Style Guidelines
- **Shell Scripts**: Use bash syntax, source-safe with `${BASH_SOURCE-}` guard
- **File Permissions**: profile.d scripts must be 0644 (install -m 0644) - they are sourced, not executed
- **Line Endings**: LF only (enforced by pre-commit, see .editorconfig)
- **No trailing whitespace** (enforced by pre-commit, see .editorconfig)
- **Error Handling**: Use `command -v` instead of `which` for portability
- **OS Compatibility**: Support both Linux and MacOS with conditional logic
- **Naming**: Profile.d files use `z-<name>.sh` pattern for alphabetical loading
- **Licensing**: The Unlicense unless explicitly stated otherwise
- **Indentation**: 4 spaces for shell scripts (see .editorconfig)
- **Large Files**: Max 64KB (enforced by pre-commit)

## Testing
- No specific testing framework currently used
- Shell scripts should be tested with basic manual verification
- Use `set -euo pipefail` for robust error handling

## Cursor/Copilot Rules
- No specific .cursorrules or .github/copilot-instructions.md found
- Follow standard shell script best practices
