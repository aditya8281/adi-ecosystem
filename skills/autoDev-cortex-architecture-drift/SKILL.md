---
name: autoDev-cortex-architecture-drift
description: "autoDev-cortex-architecture-drift skill"
---

# cortex-architecture-drift

Detect divergence between documented architecture and actual codebase.

## When to Use

Before release, after architecture changes, during health check.

## Process

### 1. Check Architecture Principles

For each architecture section in `GUIDE.md` §4 (Daemon, Desktop, Memory, Graph, Retrieval, Agent, Workflow, Plugin, CLI, Ecosystem):

- Is the "current approach" description accurate?
- Is the "final decision" still the intended direction?
- Has implementation diverged from documented design?

### 2. Check ADRs

- Read `docs/decisions/README.md` for ordering
- For each ADR: verify its decision still reflects the codebase
- Mark superseded ADRs
- Identify undocumented decisions needing new ADRs

### 3. Check File Placement

- Models in `backend/app/models/`
- Schemas in `backend/app/schemas/`
- Routers in `backend/app/api/v1/`
- Services in `backend/app/services/`
- Core in `backend/app/core/`
- Agents in `backend/app/agents/`
- Tests in `tests/`
- Migrations in `migrations/versions/`

## Output

Status per section: aligned / warn / drift. Recommendations for each drift found.

## Examples

```
Invoke cortex-architecture-drift before release.
```

## Auto-Evolution

This skill records usage to improve over time.

### Feedback
After completing this task, record the result to `.claude/ecosystem/feedback.json`:
- type: "skill"
- name: autoDev-cortex-architecture-drift
- success: true/false
- details: brief description of what was done and outcome

### Learning
- If this skill is used frequently (5+ times), review the feedback entries for patterns
- If patterns show consistent success in certain contexts, note those as strength areas
- If patterns show failures, identify what triggers them and add notes to prevent repeats
- After 10 uses, consider updating the skill description to reflect real-world usage patterns

### Chaining
Check `.claude/ecosystem/feedback.json` for related skills that were recently used. If a complementary skill was used in the same session, suggest it as a next step.
