# /project:refactor

Systematic refactoring workflow. Creates a refactoring plan using the request-refactor-plan skill, gets approval, then implements the refactoring step by step with verification at each stage.

## Instructions

1. **Identify refactoring target:**
   - If the user specified a target (file, module, feature), use that
   - Otherwise, analyze the codebase for common refactoring opportunities:
     - Files over 300 lines
     - Functions with high cyclomatic complexity
     - Duplicated code patterns
     - Circular dependencies
     - Dead code and unused imports
     - Inconsistent patterns across similar modules
   - Rank opportunities by impact and risk

2. **Generate refactoring plan:**
   - Invoke the `request-refactor-plan` skill with the identified target
   - The plan should include:
     - What specifically needs to be refactored and why
     - The step-by-step approach (small, safe steps)
     - Risk assessment for each step
     - How to verify correctness after each step
     - Rollback strategy if something breaks

3. **Get user approval:**
   - Present the refactoring plan clearly
   - Highlight any risks or breaking changes
   - Ask for explicit approval before proceeding
   - Allow the user to modify the plan or scope

4. **Implement refactoring step by step:**
   - For each step in the approved plan:
     a. Make the change (small, atomic edit)
     b. Run relevant tests
     c. Run linting/formatting
     d. Verify the build still works
     e. If anything breaks, revert that step and reassess
   - Commit after each successful step with a clear commit message
   - Never combine multiple independent refactoring steps in one commit

5. **Verify the complete refactoring:**
   - Run the full test suite
   - Run any type checking (TypeScript, mypy, etc.)
   - Run the linter and formatter
   - Check that no functionality was changed (behavioral equivalence)
   - If the project has CI, verify it would pass

6. **Document the refactoring:**
   - Update any documentation that references changed interfaces
   - Add comments explaining non-obvious refactoring decisions
   - Update CLAUDE.md if conventions changed
   - Create a refactoring summary for the commit log

## Skills Used

- **request-refactor-plan** — generate the step-by-step refactoring plan
- **code-review-skill** — verify refactoring didn't introduce issues
- **codebase-design** — understand architecture before refactoring
- **tdd** — ensure tests cover refactored code
- **simplify** — apply simplification during refactoring

## Output

A completed refactoring with:
- **Refactoring plan:** What was proposed and approved
- **Commits:** One per step, each verified
- **Test results:** Full suite passing
- **Summary:** What was changed, why, and how it improves the codebase

## Feedback

After completing this command, record the result:
1. Read `.claude/ecosystem/feedback.json`
2. Add an entry with type "command", name "refactor", success (true/false), and details
3. Keep the last 500 entries
4. If `autoDev-auto-enhance` skill exists, suggest running it if 10+ commands have been recorded since last enhancement
