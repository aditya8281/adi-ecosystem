---
name: autoDev-cortex-architecture-audit
description: "autoDev-cortex-architecture-audit skill"
---

# CORTEX Architecture Audit

Validate the Cortex codebase against its 10 architecture principles from GUIDE.md.

## When to Use

- Before merging a major feature branch
- After completing a version phase
- When architecture drift is suspected
- On request via `/project:architecture`

## Principles to Check

1. **Daemon Architecture** — single process, no forking
2. **Desktop First** — native features, not web-only
3. **Memory Architecture** — consolidation, dedup, bi-temporal
4. **Knowledge Graph** — entities, edges, community detection
5. **Retrieval Architecture** — vector + fulltext + graph, RRF + MMR
6. **Agent Architecture** — tool use, streaming, completion
7. **Workflow Architecture** — scheduler, DAG execution
8. **Plugin Architecture** — MCP, marketplace, sandboxing
9. **CLI Architecture** — unified interface, TUI mode
10. **Ecosystem Architecture** — skills, hooks, governance

## Steps

1. Read `GUIDE.md` for full principle definitions
2. Read `docs/ARCHITECTURE.md` for current state
3. For each principle, check:
   - Is the principle implemented?
   - Has it drifted from the spec?
   - Are there violations?
4. Read `CLAUDE.md` Architecture Constraints section
5. Check file placement rules are followed
6. Check ownership rules on user-scoped endpoints
7. Generate findings with severity

## Output Format

```markdown
# Architecture Audit: YYYY-MM-DD

## Summary
- Principles checked: 10
- Compliant: N
- Drift detected: N
- Violations: N

## Findings
### [SEVERITY] Principle Name
- **Status:** Compliant | Drift | Violation
- **File:** path/to/file.py:line
- **Description:** What's wrong
- **Fix:** How to fix it
```

## Severity Levels

- **Critical** — Violates immutable architecture principle
- **Important** — Drift from principle, needs attention
- **Minor** — Style/convention deviation

## Auto-Evolution

This skill records usage to improve over time.

### Feedback
After completing this task, record the result to `.claude/ecosystem/feedback.json`:
- type: "skill"
- name: autoDev-cortex-architecture-audit
- success: true/false
- details: brief description of what was done and outcome

### Learning
- If this skill is used frequently (5+ times), review the feedback entries for patterns
- If patterns show consistent success in certain contexts, note those as strength areas
- If patterns show failures, identify what triggers them and add notes to prevent repeats
- After 10 uses, consider updating the skill description to reflect real-world usage patterns

### Chaining
Check `.claude/ecosystem/feedback.json` for related skills that were recently used. If a complementary skill was used in the same session, suggest it as a next step.
