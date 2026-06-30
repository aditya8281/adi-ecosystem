---
name: autoDev-cortex-planning-ecosystem
description: "autoDev-cortex-planning-ecosystem skill"
---

# cortex-planning-ecosystem

Load and understand all planning artifacts.

## When to Use

Before planning analysis, drift detection, or any operation needing the full planning context.

## Process

### 1. Ensure Repo Root

Run `cortex-repository-intelligence` first if not already done.

### 2. Load Planning Artifacts

Read:

- `.agents/plans/GUIDE.md` — The constitution: architecture principles, what to build/reject
- `.agents/plans/IMPLEMENTATION_STEPS.md` — Execution order: version phases, deliverables
- `.agents/plans/FinalCompatibilities.md` — reference architecture cross-reference matrix
- `.agents/plans/IMPLEMENTATION_STEPS.md` — Version timeline, execution order
- Active phase plan: `.agents/plans/versions/v{ACTIVE}/Phase-{N}.md`
- Active progress: `.agents/plans/versions/v{ACTIVE}/progress.md`

### 3. Note Available Ecosystem

```bash
echo "Commands:" && ls .claude/commands/project/ 2>/dev/null
echo "Hooks:" && ls .claude/hooks/ 2>/dev/null
echo "Skills (cortex):" && ls -d .claude/skills/cortex-*/ 2>/dev/null
```

## Output

Complete understanding of planned state — roadmap, versions, phases, deliverables, exit criteria.

## Examples

**Before planning drift analysis:**
```
Invoke cortex-planning-ecosystem, then cortex-architecture-drift.
```

## Auto-Evolution

This skill records usage to improve over time.

### Feedback
After completing this task, record the result to `.claude/ecosystem/feedback.json`:
- type: "skill"
- name: autoDev-cortex-planning-ecosystem
- success: true/false
- details: brief description of what was done and outcome

### Learning
- If this skill is used frequently (5+ times), review the feedback entries for patterns
- If patterns show consistent success in certain contexts, note those as strength areas
- If patterns show failures, identify what triggers them and add notes to prevent repeats
- After 10 uses, consider updating the skill description to reflect real-world usage patterns

### Chaining
Check `.claude/ecosystem/feedback.json` for related skills that were recently used. If a complementary skill was used in the same session, suggest it as a next step.
