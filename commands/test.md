# /project:test

Test generation and management workflow. Uses the TDD skill to generate tests, manage test suites, improve coverage, and ensure quality across the project.

## Instructions

1. **Assess current test state:**
   - Identify the test framework in use (Jest, Vitest, pytest, JUnit, RSpec, Go test, etc.)
   - Run existing tests to see current pass/fail status
   - Check test coverage if tooling is available (jest --coverage, pytest --cov, etc.)
   - Identify which parts of the codebase have tests and which don't
   - Note any flaky or skipped tests

2. **Identify testing priorities:**
   - **Critical path:** Core business logic, authentication, data integrity, payment flows
   - **Uncovered code:** Files with zero test coverage
   - **Recently changed code:** Code modified in the last 10 commits without tests
   - **Bug-prone areas:** Code with recent bug fixes that lacks regression tests
   - **Edge cases:** Boundary conditions, error handling, null/undefined inputs

3. **Generate tests using TDD approach:**
   - Invoke the `tdd` skill for the identified priority areas
   - For each area:
     a. Write failing tests that define expected behavior
     b. Implement minimal code to make tests pass
     c. Refactor while keeping tests green
   - Follow the project's existing test conventions (naming, structure, patterns)

4. **Create test categories:**
   - **Unit tests:** Test individual functions/methods in isolation
   - **Integration tests:** Test module interactions and API contracts
   - **Edge case tests:** Test boundary conditions, error paths, unusual inputs
   - **Regression tests:** Test specific bugs that were fixed
   - Keep test types organized in the project's existing directory structure

5. **Set up test infrastructure if missing:**
   - Configure test runner if not already set up
   - Set up test fixtures and factories for consistent test data
   - Configure code coverage thresholds if appropriate
   - Add test-related npm scripts / Makefile targets / etc.
   - Set up test database or mock services if needed

6. **Improve test quality:**
   - Review existing tests for:
     - Tests that test implementation details instead of behavior
     - Tests with excessive mocking that hide real bugs
     - Tests that are too broad or too narrow
     - Tests with unclear names or documentation
   - Refactor low-quality tests
   - Add descriptive test names that document behavior

7. **Run complete test suite:**
   - Run all tests and ensure they pass
   - Generate a coverage report
   - Identify remaining gaps
   - Ensure tests run in reasonable time (flag slow tests)

8. **Document testing conventions:**
   - Update CLAUDE.md with testing conventions specific to this project
   - Document how to run tests, add new tests, and common patterns
   - Note any project-specific testing gotchas

## Skills Used

- **tdd** — test-driven development workflow
- **code-review-skill** — review test quality
- **diagnosing-bugs** — understand what tests should cover based on past bugs
- **setup-pre-commit** — configure pre-commit test hooks

## Output

A testing report containing:
- **Current state:** Test framework, coverage %, pass/fail status
- **Tests created:** List of new test files and what they cover
- **Tests improved:** List of refactored tests and why
- **Coverage gaps identified:** Areas that still need tests
- **Infrastructure changes:** Test tooling added or configured
- **Conventions documented:** Testing patterns recorded in CLAUDE.md

## Feedback

After completing this command, record the result:
1. Read `.claude/ecosystem/feedback.json`
2. Add an entry with type "command", name "test", success (true/false), and details
3. Keep the last 500 entries
4. If `autoDev-auto-enhance` skill exists, suggest running it if 10+ commands have been recorded since last enhancement
