---
name: autoDev-cortex-documentation-consistency
description: "autoDev-cortex-documentation-consistency skill"
---

# cortex-documentation-consistency

Cross-reference every doc against current codebase to identify drift.

## When to Use

Before release, after implementation, during health check.

## Process

### 1. Check List

| Check | How |
|-------|-----|
| New/changed APIs reflected in `docs/API.md` | Read API.md, check for API changes in code |
| New models reflected in `docs/DATABASE.md` | Read DATABASE.md, check for model changes |
| Architecture changes in `docs/ARCHITECTURE.md` | Read ARCHITECTURE.md, check for drift |
| ADR created for architectural decisions | Check docs/decisions/ for relevant ADRs |
| README.md reflects current state | Quick scan of README.md |
| Cross-references valid | Check links in docs reference real files |

### 2. For Each Outdated Document

- What changed in code that the doc doesn't reflect
- Which sections need updating
- Severity: actionable / suggestion / insight

## Output

Every outdated document identified, with recommended updates.

## Examples

```
Invoke cortex-documentation-consistency before release.
```

## Auto-Evolution

This skill records usage to improve over time.

### Feedback
After completing this task, record the result to `.claude/ecosystem/feedback.json`:
- type: "skill"
- name: autoDev-cortex-documentation-consistency
- success: true/false
- details: brief description of what was done and outcome

### Learning
- If this skill is used frequently (5+ times), review the feedback entries for patterns
- If patterns show consistent success in certain contexts, note those as strength areas
- If patterns show failures, identify what triggers them and add notes to prevent repeats
- After 10 uses, consider updating the skill description to reflect real-world usage patterns

### Chaining
Check `.claude/ecosystem/feedback.json` for related skills that were recently used. If a complementary skill was used in the same session, suggest it as a next step.
