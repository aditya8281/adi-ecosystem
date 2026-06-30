---
name: autoDev-cortex-repository-intelligence
description: "autoDev-cortex-repository-intelligence skill"
---

# cortex-repository-intelligence

Build accurate understanding of current repository state.

## When to Use

Before any command execution, planning, or analysis that requires knowing the repo state. Always invoke as the first step.

## Process

### 1. Find Repository Root

```bash
# Walk up from pwd to find CLAUDE.md marker
root=$(pwd)
while [ ! -f "$root/CLAUDE.md" ] && [ "$root" != "/" ]; do root=$(dirname "$root"); done
if [ "$root" = "/" ]; then echo "No Cortex repo root found — ensure CLAUDE.md exists"; exit 1; fi
cd "$root"
echo "Repo root: $root"
```

### 2. Git State

```bash
git status
git branch --show-current
git log --oneline -10
git stash list 2>/dev/null
```

### 3. Active Development State

```bash
cat .agents/plans/ACTIVE_VERSION.md 2>/dev/null || echo "No ACTIVE_VERSION.md"
grep -r "in_progress\|active\|complete" .agents/plans/versions/*/progress.md 2>/dev/null || true
```

### 4. Repository Structure

```bash
find . -maxdepth 3 -type d | sort | head -40
```

### 5. Test Baseline

```bash
pytest --collect-only 2>&1 | tail -3
```

## Output

Current branch, version, phase, repo structure, and test count. Repository root discovered and cwd set.

## Examples

**Invoke before any command:**
```
Invoke cortex-repository-intelligence to discover repo state.
```

## Auto-Evolution

This skill records usage to improve over time.

### Feedback
After completing this task, record the result to `.claude/ecosystem/feedback.json`:
- type: "skill"
- name: autoDev-cortex-repository-intelligence
- success: true/false
- details: brief description of what was done and outcome

### Learning
- If this skill is used frequently (5+ times), review the feedback entries for patterns
- If patterns show consistent success in certain contexts, note those as strength areas
- If patterns show failures, identify what triggers them and add notes to prevent repeats
- After 10 uses, consider updating the skill description to reflect real-world usage patterns

### Chaining
Check `.claude/ecosystem/feedback.json` for related skills that were recently used. If a complementary skill was used in the same session, suggest it as a next step.
