---
name: autoDev-auto-enhance
description: >
  Self-improving meta-skill for the adi-ecosystem. Monitors skill usage patterns,
  tracks success/failure data, enhances skill descriptions and hooks based on real
  project usage, and adapts configurations to the current project type.
  Auto-triggers periodically or on explicit invocation: "/auto-enhance", "improve skills",
  "adapt to project", "learn from usage".
---

# Auto-Enhance: Self-Improving Ecosystem

The ecosystem learns from itself. This meta-skill watches how skills and hooks are
actually used, identifies what works and what doesn't, then writes improvements back
into the skill definitions and hook configurations.

## When to Use

- After a session where multiple skills were invoked (batch learn)
- When switching to a new project (adapt to project type)
- Periodically to keep skill descriptions accurate ("enhance skills")
- After failures or retries to update anti-patterns ("learn from errors")

## Process

### 1. Scan Usage Data

Read `.claude/ecosystem/feedback.json` for invocation records:

```bash
cat .claude/ecosystem/feedback.json | python3 -c "
import json, sys
data = json.load(sys.stdin)
entries = data.get('entries', [])
print(f'Total invocations: {len(entries)}')
for e in entries:
    print(f\"  {e.get('skill', 'unknown')}: {e.get('outcome', '?')} @ {e.get('timestamp', '?')}\")
"
```

### 2. Count Skill Invocations

Tally which skills are used most and least:

```bash
python3 auto-enhance/learn.sh
```

### 3. Identify Failed Patterns

Extract failure reasons from the feedback data and group them:

- **Skill not matching intent** -- description needs rewriting
- **Skill producing wrong output** -- instructions need clarification
- **Hook blocking valid work** -- hook threshold too aggressive
- **Missing skill for common task** -- new skill needed (flag, don't create)

### 4. Enhance Skill Descriptions

For each skill with >3 invocations and >20% failure rate:

1. Read the current `SKILL.md`
2. Check the failure messages for common themes
3. Update the `description` frontmatter to be more precise
4. Add or update "When to Use" and "When NOT to Use" sections
5. Add anti-patterns discovered from failures

**Rules:**
- Never delete existing working instructions -- only add clarity
- Preserve the skill's name and core purpose
- Add concrete examples of what the skill should NOT do
- Keep descriptions under 3 sentences in frontmatter

### 5. Adapt to Project

Detect the current project type and adjust:

```bash
python3 auto-enhance/adapt.sh
```

This updates:
- Hook configurations (e.g., enable `playwright` hook for frontend projects only)
- Skill priority ordering (e.g., `imagegen-frontend-web` higher for React/Next.js)
- Context paths in hooks (e.g., point to `src/` instead of `lib/`)

### 6. Write Back Changes

```bash
# Update feedback.json with processed timestamp
python3 -c "
import json, datetime
with open('.claude/ecosystem/feedback.json', 'r+') as f:
    data = json.load(f)
    data['last_enhanced'] = datetime.datetime.now().isoformat()
    f.seek(0)
    json.dump(data, f, indent=2)
    f.truncate()
"
```

## Output

- Updated `SKILL.md` frontmatter with improved descriptions
- Updated hook configurations in `hooks/` for the current project
- Summary of what changed and why

## Anti-Patterns

- **Over-optimizing**: Don't rewrite skills that work fine (>80% success rate)
- **Circular learning**: Don't enhance a skill based on its own failures to enhance
- **Ignoring context**: A skill that fails in one project may work in another -- only adapt, don't destroy

## Boundaries

- Does NOT create new skills -- only enhances existing ones
- Does NOT modify hook logic -- only adjusts configurations and paths
- Does NOT delete skills -- only refines descriptions
- Always preserves a human-readable changelog in `.claude/ecosystem/enhancement-log.md`
