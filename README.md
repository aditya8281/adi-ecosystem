# ADI Auto-Dev — Portable AI Development Ecosystem

> Clone → Install → Init → Full AI development ecosystem in any project.

## What This Is

A portable CLI that deploys 86 skills, 15 slash commands, 13 governance hooks, and full Claude Code configuration into any project with two commands.

## Quick Start

```bash
# 1. Clone or copy this folder
git clone <repo> && cd repo/adi-ecosystem

# 2. Install the CLI (one-time)
bash install.sh

# 3. Deploy to your project
cd /path/to/your/project
adi-auto-dev init

# 4. Start Claude Code — ecosystem is active
```

## How It Works

```
install.sh  →  puts `adi-auto-dev` CLI on PATH + copies ecosystem data to ~/.adi-ecosystem
adi-auto-dev init  →  detects project type + deploys everything into .claude/
```

Two commands. That's it.

## Commands

| Command | What It Does |
|---------|--------------|
| `adi-auto-dev init` | Deploy ecosystem to current project |
| `adi-auto-dev init --global` | Make skills available in ALL projects |
| `adi-auto-dev status` | Show what's deployed |
| `adi-auto-dev remove` | Remove ecosystem from project |
| `adi-auto-dev list` | Browse all 86 skills |
| `adi-auto-dev --help` | Show help |

## What Gets Deployed

| Component | Location | Count |
|-----------|----------|-------|
| Skills | `.claude/skills/` | 86 |
| Commands | `.claude/commands/project/` | 15 |
| Hooks | `.claude/hooks/` | 13 |
| Settings | `.claude/settings.local.json` | 1 |
| CLAUDE.md | `./CLAUDE.md` | auto-generated |
| Ecosystem state | `.claude/ecosystem/` | 1 |

## Auto-Detection

`adi-auto-dev init` detects your project:

| Detected | What Configures |
|----------|----------------|
| `package.json` + Next.js | `npm test`, `npm run lint`, `npm run build` |
| `package.json` + React | `npm test`, `npm run lint`, `npm run build` |
| `requirements.txt` + FastAPI | `pytest`, `ruff check` |
| `requirements.txt` + Django | `pytest`, `ruff check` |
| `Cargo.toml` | `cargo test`, `cargo clippy` |
| `go.mod` | `go test ./...`, `golangci-lint run` |
| Mixed | Both toolchains |

## Global vs Per-Project

**Global** (`--global`): Skills available in ALL projects via `~/.claude/skills/`. No hooks or settings.

**Per-project** (default `init`): Full ecosystem — skills + commands + hooks + settings + CLAUDE.md. Only in that project.

Recommended: Run `adi-auto-dev init --global` once, then `adi-auto-dev init` in each project for hooks/settings.

## Structure

```
adi-ecosystem/
├── install.sh               # One-time installer
├── bin/
│   └── adi-auto-dev         # The CLI binary
├── adi-skills/              # 86 skill folders
├── share/
│   ├── commands/            # Slash commands
│   ├── hooks/               # Governance hooks
│   ├── skills/              # Skills (mirror)
│   └── ecosystem/           # State
├── auto-dev/                # Additional hooks
├── settings.json            # Permissions template
├── README.md                # This file
└── adapt-command.md         # /adapt command reference
```

## After Init

```bash
# Start Claude Code
claude

# In Claude Code:
/project:start    # Full session init
/project:cortex   # Implementation workflow
/project:health   # Ecosystem health check
```

## Requirements

- bash
- git
- python3
- Claude Code CLI

## Uninstall

```bash
# From project
adi-auto-dev remove

# Remove CLI itself
rm ~/.local/bin/adi-auto-dev
rm -rf ~/.adi-ecosystem
```

## License

Free for any project. Built for developers who want Claude Code to enforce quality automatically.
