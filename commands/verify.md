# /project:verify — Verification Suite

Run the full verification pipeline and report pass/fail. Fast, focused, no analysis.

**Scope:** Automated pass/fail checks. For code quality, use `/project:review`.

## Instructions

Invoke `cortex-repo-discovery`.

### 1. System Validation

Invoke `cortex-system-validation`.

Report: pass/fail per check with details.

## Output

```markdown
## Verification: [date]

| Check | Status | Details |
|-------|--------|---------|
| Backend tests | ✅/❌ N/N | |
| Frontend tests | ✅/❌ N/N | |
| Lint | ✅/❌ | |
| Format | ✅/❌ | |
| Build | ✅/❌ | |
| Hooks | ✅/❌ N/N | |
| Migrations | ✅/❌ | |

### Verdict: PASS / FAIL
```

**Block merge on any FAIL.**

---

## Feedback

After completing this command, record the result:
1. Read `.claude/ecosystem/feedback.json`
2. Add an entry with type "command", name "verify", success (true/false), and details
3. Keep the last 500 entries
4. If `autoDev-auto-enhance` skill exists, suggest running it if 10+ commands have been recorded since last enhancement
