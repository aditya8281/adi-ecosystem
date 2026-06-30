---
name: autoDev-cortex-adversarial-challenge
description: "autoDev-cortex-adversarial-challenge skill"
---

# cortex-adversarial-challenge

Stress-test plans, specs, or implementations by actively trying to find flaws.

## When to Use

Before major decisions, before approving specifications, after architecture changes.

## Process

### 1. Risks and Failure Modes

- What could go wrong?
- Single points of failure?
- Behavior under load/error conditions?

### 2. Edge Cases

- Boundary conditions not handled?
- Empty inputs, large inputs, concurrent access?
- External service unavailable?

### 3. Over/Under-Engineering

- More complex than needed?
- Too simple for requirements?
- Simpler approaches that achieve same goal?

### 4. Wrong Assumptions

- What assumptions might be incorrect?
- What would invalidate this approach?

### 5. Version Boundaries

- Belongs in current version or scope creep from later version?

### 6. CORTEX Principle Alignment

- Privacy-first, compound learning, graceful degradation, model freedom?

## Output

Challenges with severity: critical / warning / nit. Challenges are advisory — they inform, not block.

## Examples

```
Invoke cortex-adversarial-challenge before spec approval.
```

## Auto-Evolution

This skill records usage to improve over time.

### Feedback
After completing this task, record the result to `.claude/ecosystem/feedback.json`:
- type: "skill"
- name: autoDev-cortex-adversarial-challenge
- success: true/false
- details: brief description of what was done and outcome

### Learning
- If this skill is used frequently (5+ times), review the feedback entries for patterns
- If patterns show consistent success in certain contexts, note those as strength areas
- If patterns show failures, identify what triggers them and add notes to prevent repeats
- After 10 uses, consider updating the skill description to reflect real-world usage patterns

### Chaining
Check `.claude/ecosystem/feedback.json` for related skills that were recently used. If a complementary skill was used in the same session, suggest it as a next step.
