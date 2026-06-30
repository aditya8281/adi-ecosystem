---
name: autoDev-cortex-health-review
description: "autoDev-cortex-health-review skill"
---

# CORTEX Health Review

Run a comprehensive health check on the Cortex repository.

## When to Use

- Weekly maintenance
- Before release preparation
- When code quality concerns arise
- On request via `/project:health`

## Checks

1. **Dead Code** — unused functions, unreachable code
2. **Duplicate Code** — similar patterns in different files
3. **Technical Debt** — TODOs, FIXMEs, HACKs
4. **Documentation Drift** — docs out of sync with code
5. **Test Coverage** — gaps in test coverage
6. **Dependency Health** — outdated or vulnerable dependencies
7. **Hook Health** — governance hooks passing
8. **Lint Health** — ruff/mypy clean

## Steps

1. Run `make lint` for lint/type check
2. Run `make test` for test health
3. Run `python .claude/hooks/run_hooks.py repo-health` for health hooks
4. Run `python .claude/hooks/run_hooks.py completion-gate` for gate checks
5. Grep for TODOs/FIXMEs in codebase
6. Check documentation files for staleness
7. Generate health report

## Output Format

```markdown
# Health Review: YYYY-MM-DD

## Overall Health: [GOOD | WARNING | CRITICAL]

## Metrics
- Lint: PASS/FAIL
- Tests: PASS/FAIL
- Hooks: N/M passing
- TODOs: N found
- FIXMEs: N found

## Findings
### [SEVERITY] Finding title
- **File:** path/to/file.py:line
- **Description:** What's wrong
- **Fix:** How to fix it
- **Status:** Open | Fixed
```

## Auto-Evolution

This skill records usage to improve over time.

### Feedback
After completing this task, record the result to `.claude/ecosystem/feedback.json`:
- type: "skill"
- name: autoDev-cortex-health-review
- success: true/false
- details: brief description of what was done and outcome

### Learning
- If this skill is used frequently (5+ times), review the feedback entries for patterns
- If patterns show consistent success in certain contexts, note those as strength areas
- If patterns show failures, identify what triggers them and add notes to prevent repeats
- After 10 uses, consider updating the skill description to reflect real-world usage patterns

### Chaining
Check `.claude/ecosystem/feedback.json` for related skills that were recently used. If a complementary skill was used in the same session, suggest it as a next step.
