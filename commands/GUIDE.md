# Command Guide

## Using Commands

Type `/project:<name>` to invoke any command. All commands automatically discover the repository root — they work from any directory.

## Architecture

The Cortex ecosystem follows a **skill-first** hierarchy:

```
Commands (orchestrate)
    ↓
Skills (contain reusable intelligence)
    ↓
Hooks (enforce quality automatically)
```

Commands are thin orchestrators. They invoke skills from `.claude/skills/` rather than containing logic inline.

## Commands

### Core Orchestrators

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/project:start` | CORTEX session launcher — runs all health systems, auto-resolves issues, drops into dev with zero friction | Start of any session |
| `/project:update` | Project evolution — turns high-level ideas into approved plans | New features, architecture changes, ambiguous requests |
| `/project:cortex` | Full autonomous development iteration | Concrete task with clear scope |
| `/project:design` | Full frontend rebuild from scratch — scaffold, auth, layout, all version features, polish | New frontend or full frontend overhaul |

### Development Workflow Commands

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/project:adapt` | Adapt the ecosystem to any project — detects type, configures skills, sets up hooks | First time with a new project, or after major project changes |
| `/project:refactor` | Systematic refactoring workflow — plans, implements, verifies step by step | Code quality improvements, technical debt reduction |
| `/project:debug` | Systematic debugging — diagnoses root cause, creates test cases, implements fixes | When you have a bug to fix |
| `/project:test` | Test generation and management — creates tests, improves coverage, sets up infrastructure | Need more tests, test coverage gaps, or TDD workflow |
| `/project:deploy` | Deployment readiness — verifies everything, runs checks, guides deployment | Before releasing, deploying, or pushing to production |
| `/project:document` | Documentation generation — creates/updates docs from code | Documentation is missing, outdated, or incomplete |
| `/project:status` | Project status overview — deployment, health, recent changes | Quick health check, before meetings, status updates |
| `/project:auto-enhance` | Auto-enhance learning cycle — reviews usage, enhances skills, prunes unused ones | Weekly or periodically to optimize the ecosystem |

### Specialist Commands

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `/project:prompt` | Generate ecosystem-aware prompts | Before complex work, need structured spec |
| `/project:audit` | Deep code-level scan (runtime errors, dead code, integration issues) | Find bugs, dead code, integration issues |
| `/project:verify` | Run verification suite (tests, lint, format, hooks) | Pre-merge automated checks |
| `/project:release` | Release readiness check | Before releasing a version/phase |
| `/project:architecture` | Architecture alignment check | Before big architectural changes |
| `/project:health` | Repository health check | Weekly or before milestones |
| `/project:ideas` | Innovation and opportunity discovery | Weekly or during planning |
| `/project:improve` | Ecosystem self-improvement | Weekly or after significant work |
| `/project:reflect` | Reflection framework | Before completing any major task |
| `/project:feature-gap` | Roadmap vs codebase gap analysis | During planning or phase transitions |

## Typical Workflows

### New session
`/project:start` → everything resolved → `/project:cortex` → build

### New feature (ambiguous → approved → built)
`/project:update` → plan approved → `/project:cortex` → `/project:reflect` → `/project:verify`

### Frontend rebuild
`/project:design` → iterative phases → build passes clean

### Bug fix
`/project:debug` → reproduce → diagnose → fix → `/project:test` → `/project:verify`

### Code quality improvement
`/project:refactor` → plan approved → step-by-step → `/project:test` → `/project:verify`

### Before release
`/project:deploy` → checks pass → deploy → verify → `/project:document`

### Weekly maintenance
`/project:status` → `/project:health` → `/project:auto-enhance` → `/project:ideas` → `/project:improve`

### Onboarding a new project
`/project:adapt` → configure → `/project:status` → `/project:document`

### Need a prompt for complex work
`/project:prompt` → review generated prompt → use it

### Test coverage improvement
`/project:test` → assess → generate tests → verify → `/project:verify`

## Priority Order

1. `/project:start` — launch session, resolve all issues first
2. `/project:update` — design before implementation
3. `/project:cortex` — full autonomous implementation
4. `/project:design` — full frontend rebuild
5. `/project:adapt` — configure ecosystem for the project
6. `/project:prompt` — generate structured prompts
7. Everything else — focused specialist tools

## Auto-Evolution System

Every command in this ecosystem automatically records execution results to `.claude/ecosystem/feedback.json`. This creates a continuous improvement loop:

1. **Each command appends feedback** — after completion, commands write an entry with type, name, success status, and details to `.claude/ecosystem/feedback.json`
2. **Rolling window** — only the last 500 entries are kept to prevent unbounded growth
3. **Auto-enhancement trigger** — when 10+ commands have been recorded since the last enhancement run, the system suggests running the `autoDev-auto-enhance` skill to analyze patterns and improve the ecosystem
4. **Feedback format:**
```json
{
  "type": "command",
  "name": "command-name",
  "success": true,
  "details": "what happened",
  "timestamp": "ISO-8601"
}
```

This enables the ecosystem to learn from usage patterns, identify frequently failing commands, and evolve over time.
