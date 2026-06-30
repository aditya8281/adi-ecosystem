#!/usr/bin/env python3
"""Master hook runner.

Usage:
    python .claude/hooks/run_hooks.py              # Run all hooks
    python .claude/hooks/run_hooks.py ui-review    # Run specific hook
    python .claude/hooks/run_hooks.py --phase pre  # Run hooks by phase

Phases:
    pre-commit:  ui-review, code-quality, contract
    pre-push:    code-quality, architecture, contract, docs-consistency
    pre-merge:   all hooks
    on-change:   ui-review (if frontend), code-quality, contract
"""

import importlib.util
import json
import sys
from datetime import datetime, timezone
from pathlib import Path

# Import persist_result from shared utils
SHARED_DIR = Path(__file__).resolve().parent / "shared"
sys.path.insert(0, str(SHARED_DIR))
from utils import persist_result, FEEDBACK_PATH

ROOT = Path(__file__).resolve().parents[2]
HOOKS_DIR = ROOT / ".claude" / "hooks"

HOOKS = {
    "ui-review": "ui-review/hook.py",
    "code-quality": "code-quality/hook.py",
    "contract": "contract/hook.py",
    "architecture": "architecture/hook.py",
    "docs-consistency": "docs-consistency/hook.py",
    "planning": "planning/hook.py",
    "playwright": "playwright/hook.py",
    "completion-gate": "completion-gate/hook.py",
    "repo-health": "repo-health/hook.py",
    "decision-tracking": "decision-tracking/hook.py",
    "skill-discovery": "skill-discovery/hook.py",
}

PHASES = {
    "pre-commit": ["ui-review", "code-quality"],
    "pre-push": ["code-quality", "architecture", "contract", "docs-consistency", "skill-discovery"],
    "pre-merge": list(HOOKS.keys()),
    "on-change": ["code-quality", "contract"],
}


def load_hook(name, script_path):
    """Dynamically load and run a hook module."""
    spec = importlib.util.spec_from_file_location(f"hook_{name}", script_path)
    if not spec or not spec.loader:
        print(f"  [xx] Could not load {name}")
        return None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    if hasattr(module, "run_hook"):
        return module.run_hook()
    print(f"  [xx] {name}: no run_hook() function")
    return None


def _persist_aggregated_summary(results):
    """Write one aggregated summary entry per hook-run batch to feedback.json."""
    if not FEEDBACK_PATH.exists():
        return
    try:
        data = json.loads(FEEDBACK_PATH.read_text())
    except (json.JSONDecodeError, FileNotFoundError):
        data = {"entries": [], "skills_used": {}, "hooks_run": {}, "commands_run": {}}

    passed = sum(1 for r in results if r.passed)
    total = len(results)
    failed_names = [r.name for r in results if not r.passed]

    entry = {
        "type": "hook_batch",
        "total_hooks": total,
        "passed": passed,
        "failed": total - passed,
        "failed_hooks": failed_names,
        "hook_names": [r.name for r in results],
        "all_passed": failed_names == [],
        "timestamp": datetime.now(timezone.utc).isoformat(),
    }
    data["entries"].append(entry)
    data["entries"] = data["entries"][-500:]
    FEEDBACK_PATH.write_text(json.dumps(data, indent=2))


def main():
    args = sys.argv[1:]

    if not args:
        # Run all hooks
        hook_names = list(HOOKS.keys())
    elif args[0] == "--phase":
        phase = args[1] if len(args) > 1 else "pre-push"
        hook_names = PHASES.get(phase, [])
        if not hook_names:
            print(f"Unknown phase: {phase}")
            print(f"Valid phases: {', '.join(PHASES.keys())}")
            return 1
    else:
        hook_names = [a for a in args if a in HOOKS]
        if not hook_names:
            print(f"Unknown hook(s): {', '.join(args)}")
            print(f"Valid hooks: {', '.join(HOOKS.keys())}")
            return 1

    print("=" * 60)
    print("  CORTEX HOOK SYSTEM")
    print("=" * 60)

    results = []
    for name in hook_names:
        script = HOOKS_DIR / HOOKS[name]
        if not script.exists():
            print(f"  [xx] {name}: script not found")
            continue

        print(f"\n--- {name} ---")
        result = load_hook(name, script)
        if result:
            results.append(result)
            icon = "[ok]" if result.passed else "[xx]"
            print(f"  {icon} {result.name}: {result.message}")
            for f in result.findings[:5]:
                print(f"    {f}")

    # Summary
    print(f"\n{'=' * 60}")
    passed = sum(1 for r in results if r.passed)
    total = len(results)
    failed = total - passed

    if failed > 0:
        print(f"  [xx] {failed}/{total} hooks failed")
        for r in results:
            if not r.passed:
                print(f"    [xx] {r.name}: {r.message}")
    else:
        print(f"  [ok] All {total} hooks passed")

    # Persist each individual result to feedback.json
    for r in results:
        try:
            persist_result(r)
        except Exception as e:
            print(f"  [!!] Could not persist result for {r.name}: {e}")

    # Write aggregated summary entry
    if results:
        _persist_aggregated_summary(results)

    print("=" * 60)
    return 1 if failed > 0 else 0


if __name__ == "__main__":
    sys.exit(main())
