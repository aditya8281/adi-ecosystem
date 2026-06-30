# Changelog

All notable changes to adi-ecosystem are documented here.

## [2.0.0] - 2026-06-30

### Complete rewrite. Plug-and-play AI development ecosystem for Claude Code.

#### New: CLI (`adi-ecosystem`)
- `adi-ecosystem init` -- Deploy ecosystem to current project
- `adi-ecosystem init --global` -- Deploy skills globally (all projects)
- `adi-ecosystem init --force` -- Redeploy even if already installed
- `adi-ecosystem adapt` -- Detect project type and adapt ecosystem
- `adi-ecosystem enhance` -- Run auto-evolution learning cycle
- `adi-ecosystem status` -- Show ecosystem status for current project
- `adi-ecosystem list` -- Browse all skills
- `adi-ecosystem remove` -- Remove ecosystem from current project
- `adi-ecosystem uninstall` -- Remove CLI and all data from system

#### New: One-command installer
- `curl -sSL https://raw.githubusercontent.com/aditya8281/adi-ecosystem/main/install.sh | bash`
- Installs CLI to `~/.local/bin/adi-ecosystem`
- Installs ecosystem data to `~/.adi-ecosystem/`

#### Skills (86 total)
- All prefixed with `autoDev-` namespace
- Every skill has Auto-Evolution section (records usage to feedback.json)
- Skills cover: AI SDK, branding, coding patterns, debugging, deployment, design, documentation, planning, testing, architecture, security, refactoring, verification, and more
- Merged richer content from reference folder into skills

#### Commands (22 total)
- 14 original commands: architecture, audit, cortex, design, feature-gap, health, ideas, improve, prompt, reflect, release, start, update, verify
- 8 new commands: adapt, auto-enhance, debug, deploy, document, refactor, status, test
- All commands have Feedback section for auto-evolution
- Flattened from `commands/project/` to `commands/`

#### Hooks (11 governance hooks)
- architecture, code-quality, completion-gate, contract, decision-tracking, docs-consistency, planning, playwright, repo-health, skill-discovery, ui-review
- All hooks write results to feedback.json via `persist_result()`
- Master runner aggregates hook batch summaries
- Shared utilities (`hooks/shared/utils.py`) for feedback persistence

#### Auto-Evolution System
- `auto-enhance/learn.sh` -- Analyzes feedback.json, identifies learned/flagged skills
- `auto-enhance/adapt.sh` -- Detects project type, writes config, adapts hooks
- Every skill records usage after task completion
- Every command records invocation results
- Every hook persists pass/fail to feedback.json
- Learning pipeline: usage -> feedback.json -> learn.sh -> enhanced skills

#### Project Detection
- Node.js (package.json) + Next.js/React/Vue detection
- Python (requirements.txt/pyproject.toml) + Django/FastAPI/Flask detection
- Rust (Cargo.toml), Go (go.mod)
- Auto-configures test/lint/build commands per detected stack

#### Governance
- PreToolUse hooks block destructive commands (rm -rf /, git push --force, etc.)
- PostToolUse hooks enforce linting, formatting, type checking
- PrePush/PreMerge hooks run full test suite
- Completion-gate blocks merge unless tests pass

#### Removed
- Old `adi-auto-dev` CLI (replaced by `adi-ecosystem`)
- Old `adi-skills/` directory (moved to `skills/`)
- Old `auto-dev/hooks/` directory (moved to `hooks/`)
- Old `commands/project/` subdirectory (flattened to `commands/`)
- `share/` directory (was empty, never functional)
- All Unicode characters from bash/Python scripts (ASCII only)

#### Documentation
- README.md with curl installer, command table, project detection matrix
- GUIDE.md updated to match actual command inventory
- All 86 skill names verified against actual directories
