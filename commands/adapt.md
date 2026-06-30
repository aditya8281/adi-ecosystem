# /project:adapt

Adapts the Cortex ecosystem to any project. Detects the project type, configures appropriate skills, sets up hooks, and tailors the ecosystem to the specific codebase. For empty projects, creates a basic structure. For existing projects, enhances what's already there.

## Instructions

1. **Detect project type and structure:**
   - Run `ls` on the project root to see top-level files and directories
   - Check for `package.json`, `requirements.txt`, `go.mod`, `Cargo.toml`, `pyproject.toml`, `Gemfile`, `pom.xml`, `build.gradle`, `Makefile`, `docker-compose.yml`, etc.
   - Check for frontend frameworks (React, Vue, Svelte, Next.js, Nuxt, etc.) by examining dependencies
   - Check for backend frameworks (Express, FastAPI, Django, Spring, Rails, etc.)
   - Check for database configurations, API specs, Docker files
   - Classify the project: library, CLI, web app (SPA/SSR/SSG), API service, monorepo, mobile app

2. **Audit existing ecosystem integration:**
   - Check if `.claude/` directory exists and what's configured
   - Check if `commands/`, `skills/`, `hooks/` are present
   - List what commands/skills already exist and are relevant to this project type
   - Identify gaps — what's missing that should be there for this project type

3. **Configure skills for the project type:**
   - Based on detected project type, enable or create relevant skills
   - For web apps: ensure ui-ux-pro-max, design-system, frontend-design skills are active
   - For APIs: ensure api-design, security-review skills are active
   - For monorepos: ensure workspace management, dependency analysis skills are active
   - For all projects: ensure code-review, tdd, diagnosing-bugs skills are active

4. **Set up hooks:**
   - Configure pre-commit hooks for linting/formatting based on the project's toolchain
   - Set up pre-push hooks for test running
   - Configure appropriate file-watchers if applicable
   - Ensure hooks match the project's actual toolchain (eslint, prettier, ruff, black, etc.)

5. **Create project-specific configuration:**
   - Update or create `CLAUDE.md` with project-specific conventions
   - Document build commands, test commands, deploy commands
   - Add project-specific patterns and anti-patterns
   - Note any project-specific gotchas or conventions found in the codebase

6. **For empty projects (no code yet):**
   - Detect intent from any README, package.json, or user description
   - Create basic directory structure appropriate for the project type
   - Set up initial `CLAUDE.md` with project description and conventions
   - Create a minimal `package.json` or equivalent with sensible defaults
   - Set up git hooks and basic CI configuration

7. **Report what was done:**
   - Summarize the project type detected
   - List what skills were enabled/created
   - List what hooks were configured
   - List any new files created
   - List any recommendations for further setup

## Skills Used

- **codebase-design** — to understand project architecture and patterns
- **setup-pre-commit** — to configure git hooks
- **revise-claude-md** — to create/update CLAUDE.md with project-specific info
- **code-review-skill** — to audit existing code quality tooling
- **frontend-design** — for web project setup (if applicable)

## Output

A summary report showing:
- **Project type:** What was detected
- **Ecosystem status:** What was already there vs what was added
- **Skills configured:** Which skills are now active for this project
- **Hooks installed:** What git hooks were set up
- **Files created/modified:** List of changes
- **Recommendations:** Any manual steps the user should take

## Feedback

After completing this command, record the result:
1. Read `.claude/ecosystem/feedback.json`
2. Add an entry with type "command", name "adapt", success (true/false), and details
3. Keep the last 500 entries
4. If `autoDev-auto-enhance` skill exists, suggest running it if 10+ commands have been recorded since last enhancement
