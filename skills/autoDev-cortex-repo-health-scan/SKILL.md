---
name: autoDev-cortex-repo-health-scan
description: "autoDev-cortex-repo-health-scan skill"
---

# cortex-repo-health-scan

Scan repository for health indicators: hooks, skills, tech debt, documentation freshness.

## When to Use

Weekly health check, before release, quality concerns.

## Process

### 1. Hook Health

```bash
uv run python .claude/hooks/run_hooks.py 2>/dev/null || python3 .claude/hooks/run_hooks.py 2>/dev/null
```

Report: pass/fail per hook, any false positives.

### 2. Skill Health

- List all skills in `.claude/skills/`
- Check for definition files in each
- Flag skills not updated in 30+ days as stale
- Flag skills with no references in docs/workflows as unused

### 3. Tech Debt Hotspots

```bash
git log --oneline --since="2 weeks ago" | head -30
```

- Files changed 5+ times in recent commits
- TODO/FIXME/HACK count across codebase
- Files with most tech debt indicators

### 4. Documentation Freshness

Check each doc in `docs/` for:
- "Last updated" date
- Outdated references
- Broken cross-references

## Output

Health status across hooks, skills, tech debt, documentation.

## Examples

```
Invoke cortex-repo-health-scan for weekly health report.
```

## Auto-Evolution

This skill records usage to improve over time.

### Feedback
After completing this task, record the result to `.claude/ecosystem/feedback.json`:
- type: "skill"
- name: autoDev-cortex-repo-health-scan
- success: true/false
- details: brief description of what was done and outcome

### Learning
- If this skill is used frequently (5+ times), review the feedback entries for patterns
- If patterns show consistent success in certain contexts, note those as strength areas
- If patterns show failures, identify what triggers them and add notes to prevent repeats
- After 10 uses, consider updating the skill description to reflect real-world usage patterns

### Chaining
Check `.claude/ecosystem/feedback.json` for related skills that were recently used. If a complementary skill was used in the same session, suggest it as a next step.
