---
name: autoDev-cortex-status
description: "autoDev-cortex-status skill"
---

# CORTEX Status

Report the current development status of the Cortex project.

## When to Use

- On entry to the repository
- When asked "what version are we on?"
- When asked "what's the current phase?"
- On request via `/project:status`

## Steps

1. Read `.agents/plans/ACTIVE_VERSION.md` for current version/phase
2. Read `.agents/plans/versions/vX/progress.md` for component status
3. Count completed vs pending components
4. Check recent git history for active work
5. Generate status report

## Output Format

```markdown
# CORTEX Status

## Current Version
**V1: The Brain Works** — Phase 1: Agent Intelligence

## Progress
- Components: N completed / M total (P%)
- Phase: N/M phases complete
- Active branch: feat/xxx

## Recent Activity
- Last commit: [message] (time ago)
- Files changed: N

## Next Steps
1. [Component name] — [what needs to be done]
2. [Component name] — [what needs to be done]
```

## Auto-Evolution

This skill records usage to improve over time.

### Feedback
After completing this task, record the result to `.claude/ecosystem/feedback.json`:
- type: "skill"
- name: autoDev-cortex-status
- success: true/false
- details: brief description of what was done and outcome

### Learning
- If this skill is used frequently (5+ times), review the feedback entries for patterns
- If patterns show consistent success in certain contexts, note those as strength areas
- If patterns show failures, identify what triggers them and add notes to prevent repeats
- After 10 uses, consider updating the skill description to reflect real-world usage patterns

### Chaining
Check `.claude/ecosystem/feedback.json` for related skills that were recently used. If a complementary skill was used in the same session, suggest it as a next step.
