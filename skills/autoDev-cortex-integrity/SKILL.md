---
name: autoDev-cortex-integrity
description: "autoDev-cortex-integrity skill"
---

# cortex-integrity — Repository Integrity Analysis

Reusable skill that any Cortex command can invoke. Runs `IntegrityService` and returns findings.

## Invocation

Invoke via: `Skill(topic="cortex-integrity", args={mode: "full"})`

## Modes
- `quick` — structural analysis on changed files
- `incremental` — structural + transitive deps
- `full` — all available engines
- `verify` — structural + semantic
- `target` — specific paths/engines

## Output
Returns `IntegrityReport` with findings, metrics, and model.

## Auto-Evolution

This skill records usage to improve over time.

### Feedback
After completing this task, record the result to `.claude/ecosystem/feedback.json`:
- type: "skill"
- name: autoDev-cortex-integrity
- success: true/false
- details: brief description of what was done and outcome

### Learning
- If this skill is used frequently (5+ times), review the feedback entries for patterns
- If patterns show consistent success in certain contexts, note those as strength areas
- If patterns show failures, identify what triggers them and add notes to prevent repeats
- After 10 uses, consider updating the skill description to reflect real-world usage patterns

### Chaining
Check `.claude/ecosystem/feedback.json` for related skills that were recently used. If a complementary skill was used in the same session, suggest it as a next step.
