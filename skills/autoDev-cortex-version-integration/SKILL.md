---
name: autoDev-cortex-version-integration
description: "autoDev-cortex-version-integration skill"
---

# cortex-version-integration

Verify version integration readiness before merge.

## When to Use

Before merge, before release, as final gate.

## Process

### 1. Pre-Merge Gate

- [ ] System validation passes (tests, lint, format, hooks, build)
- [ ] Documentation consistent with changes
- [ ] ADRs created for architectural decisions
- [ ] Progress tracking updated
- [ ] Clean commit history
- [ ] Working tree clean

### 2. Merge Verification

```bash
make hooks-merge
make check
```

## Output

Ready/Not Ready with blocked items listed. Only finalize when all gates pass.

## Examples

```
Invoke cortex-version-integration before merging to main.
```

## Auto-Evolution

This skill records usage to improve over time.

### Feedback
After completing this task, record the result to `.claude/ecosystem/feedback.json`:
- type: "skill"
- name: autoDev-cortex-version-integration
- success: true/false
- details: brief description of what was done and outcome

### Learning
- If this skill is used frequently (5+ times), review the feedback entries for patterns
- If patterns show consistent success in certain contexts, note those as strength areas
- If patterns show failures, identify what triggers them and add notes to prevent repeats
- After 10 uses, consider updating the skill description to reflect real-world usage patterns

### Chaining
Check `.claude/ecosystem/feedback.json` for related skills that were recently used. If a complementary skill was used in the same session, suggest it as a next step.
