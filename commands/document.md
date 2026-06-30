# /project:document

Documentation generation and maintenance workflow. Creates or updates documentation from code, ensuring it stays current and useful. Covers README, API docs, inline docs, and project guides.

## Instructions

1. **Assess current documentation state:**
   - Check for README.md — does it exist? Is it up to date?
   - Check for docs/ directory and its contents
   - Look for API documentation (OpenAPI/Swagger specs, JSDoc, docstrings)
   - Check for CHANGELOG.md
   - Check for CONTRIBUTING.md
   - Identify what documentation exists and what's missing

2. **Analyze codebase for documentation needs:**
   - Scan public APIs (exported functions, classes, routes) for documentation
   - Check for undocumented functions with complex signatures
   - Identify key architectural decisions that should be documented
   - Look for configuration options that need explanation
   - Find common usage patterns that should be examples

3. **Generate/update README.md:**
   - Project description and purpose
   - Installation instructions
   - Quick start guide
   - Configuration options
   - Common usage examples
   - API overview (if applicable)
   - Contributing guidelines reference
   - License information
   - Based on actual codebase analysis, not assumptions

4. **Generate API documentation:**
   - For each public API surface:
     - Function/method signatures with parameter types
     - Return types and possible values
     - Usage examples
     - Error cases and edge cases
     - Any side effects or important notes
   - Format consistent with the project's conventions

5. **Create/update architecture documentation:**
   - High-level system architecture
   - Module/package structure and responsibilities
   - Data flow diagrams (text-based)
   - Key design decisions and rationale
   - External service dependencies
   - Database schema if applicable

6. **Update inline documentation:**
   - Add or improve docstrings/comments for complex functions
   - Document non-obvious code patterns
   - Explain workarounds and their reasons
   - Add TODO context where TODOs exist
   - Focus on "why" not "what" for code comments

7. **Create/update project guides:**
   - Development setup guide
   - Testing guide
   - Deployment guide
   - Troubleshooting guide
   - Common issues and solutions

8. **Verify documentation accuracy:**
   - Test all code examples to ensure they work
   - Verify all commands in documentation can be run
   - Check that file paths and references are correct
   - Ensure version numbers and dates are current

## Skills Used

- **revise-claude-md** — maintain project conventions documentation
- **codebase-design** — understand architecture for documentation
- **frontend-design** — document UI components if applicable (Storybook, etc.)
- **vercel:nextjs** — Next.js specific documentation patterns (if applicable)

## Output

A documentation report containing:
- **Files created:** New documentation files with their purpose
- **Files updated:** Existing files that were improved
- **Coverage:** What parts of the codebase are now documented
- **Gaps remaining:** What still needs documentation
- **Examples added:** Code examples created
- **Accuracy verification:** Whether all examples were tested

## Feedback

After completing this command, record the result:
1. Read `.claude/ecosystem/feedback.json`
2. Add an entry with type "command", name "document", success (true/false), and details
3. Keep the last 500 entries
4. If `autoDev-auto-enhance` skill exists, suggest running it if 10+ commands have been recorded since last enhancement
