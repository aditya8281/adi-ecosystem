---
name: autoDev-cortex-system-validation
description: "autoDev-cortex-system-validation skill"
---

# cortex-system-validation

Run the full system validation pipeline.

## When to Use

Before merge, before release, after implementation, or when verification is needed.

## Process

### 1. Backend Tests

```bash
make test
```

### 2. Lint

```bash
make lint
```

### 3. Format

```bash
make format --check
```

### 4. Frontend Tests (if exists)

```bash
if [ -f frontend/package.json ]; then cd frontend && npm test; else true; fi
```

### 5. Frontend Build (if exists)

```bash
if [ -f frontend/package.json ]; then cd frontend && npm run build; else true; fi
```

### 6. Hooks

```bash
uv run python .claude/hooks/run_hooks.py 2>/dev/null || python3 .claude/hooks/run_hooks.py 2>/dev/null || echo "No hooks runner found"
```

### 7. Migrations

```bash
make migrate 2>/dev/null || echo "No migration target"
```

## Output

Report: pass/fail per check, any failures with details. **Block merge on any FAIL.**

## Examples

```
Invoke cortex-system-validation before merge.
```

## Auto-Evolution

This skill records usage to improve over time.

### Feedback
After completing this task, record the result to `.claude/ecosystem/feedback.json`:
- type: "skill"
- name: autoDev-cortex-system-validation
- success: true/false
- details: brief description of what was done and outcome

### Learning
- If this skill is used frequently (5+ times), review the feedback entries for patterns
- If patterns show consistent success in certain contexts, note those as strength areas
- If patterns show failures, identify what triggers them and add notes to prevent repeats
- After 10 uses, consider updating the skill description to reflect real-world usage patterns

### Chaining
Check `.claude/ecosystem/feedback.json` for related skills that were recently used. If a complementary skill was used in the same session, suggest it as a next step.
