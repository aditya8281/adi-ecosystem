# /project:deploy

Deployment readiness check and deployment workflow. Verifies everything is ready — tests pass, code is clean, environment is configured — then guides or executes deployment.

## Instructions

1. **Pre-deployment checks:**
   - **Code quality:**
     - Run linter and verify zero errors (or agreed-upon baseline)
     - Run formatter and verify code is formatted
     - Run type checker (TypeScript, mypy, etc.) if applicable
     - Check for TODO/FIXME in code being deployed
   - **Tests:**
     - Run full test suite — all must pass
     - Run integration tests if they exist
     - Check test coverage meets minimum threshold
   - **Git state:**
     - Verify clean working tree (no uncommitted changes)
     - Verify branch is correct (main/master for production, appropriate branch for staging)
     - Check that all changes are pushed
     - Verify no merge conflicts
   - **Dependencies:**
     - Check for vulnerable dependencies (npm audit, pip audit, etc.)
     - Verify lock file is up to date
     - Check for unused or missing dependencies

2. **Environment verification:**
   - Check environment variables are configured in deployment target
   - Verify database connections and migrations are up to date
   - Check that required services (Redis, queues, storage) are accessible
   - Verify API keys and secrets are set (not hardcoded in code)
   - Check DNS and domain configuration if applicable

3. **Build verification:**
   - Run the production build
   - Verify build completes without errors or warnings
   - Check build output size and flag if unusually large
   - Verify build artifacts are correct (no missing files, no dev files included)
   - Run any build-time code generation

4. **Security check:**
   - Verify no secrets in code or git history
   - Check for common security issues (SQL injection, XSS, etc.)
     using the security-review skill
   - Verify HTTPS/TLS configuration if applicable
   - Check CORS configuration
   - Verify authentication and authorization are properly configured

5. **Deployment execution (if requested):**
   - Determine deployment platform (Vercel, AWS, GCP, Docker, etc.)
   - Run deployment command appropriate for the platform
   - Monitor deployment progress
   - Verify deployment succeeds
   - Run smoke tests against deployed environment
   - Check application health endpoints

6. **Post-deployment verification:**
   - Hit key endpoints to verify application is responding
   - Check error monitoring for new errors
   - Verify critical user flows work in production
   - Check performance metrics baseline
   - Monitor logs for anomalies

7. **Rollback preparation:**
   - Document the current deployment version/SHA
   - Ensure rollback procedure is known and tested
   - Note the last known good deployment for quick rollback

8. **Generate deployment report:**
   - Summarize all pre-deployment checks
   - Document what was deployed and where
   - Note any warnings or non-blocking issues
   - Record post-deployment verification results

## Skills Used

- **vercel:deploy** — Vercel deployment (if applicable)
- **vercel:verification** — post-deploy verification (if applicable)
- **vercel:env** — environment variable management (if applicable)
- **code-review-skill** — pre-deploy code review
- **security-review** — security audit before deployment
- **verify** — run verification suite

## Output

A deployment readiness report:
- **Go/No-Go:** Whether it's safe to deploy
- **Check results:** Pass/fail for each pre-deployment check
- **Build status:** Build success, size, warnings
- **Security status:** Any security concerns found
- **Deploy status:** Deployment result (if executed)
- **Post-deploy verification:** Health check results
- **Issues found:** Any blocking or non-blocking issues
- **Next steps:** Recommended actions

## Feedback

After completing this command, record the result:
1. Read `.claude/ecosystem/feedback.json`
2. Add an entry with type "command", name "deploy", success (true/false), and details
3. Keep the last 500 entries
4. If `autoDev-auto-enhance` skill exists, suggest running it if 10+ commands have been recorded since last enhancement
