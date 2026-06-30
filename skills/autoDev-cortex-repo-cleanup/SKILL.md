---
name: autoDev-cortex-repo-cleanup
description: "autoDev-cortex-repo-cleanup skill"
---

# cortex-repo-cleanup

Remove temporary files, dead code, and ensure only intentional changes remain.

## When to Use

Before merge, after implementation, before final commit.

## Process

### 1. Review Changes

```bash
git status
git diff --name-only main
```

### 2. Remove

- Temporary files, scratch files
- Abandoned implementations
- Dead code
- Obsolete comments
- Stale references

### 3. Verify

- Imports are clean
- Documentation references valid
- Configuration consistent
- No TODO/FIXME left intentionally

## Output

Clean working tree with only intentional changes remaining.

## Examples

```
Invoke cortex-repo-cleanup before final commit.
```

## Auto-Evolution

This skill records usage to improve over time.

### Feedback
After completing this task, record the result to `.claude/ecosystem/feedback.json`:
- type: "skill"
- name: autoDev-cortex-repo-cleanup
- success: true/false
- details: brief description of what was done and outcome

### Learning
- If this skill is used frequently (5+ times), review the feedback entries for patterns
- If patterns show consistent success in certain contexts, note those as strength areas
- If patterns show failures, identify what triggers them and add notes to prevent repeats
- After 10 uses, consider updating the skill description to reflect real-world usage patterns

### Chaining
Check `.claude/ecosystem/feedback.json` for related skills that were recently used. If a complementary skill was used in the same session, suggest it as a next step.
