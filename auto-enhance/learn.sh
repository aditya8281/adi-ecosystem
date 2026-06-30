#!/usr/bin/env bash
# learn.sh -- Scan feedback.json, count skill/hook invocations, identify failed patterns.
#
# Usage:
#   bash auto-enhance/learn.sh                    # Print summary to stdout
#   bash auto-enhance/learn.sh --json             # Output structured JSON
#   bash auto-enhance/learn.sh --update-skills    # Actually update SKILL.md files
#
# Reads:  .claude/ecosystem/feedback.json
# Writes: .claude/ecosystem/enhancement-log.md (when --update-skills)

set -euo pipefail

# When deployed to .claude/auto-enhance/, go up 2 levels to reach project root
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [[ "$SCRIPT_DIR" == *".claude/auto-enhance" ]]; then
  REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
else
  REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
fi
FEEDBACK_FILE="${REPO_ROOT}/.claude/ecosystem/feedback.json"
ECOSYSTEM_DIR="${REPO_ROOT}/.claude/ecosystem"
ENHANCEMENT_LOG="${ECOSYSTEM_DIR}/enhancement-log.md"

# --- Verify feedback file exists ---
if [ ! -f "$FEEDBACK_FILE" ]; then
    echo "No feedback file found at $FEEDBACK_FILE"
    echo "Creating empty feedback structure..."
    mkdir -p "$(dirname "$FEEDBACK_FILE")"
    cat > "$FEEDBACK_FILE" << 'EOF'
{
  "entries": [],
  "skills_used": {},
  "hooks_run": {},
  "commands_run": {},
  "initialized": "2026-06-30T00:00:00Z"
}
EOF
    echo "Done. No data to analyze yet."
    exit 0
fi

# --- Analyze feedback data ---
MODE="${1:-summary}"

# Use double-quoted heredoc so shell variables expand, but escape the few
# dollar-sign-prefixed Python identifiers with backslash.
python3 << PYTHON_SCRIPT
import json
import sys
from collections import Counter, defaultdict
from datetime import datetime, timezone

feedback_file = "${FEEDBACK_FILE}"
mode = "${MODE}"

with open(feedback_file, "r") as f:
    data = json.load(f)

entries = data.get("entries", [])

if not entries:
    print("No usage data recorded yet.")
    print("Skills and hooks will be tracked as they are invoked.")
    sys.exit(0)

# -- Count invocations per skill and per hook --
skill_counts = Counter()
skill_outcomes = defaultdict(lambda: {"success": 0, "failure": 0, "error_messages": []})

hook_counts = Counter()
hook_outcomes = defaultdict(lambda: {"success": 0, "failure": 0})

for entry in entries:
    etype = entry.get("type", "unknown")

    if etype == "hook":
        name = entry.get("name", "unknown")
        passed = entry.get("passed", False)
        hook_counts[name] += 1
        if passed:
            hook_outcomes[name]["success"] += 1
        else:
            hook_outcomes[name]["failure"] += 1

    elif etype in ("skill", "command"):
        name = entry.get("name", "unknown")
        success = entry.get("success", entry.get("passed", False))
        skill_counts[name] += 1
        if success:
            skill_outcomes[name]["success"] += 1
        else:
            skill_outcomes[name]["failure"] += 1
            error = entry.get("details", entry.get("message", "unknown error"))
            skill_outcomes[name]["error_messages"].append(error)

    elif etype == "hook_batch":
        # Aggregate batch-level stats (already captured per-hook above)
        pass


# -- Helper --
def success_rate(outcomes):
    total = outcomes["success"] + outcomes["failure"]
    return (outcomes["success"] / total * 100) if total > 0 else 0

def status_icon(rate):
    if rate >= 80:
        return "[ok]"    # [ok]
    if rate >= 50:
        return "[!!]"    # [!!]
    return "[xx]"        # [xx]


# -- Summary mode --
if mode == "summary":
    print("=" * 55)
    print("  ECOSYSTEM USAGE REPORT")
    print("=" * 55)
    print(f"  Total entries: {len(entries)}")

    if skill_counts:
        print(f"  Unique skills/commands: {len(skill_counts)}")
        print()
        print("  SKILL / COMMAND INVOCATIONS:")
        for name, count in skill_counts.most_common():
            rate = success_rate(skill_outcomes[name])
            print(f"    {status_icon(rate)} {name}: {count} invocations ({rate:.0f}% success)")

    if hook_counts:
        print()
        print(f"  Unique hooks run: {len(hook_counts)}")
        print()
        print("  HOOK INVOCATIONS:")
        for name, count in hook_counts.most_common():
            rate = success_rate(hook_outcomes[name])
            print(f"    {status_icon(rate)} {name}: {count} runs ({rate:.0f}% passed)")

    # Failed patterns
    needs_attention = False
    failed_items = []
    for name, outcomes in skill_outcomes.items():
        if outcomes["failure"] > 0:
            needs_attention = True
            failed_items.append((name, outcomes))
    for name, outcomes in hook_outcomes.items():
        if outcomes["failure"] > 0:
            needs_attention = True
            failed_items.append((name, outcomes))

    print()
    print("  FAILED PATTERNS:")
    if not needs_attention:
        print("    No failures recorded.")
    else:
        for name, outcomes in failed_items:
            rate = success_rate(outcomes)
            total = outcomes["success"] + outcomes["failure"]
            msgs = outcomes.get("error_messages", [])
            print(f"    [!!] {name}: {outcomes['failure']} failures "
                  f"(success rate: {rate:.0f}%, total: {total})")
            for msg in msgs[:3]:
                print(f"      - {msg}")

    # Learning signals
    print()
    print("  LEARNING SIGNALS:")
    learned = []
    flagged = []
    for name, outcomes in skill_outcomes.items():
        total = outcomes["success"] + outcomes["failure"]
        rate = success_rate(outcomes)
        if total >= 5 and rate >= 80:
            learned.append((name, total, rate))
        elif total >= 3 and rate < 50:
            flagged.append((name, total, rate))
    for name, total, rate in learned:
        print(f"    [ok] LEARNED: {name} -- {total} uses, {rate:.0f}% success => add 'learned' tag to SKILL.md")
    for name, total, rate in flagged:
        print(f"    [xx] FLAGGED: {name} -- {total} uses, {rate:.0f}% success => needs review")
    if not learned and not flagged:
        print("    Not enough data yet. Need 5+ uses for learning, 3+ for flagging.")

    print()
    print("=" * 55)


# -- JSON mode --
elif mode == "json":
    output = {
        "total_entries": len(entries),
        "unique_skills": len(skill_counts),
        "unique_hooks": len(hook_counts),
        "skills": {},
        "hooks": {},
        "needs_enhancement": [],
        "learned": [],
    }

    for name, count in skill_counts.most_common():
        outcomes = skill_outcomes[name]
        rate = success_rate(outcomes)
        output["skills"][name] = {
            "count": count,
            "success_rate": round(rate, 1),
            "failures": outcomes["failure"],
            "error_messages": outcomes["error_messages"],
        }
        if count >= 3 and rate < 80:
            output["needs_enhancement"].append(name)
        if count >= 5 and rate >= 80:
            output["learned"].append(name)

    for name, count in hook_counts.most_common():
        outcomes = hook_outcomes[name]
        rate = success_rate(outcomes)
        output["hooks"][name] = {
            "count": count,
            "success_rate": round(rate, 1),
            "failures": outcomes["failure"],
        }

    print(json.dumps(output, indent=2))


# -- Update-skills mode --
elif mode == "update-skills":
    log_lines = [f"\n## Enhancement Run: {datetime.now(timezone.utc).isoformat()}\n"]
    changes_made = False

    # Tag learned skills
    for name, count in skill_counts.most_common():
        outcomes = skill_outcomes[name]
        rate = success_rate(outcomes)
        if count >= 5 and rate >= 80:
            log_lines.append(f"### [ok] Learned: {name}")
            log_lines.append(f"- Uses: {count}, Success rate: {rate:.0f}%")
            log_lines.append(f"- Action: Add 'learned' tag to description\n")
            changes_made = True

    # Flag skills needing review
    needs_enhancement = []
    for name, count in skill_counts.most_common():
        outcomes = skill_outcomes[name]
        total = outcomes["success"] + outcomes["failure"]
        rate = success_rate(outcomes)
        if total >= 3 and rate < 50:
            needs_enhancement.append((name, outcomes, total, rate))

    if needs_enhancement:
        for name, outcomes, total, rate in needs_enhancement:
            log_lines.append(f"### [xx] Flagged for review: {name}")
            log_lines.append(f"- Success rate: {rate:.0f}% ({total} invocations)")
            log_lines.append(f"- Failures: {outcomes['failure']}")
            log_lines.append(f"- Top errors:")
            for msg in outcomes["error_messages"][:3]:
                log_lines.append(f"  - {msg}")
            log_lines.append(f"- Action: Review description and add anti-patterns\n")
            changes_made = True

    if not changes_made:
        print("No skills need enhancement at this time.")
        sys.exit(0)

    print(f"Enhancement decisions: {len(log_lines) // 4} skills processed")

    # Write enhancement log
    with open("${ENHANCEMENT_LOG}", "a") as f:
        f.write("\n".join(log_lines))

    print(f"Enhancement log written to: ${ENHANCEMENT_LOG}")


else:
    print(f"Unknown mode: {mode}")
    print("Valid modes: summary, json, update-skills")
    sys.exit(1)

PYTHON_SCRIPT
