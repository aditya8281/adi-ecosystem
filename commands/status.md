# /project:status

Project status overview. Shows deployment status, health metrics, recent changes, and overall project health in a comprehensive dashboard view.

## Instructions

1. **Gather deployment status:**
   - Check if there's a deployed version (Vercel, Heroku, AWS, etc.)
   - If Vercel project: use `vercel:status` skill to get deployment info
   - Otherwise check for deployment artifacts, Docker images, or hosting config
   - Get the current deployed version/commit SHA
   - Get the last deployment timestamp
   - Check for any failed deployments in recent history

2. **Check application health:**
   - If the app has a health endpoint, hit it and report status
   - Check database connectivity if applicable
   - Check dependent services (Redis, APIs, queues)
   - Look for recent error spikes in logs or monitoring
   - Check resource usage if accessible (memory, CPU, storage)

3. **Summarize recent changes:**
   - Run `git log --oneline -20` to show recent commits
   - Categorize recent changes: features, fixes, refactors, docs
   - Identify who contributed (if multi-person project)
   - Show any pending PRs or branches

4. **Code quality snapshot:**
   - Check if tests are passing (run test suite or check CI status)
   - Get current test coverage percentage
   - Check for linting errors
   - Note any TypeScript/type errors
   - Report any security vulnerabilities from dependency audit

5. **Environment status:**
   - List configured environments (dev, staging, production)
   - Check environment variable health (missing or outdated)
   - Verify API keys and secrets are not expired
   - Check database migration status (are migrations up to date?)

6. **Project metrics:**
   - Total files and lines of code (approximate)
   - Test coverage percentage
   - Number of dependencies
   - Open issues count (if tracked locally)
   - Bundle size or build output size

7. **Risk assessment:**
   - Identify any high-risk areas:
     - Recently modified code without tests
     - Dependencies with known vulnerabilities
     - Configuration that might differ between environments
     - Any TODO/FIXME in critical paths
   - Rate overall project health: Green / Yellow / Red

8. **Generate status report:**
   - Present all information in a clear, scannable format
   - Highlight anything that needs attention
   - Provide actionable recommendations

## Skills Used

- **vercel:status** — Vercel deployment status (if applicable)
- **health** — repository health check
- **verify** — run verification suite
- **code-review-skill** — code quality assessment

## Output

A status dashboard showing:

```
## Project Status: [Green/Yellow/Red]

### Deployment
- Status: [deployed/stale/failed]
- Version: [commit SHA or version]
- Last deployed: [timestamp]
- Platform: [Vercel/AWS/Docker/etc.]

### Health
- Tests: [passing/failing] ([X]/[Y] passing)
- Coverage: [X]%
- Lint: [clean/issues found]
- Types: [clean/errors]
- Security: [clean/vulnerabilities found]

### Recent Activity (last 7 days)
- [X] commits by [Y] contributors
- Features: [list]
- Fixes: [list]
- Other: [list]

### Environments
| Environment | Status | Version | URL |
|------------|--------|---------|-----|
| Production | ✓ | abc123 | https://... |
| Staging | ✓ | def456 | https://... |

### Needs Attention
- [Any issues that need immediate action]

### Metrics
- Files: [X]
- Dependencies: [X] ([Y] outdated)
- Bundle size: [X] KB
```

## Feedback

After completing this command, record the result:
1. Read `.claude/ecosystem/feedback.json`
2. Add an entry with type "command", name "status", success (true/false), and details
3. Keep the last 500 entries
4. If `autoDev-auto-enhance` skill exists, suggest running it if 10+ commands have been recorded since last enhancement
