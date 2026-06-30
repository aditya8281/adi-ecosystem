---
name: autoDev-cortex-engineering-review
description: "autoDev-cortex-engineering-review skill"
---

# cortex-engineering-review

Review code for correctness, patterns, and quality.

## When to Use

Before push, after implementation, before PR creation.

## Process

### 1. Correctness

- Missing error handling (bare `except:`, swallowed exceptions)
- Off-by-one errors, null checks, type mismatches
- Race conditions, resource leaks

### 2. API Patterns

- Missing `response_model=` on API endpoint decorators
- Missing ownership checks (`resource.user_id == current_user.id`)
- Routes not in correct order (specific before parameterized)

### 3. Code Quality

- Hardcoded values that should be in config
- Missing docstrings on public functions
- Overly complex logic
- Dead code or unused imports

### 4. Testing Quality

- New functions/classes without tests
- Edge cases not covered
- Missing integration tests for API endpoints

## Output

Findings with severity: P0 (critical — block push) / P1 (important) / P2 (minor).

## Examples

```
Invoke cortex-engineering-review after implementation.
```

## Auto-Evolution

This skill records usage to improve over time.

### Feedback
After completing this task, record the result to `.claude/ecosystem/feedback.json`:
- type: "skill"
- name: autoDev-cortex-engineering-review
- success: true/false
- details: brief description of what was done and outcome

### Learning
- If this skill is used frequently (5+ times), review the feedback entries for patterns
- If patterns show consistent success in certain contexts, note those as strength areas
- If patterns show failures, identify what triggers them and add notes to prevent repeats
- After 10 uses, consider updating the skill description to reflect real-world usage patterns

### Chaining
Check `.claude/ecosystem/feedback.json` for related skills that were recently used. If a complementary skill was used in the same session, suggest it as a next step.
