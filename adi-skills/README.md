# ADI Skills Index

86 skills for Claude Code — organized by category. Each skill lives in its own folder with a `SKILL.md` definition file.

## Core Development

| Skill | Purpose |
|-------|---------|
| `brainstorming` | Turn ideas into designs through dialogue |
| `writing-plans` | Create implementation plans from specs |
| `tdd` | Test-driven development workflow |
| `subagent-driven-development` | Parallel task execution via subagents |
| `executing-plans` | Execute plans task-by-task |
| `finishing-a-development-branch` | Complete dev branch for merge |
| `using-git-worktrees` | Isolated git workspaces |

## Design & Visual

| Skill | Purpose |
|-------|---------|
| `ui-ux-design` | UI/UX design principles |
| `design-system` | Design system creation |
| `taste-levels` | Visual quality assessment |
| `motion-design` | Animation and transitions |
| `brand-design` | Brand identity |
| `color-theory` | Color palette creation |
| `typography-mastery` | Font selection and hierarchy |
| `layout-composition` | Page layout design |
| `responsive-design` | Multi-device layouts |
| `accessibility-audit` | WCAG compliance |
| `dark-mode-design` | Dark theme design |
| `mobile-first` | Mobile-first design approach |

## Writing

| Skill | Purpose |
|-------|---------|
| `writing-skills` | Create new skills |
| `clear-writing` | Technical writing clarity |
| `technical-documentation` | API docs, guides |
| `prompt-engineering` | Effective prompts |
| `copywriting` | Marketing copy |
| `content-strategy` | Content planning |

## Architecture

| Skill | Purpose |
|-------|---------|
| `domain-modeling` | Domain-driven design |
| `decision-mapping` | Architecture decisions |
| `refactoring-patterns` | Code improvement |
| `api-design` | REST/GraphQL API design |
| `database-design` | Schema design |
| `microservices` | Service decomposition |

## Quality

| Skill | Purpose |
|-------|---------|
| `code-review` | Systematic code review |
| `quality-assurance` | QA testing |
| `performance-tuning` | Optimization |
| `security-audit` | Security review |
| `testing-strategies` | Test planning |

## Tools & Platforms

| Skill | Purpose |
|-------|---------|
| `fastapi-development` | FastAPI best practices |
| `postgresql-mastery` | Postgres optimization |
| `docker-containerization` | Container design |
| `git-workflow` | Git strategies |
| `ci-cd-pipeline` | CI/CD setup |
| `monitoring-observability` | Logging, metrics |
| `prototyping` | Rapid prototyping |

## Communication

| Skill | Purpose |
|-------|---------|
| `caveman-mode` | Terse communication |
| `caveman-lite` | Mildly terse |
| `caveman-ultra` | Maximum terseness |
| `cavecrew-builder` | Terse code edits |
| `cavecrew-investigator` | Terse code search |
| `cavecrew-reviewer` | Terse code review |

## Cortex (Repository Management)

| Skill | Purpose |
|-------|---------|
| `cortex-repo-discovery` | Find repo root, set CWD |
| `cortex-repository-intelligence` | Git state, phase detection |
| `cortex-repo-health-scan` | Health checks |
| `cortex-ecosystem-integration` | Verify ecosystem coherence |
| `cortex-architecture-drift` | Architecture alignment |
| `cortex-adversarial-challenge` | Challenge assumptions |
| `cortex-system-validation` | Full validation pipeline |
| `cortex-engineering-review` | Code quality review |
| `cortex-progress-tracker` | Update progress |
| `cortex-post-reflection` | Reflection framework |
| `cortex-documentation-consistency` | Doc accuracy |
| `cortex-integrity` | Structural integrity |
| `cortex-skill-discovery` | Find skill gaps |
| `cortex-idea-pipeline` | Innovation pipeline |

## Using Skills

Skills are invoked via the Skill tool in Claude Code:

```
Use the Skill tool to invoke: brainstorming
```

Or reference in commands:

```markdown
Use superpowers:brainstorming skill for this task.
```

## Adding Skills

1. Create folder: `.claude/skills/my-skill/`
2. Add `SKILL.md` with frontmatter (name, description)
3. Add any helper files
4. Skill auto-discovered by Claude Code

## Skill Structure

```
skill-name/
├── SKILL.md          # Required — skill definition
├── README.md         # Optional — extended docs
├── references/       # Optional — reference material
└── scripts/          # Optional — helper scripts
```
