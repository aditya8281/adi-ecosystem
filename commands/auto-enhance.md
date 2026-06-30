# /project:auto-enhance

Triggers the auto-enhance learning cycle. Reviews how the ecosystem is being used, identifies patterns, enhances high-value skills, prunes unused ones, and optimizes the overall ecosystem based on real usage data.

## Instructions

1. **Gather usage data:**
   - Review recent git log (last 30 commits) to see what types of changes are being made
   - Check which commands have been invoked recently (look for patterns in commit messages)
   - Examine CLAUDE.md for any logged preferences or patterns
   - Check if there are any performance metrics or logs stored in the ecosystem

2. **Analyze skill utilization:**
   - List all skills in `.claude/skills/`
   - For each skill, estimate usage frequency based on:
     - Recent git activity related to that skill's domain
     - Whether the skill was referenced in recent work
     - Whether the skill's output quality has been acceptable
   - Categorize skills: high-value (used often, works well), medium-value (used sometimes), low-value (rarely used), broken (fails or produces poor output)

3. **Enhance high-value skills:**
   - For the top 3-5 most-used skills, review their current prompt quality
   - Identify gaps — what could they do better based on recent work patterns
   - Update skill definitions to incorporate recent learnings
   - Add new capabilities based on repeated manual work that could be automated

4. **Prune or consolidate low-value skills:**
   - For skills with zero recent usage, consider archiving them
   - For skills that overlap significantly, consider merging them
   - Move deprecated skills to a `skills/archived/` directory
   - Document why each skill was archived

5. **Discover new skill opportunities:**
   - Look for repeated patterns in recent work that aren't covered by existing skills
   - Check for manual steps that could be automated
   - Identify common sequences of commands that could be combined
   - Suggest new skills based on usage patterns

6. **Optimize hooks:**
   - Review hook performance — are any hooks too slow?
   - Check if hooks are catching real issues or just adding friction
   - Suggest hook improvements based on recent failure patterns

7. **Update ecosystem documentation:**
   - Update CLAUDE.md with any new conventions learned
   - Update the command guide if commands were added or modified
   - Document any new patterns discovered

8. **Generate enhancement report:**
   - Create a summary of what was enhanced, pruned, and discovered
   - Provide actionable next steps
   - Show before/after metrics where possible

## Skills Used

- **improve** — ecosystem self-improvement analysis
- **revise-claude-md** — update project documentation
- **codebase-design** — analyze project structure patterns
- **request-refactor-plan** — plan any needed refactoring of skills
- **feature-dev** — implement new skills or enhance existing ones

## Output

An enhancement report containing:
- **Usage analysis:** How the ecosystem has been used recently
- **Skills enhanced:** What was improved and why
- **Skills archived:** What was removed and why
- **New skills discovered:** What new skills were created
- **Hook optimizations:** What hooks were improved
- **Next recommendations:** Manual steps or further improvements suggested

## Feedback

After completing this command, record the result:
1. Read `.claude/ecosystem/feedback.json`
2. Add an entry with type "command", name "auto-enhance", success (true/false), and details
3. Keep the last 500 entries
4. If `autoDev-auto-enhance` skill exists, suggest running it if 10+ commands have been recorded since last enhancement
