# /project:debug

Systematic debugging workflow. Uses the diagnosing-bugs skill to identify root causes, creates test cases to reproduce issues, and implements fixes with verification.

## Instructions

1. **Gather bug information:**
   - If the user described a bug, capture the symptoms, steps to reproduce, and expected vs actual behavior
   - If no specific bug, scan for issues:
     - Check recent git log for bug-fix commits (patterns like "fix", "bug", "hotfix")
     - Look for TODO/FIXME/HACK/BUG comments in the codebase
     - Check for failing tests
     - Look for error-prone patterns (unhandled promises, missing null checks, race conditions)

2. **Reproduce the issue:**
   - Try to reproduce the bug based on the described steps
   - If no clear reproduction steps, analyze the code to understand the failure scenario
   - Create a minimal reproduction case if possible
   - Note the exact error messages, stack traces, or unexpected behaviors

3. **Diagnose root cause:**
   - Invoke the `diagnosing-bugs` skill with the reproduction case
   - Trace the execution path from the symptom to the root cause
   - Identify:
     - The exact line(s) of code causing the issue
     - The conditions that trigger it
     - Why the current code fails
     - What the correct behavior should be

4. **Create test case for the bug:**
   - Write a failing test that reproduces the bug
   - The test should:
     - Be as minimal as possible while still triggering the bug
     - Clearly document the expected behavior
     - Use the project's existing test framework and conventions
   - Run the test to confirm it fails

5. **Implement the fix:**
   - Make the minimal change needed to fix the root cause
   - Avoid over-engineering — fix the actual issue, not symptoms
   - Ensure the fix doesn't break other functionality
   - Run the new test to confirm it now passes

6. **Verify the fix:**
   - Run the full test suite to ensure no regressions
   - Run any related integration tests
   - If there are edge cases, test them too
   - Check for similar patterns elsewhere in the codebase that might have the same bug

7. **Prevent future occurrences:**
   - If the bug type is common, consider adding a linting rule or type constraint
   - Update documentation if the bug was caused by unclear documentation
   - Add defensive checks if appropriate
   - Document the bug pattern in CLAUDE.md if it's a project-specific gotcha

8. **Report results:**
   - Summarize the bug, root cause, fix, and verification
   - List any related issues found
   - Note any preventive measures taken

## Skills Used

- **diagnosing-bugs** — systematic root cause analysis
- **tdd** — create test cases for bug reproduction
- **code-review-skill** — verify fix doesn't introduce new issues
- **setup-pre-commit** — add pre-commit checks if applicable

## Output

A debugging report containing:
- **Bug description:** What was wrong
- **Root cause:** Why it was happening
- **Reproduction test:** The test case that captures the bug
- **Fix:** What was changed and why
- **Verification:** Test results proving the fix works
- **Prevention:** Measures taken to prevent recurrence
- **Related issues:** Any similar bugs found elsewhere

## Feedback

After completing this command, record the result:
1. Read `.claude/ecosystem/feedback.json`
2. Add an entry with type "command", name "debug", success (true/false), and details
3. Keep the last 500 entries
4. If `autoDev-auto-enhance` skill exists, suggest running it if 10+ commands have been recorded since last enhancement
