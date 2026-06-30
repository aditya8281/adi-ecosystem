# ADI Ecosystem

One command to deploy a full AI development ecosystem into any project.

## Install

```bash
curl -sSL https://raw.githubusercontent.com/aditya8281/adi-ecosystem/main/install.sh | bash
```

Or from the repo:

```bash
git clone https://github.com/aditya8281/adi-ecosystem.git
cd adi-ecosystem
bash install.sh
```

## Usage

```bash
# Deploy to a project
cd your-project
adi-ecosystem init

# Start Claude Code
claude

# In Claude Code
/project:start    # Session launcher
/project:cortex   # Implementation workflow
```

## Commands

| Command | Purpose |
|---------|---------|
| `adi-ecosystem init` | Deploy ecosystem to current project |
| `adi-ecosystem init --global` | Deploy skills globally (all projects) |
| `adi-ecosystem init --force` | Re-deploy even if already installed |
| `adi-ecosystem adapt` | Adapt ecosystem to current project type |
| `adi-ecosystem enhance` | Run the auto-enhance learning cycle |
| `adi-ecosystem status` | Show ecosystem status |
| `adi-ecosystem list` | Browse all 86 skills |
| `adi-ecosystem remove` | Remove ecosystem from current project |
| `adi-ecosystem uninstall` | Remove CLI and all data from system |

## What Gets Deployed

| Component | Location | Count |
|-----------|----------|-------|
| Skills | `.claude/skills/` | 86 (autoDev-prefixed) |
| Commands | `.claude/commands/` | 22 slash commands |
| Hooks | `.claude/hooks/` | 11 governance hooks |
| Auto-Enhance | `.claude/auto-enhance/` | Self-learning meta-skill |
| Settings | `.claude/settings.local.json` | Permissions + hooks |
| CLAUDE.md | `./CLAUDE.md` | Auto-generated |
| Ecosystem State | `.claude/ecosystem/` | Feedback + learning data |

## Auto-Evolution

Every skill, command, and hook records usage to `feedback.json`. The ecosystem learns from patterns and improves itself over time.

```
Usage -> feedback.json -> learn.sh -> enhanced skills
                                  -> adapt.sh -> project-specific config
```

Run `adi-ecosystem enhance` to trigger a learning cycle manually.

## Project Detection

`adi-ecosystem init` detects your project and configures accordingly:

| Detected | What Configures |
|----------|----------------|
| `package.json` + Next.js | `npm test`, `npm run lint`, `npm run build` |
| `package.json` + React | `npm test`, `npm run lint`, `npm run build` |
| `requirements.txt` + FastAPI | `pytest`, `ruff check` |
| `requirements.txt` + Django | `pytest`, `ruff check` |
| `Cargo.toml` | `cargo test`, `cargo clippy` |
| `go.mod` | `go test ./...`, `golangci-lint run` |

## Uninstall

```bash
# From project
adi-ecosystem remove

# Remove CLI entirely
adi-ecosystem uninstall
```

## Structure

```
adi-ecosystem/
  install.sh          One-time installer
  bin/adi-ecosystem   The CLI binary
  skills/             86 autoDev-prefixed skills
  commands/           22 slash commands
  hooks/              11 governance hooks
  auto-enhance/       Self-learning meta-skill
  settings.json       Permissions template
  ecosystem/          Feedback state
```

## Requirements

- bash
- git
- python3
- Claude Code CLI

## License

Free for any project. Built for developers who want Claude Code to enforce quality automatically.
