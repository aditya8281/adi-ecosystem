---
name: autoDev-cortex-progress-tracker
description: "autoDev-cortex-progress-tracker skill"
---

# cortex-progress-tracker

Track and update version/phase progress. Provides read/write access to progress.md files.

## When to Use

After completing a phase, task, or version. Before starting new work to check current state.

## Process

### 1. Read Current State

Read the version's progress.md file.

Parse: phases, statuses, completion times.

### 2. Update Status

After phase completion:
- Set phase status to "Completed"
- Record completion timestamp
- Update summary (completed count, remaining count)

### 3. Generate Report

Output:
```
## Progress: vX.XX — <name>

| Phase | Status | Completed |
|-------|--------|-----------|
| P01 | ✅ Completed | 2026-06-27 |
| P02 | ✅ Completed | 2026-06-27 |
| P03 | 🔄 In Progress | — |
| P04 | ⏳ Not started | — |

**Progress:** 2/4 phases (50%)
**Estimated Remaining:** 2-3 hours
```

### 4. Milestone Detection

When a version completes:
- Mark version as complete in progress.md
- Check if all dependencies for next version are met
- Report: "vX.XX complete. Ready for v(Y).XX."

## Auto-Evolution

This skill records usage to improve over time.

### Feedback
After completing this task, record the result to `.claude/ecosystem/feedback.json`:
- type: "skill"
- name: autoDev-cortex-progress-tracker
- success: true/false
- details: brief description of what was done and outcome

### Learning
- If this skill is used frequently (5+ times), review the feedback entries for patterns
- If patterns show consistent success in certain contexts, note those as strength areas
- If patterns show failures, identify what triggers them and add notes to prevent repeats
- After 10 uses, consider updating the skill description to reflect real-world usage patterns

### Chaining
Check `.claude/ecosystem/feedback.json` for related skills that were recently used. If a complementary skill was used in the same session, suggest it as a next step.
