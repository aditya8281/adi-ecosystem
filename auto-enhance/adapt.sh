#!/usr/bin/env bash
# adapt.sh -- Detect project type and adapt hook/skill configurations.
#
# Usage:
#   bash auto-enhance/adapt.sh            # Detect, adapt, and persist
#   bash auto-enhance/adapt.sh --dry-run  # Show what would change (no writes)
#
# Reads:  project files (package.json, pyproject.toml, etc.)
# Writes: .claude/ecosystem/project-config.json
#         CLAUDE.md (tech-stack section)
#         .claude/ecosystem/hooks-enabled.json

set -euo pipefail

# When deployed to .claude/auto-enhance/, go up 2 levels to reach project root
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [[ "$SCRIPT_DIR" == *".claude/auto-enhance" ]]; then
  REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
else
  REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
fi
DRY_RUN="${1:-}"
ECOSYSTEM_DIR="${REPO_ROOT}/.claude/ecosystem"
PROJECT_CONFIG="${ECOSYSTEM_DIR}/project-config.json"
HOOKS_CONFIG="${ECOSYSTEM_DIR}/hooks-enabled.json"
CLAUDE_MD="${REPO_ROOT}/CLAUDE.md"

mkdir -p "$ECOSYSTEM_DIR"

# -- Detect project type ----------------------------------------------

detect_project() {
    local project_type="unknown"
    local framework="none"
    local src_dir="src"
    local test_dir="tests"
    local has_frontend="false"
    local has_backend="false"
    local languages=""

    # Languages
    if [ -f "${REPO_ROOT}/package.json" ]; then
        project_type="node"
        src_dir="src"
        test_dir="test"
        has_frontend="true"
        languages="javascript"
        # Check for TypeScript
        if [ -f "${REPO_ROOT}/tsconfig.json" ]; then
            languages="typescript"
        fi
    fi

    if [ -f "${REPO_ROOT}/requirements.txt" ] || [ -f "${REPO_ROOT}/pyproject.toml" ] || [ -f "${REPO_ROOT}/setup.py" ]; then
        if [ "$project_type" = "unknown" ]; then
            project_type="python"
        fi
        has_backend="true"
        languages="${languages:+${languages},}python"
        src_dir="src"
        test_dir="tests"
    fi

    if [ -f "${REPO_ROOT}/Cargo.toml" ]; then
        project_type="rust"
        src_dir="src"
        test_dir="tests"
        has_backend="true"
        languages="${languages:+${languages},}rust"
    fi

    if [ -f "${REPO_ROOT}/go.mod" ]; then
        project_type="go"
        src_dir="."
        test_dir="."
        has_backend="true"
        languages="${languages:+${languages},}go"
    fi

    # Framework detection
    if [ -f "${REPO_ROOT}/package.json" ]; then
        if [ -f "${REPO_ROOT}/next.config.js" ] || [ -f "${REPO_ROOT}/next.config.mjs" ] || [ -f "${REPO_ROOT}/next.config.ts" ]; then
            framework="nextjs"
        elif [ -f "${REPO_ROOT}/nuxt.config.js" ] || [ -f "${REPO_ROOT}/nuxt.config.ts" ]; then
            framework="nuxt"
        elif grep -q '"react"' "${REPO_ROOT}/package.json" 2>/dev/null; then
            framework="react"
        elif grep -q '"vue"' "${REPO_ROOT}/package.json" 2>/dev/null; then
            framework="vue"
        fi
    fi

    if [ -f "${REPO_ROOT}/requirements.txt" ] || [ -f "${REPO_ROOT}/pyproject.toml" ]; then
        local deps_file="${REPO_ROOT}/requirements.txt"
        [ ! -f "$deps_file" ] && deps_file="${REPO_ROOT}/pyproject.toml"
        if grep -qi "django" "$deps_file" 2>/dev/null; then
            framework="django"
        elif grep -qi "fastapi" "$deps_file" 2>/dev/null; then
            framework="fastapi"
        elif grep -qi "flask" "$deps_file" 2>/dev/null; then
            framework="flask"
        fi
    fi

    # Determine if this is a frontend project
    if [[ "$framework" =~ ^(nextjs|nuxt|react|vue)$ ]]; then
        has_frontend="true"
    fi

    echo "${project_type}:${framework}:${src_dir}:${test_dir}:${has_frontend}:${has_backend}:${languages}"
}

# -- Write project-config.json ----------------------------------------

write_project_config() {
    local project_type="$1"
    local framework="$2"
    local src_dir="$3"
    local test_dir="$4"
    local has_frontend="$5"
    local has_backend="$6"
    local languages="$7"
    local timestamp
    timestamp="$(date -u +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || echo 'unknown')"

    cat > "$PROJECT_CONFIG" << EOF
{
  "project_type": "${project_type}",
  "framework": "${framework}",
  "src_dir": "${src_dir}",
  "test_dir": "${test_dir}",
  "has_frontend": ${has_frontend},
  "has_backend": ${has_backend},
  "languages": "${languages}",
  "detected_at": "${timestamp}",
  "auto_adapt": true
}
EOF
    echo "  [ok] Wrote project config => ${PROJECT_CONFIG}"
}

# -- Compute which hooks to enable/disable -----------------------------

compute_hooks() {
    local has_frontend="$1"
    local framework="$2"

    # Hook name:enabled pairs
    local hooks=(
        "ui-review"
        "code-quality"
        "contract"
        "architecture"
        "docs-consistency"
        "planning"
        "playwright"
        "completion-gate"
        "repo-health"
        "decision-tracking"
        "skill-discovery"
    )

    declare -A enabled_hooks

    for hook in "${hooks[@]}"; do
        case "$hook" in
            ui-review|playwright)
                if [ "$has_frontend" = "true" ]; then
                    enabled_hooks["$hook"]=true
                else
                    enabled_hooks["$hook"]=false
                fi
                ;;
            *)
                enabled_hooks["$hook"]=true
                ;;
        esac
    done

    # Output as JSON
    echo "{"
    local first=true
    for hook in "${hooks[@]}"; do
        if [ "$first" = true ]; then
            first=false
        else
            echo ","
        fi
        printf '    "%s": %s' "$hook" "${enabled_hooks[$hook]}"
    done
    echo ""
    echo "}"
}

write_hooks_config() {
    local json_content
    json_content="$(compute_hooks "$1" "$2")"
    echo "$json_content" > "$HOOKS_CONFIG"
    echo "  [ok] Wrote hooks config => ${HOOKS_CONFIG}"
}

# -- Update CLAUDE.md tech-stack section -------------------------------

update_claude_md() {
    local project_type="$1"
    local framework="$2"
    local languages="$3"
    local has_frontend="$4"

    local tech_stack_line="**Stack:** ${languages}"
    [ "$framework" != "none" ] && tech_stack_line="**Stack:** ${framework} (${languages})"

    if [ ! -f "$CLAUDE_MD" ]; then
        # Create minimal CLAUDE.md
        cat > "$CLAUDE_MD" << EOF
# CLAUDE.md

${tech_stack_line}

Auto-generated by adapt.sh. Edit as needed.
EOF
        echo "  [ok] Created CLAUDE.md with tech stack"
        return
    fi

    # Check if tech-stack section already exists
    if grep -q "<!-- tech-stack -->" "$CLAUDE_MD" 2>/dev/null; then
        # Replace between markers
        local tmp
        tmp="$(mktemp)"
        awk -v stack="$tech_stack_line" '
            /<!-- tech-stack -->/ { print; print stack; found=1; next }
            /<!-- \/tech-stack -->/ { found=0 }
            !found { print }
        ' "$CLAUDE_MD" > "$tmp"
        mv "$tmp" "$CLAUDE_MD"
        echo "  [ok] Updated tech-stack section in CLAUDE.md"
    else
        # Append tech-stack section at end
        {
            echo ""
            echo "<!-- tech-stack -->"
            echo "$tech_stack_line"
            echo "<!-- /tech-stack -->"
        } >> "$CLAUDE_MD"
        echo "  [ok] Appended tech-stack section to CLAUDE.md"
    fi
}

# -- Print hook adaptation summary ------------------------------------

summarize_hooks() {
    local has_frontend="$1"
    local framework="$2"

    echo "  Adapting hooks for ${framework:-${project_type}} project..."

    if [ "$has_frontend" = "true" ]; then
        echo "    [ok] ui-review      => ENABLED  (frontend detected)"
        echo "    [ok] playwright     => ENABLED  (frontend detected)"
    else
        echo "    [xx] ui-review      => DISABLED (no frontend)"
        echo "    [xx] playwright     => DISABLED (no frontend)"
    fi
    echo "    [ok] code-quality   => ENABLED  (always active)"
    echo "    [ok] contract       => ENABLED  (always active)"
    echo "    [ok] architecture   => ENABLED  (always active)"
    echo "    [ok] docs-consistency => ENABLED  (always active)"
    echo "    [ok] planning       => ENABLED  (always active)"
    echo "    [ok] completion-gate => ENABLED  (always active)"
    echo "    [ok] repo-health    => ENABLED  (always active)"
    echo "    [ok] decision-tracking => ENABLED (always active)"
    echo "    [ok] skill-discovery => ENABLED  (always active)"
}

# -- Main -------------------------------------------------------------

echo "======================================================="
echo "  PROJECT ADAPTATION"
echo "======================================================="

IFS=':' read -r project_type framework src_dir test_dir has_frontend has_backend languages <<< "$(detect_project)"

echo "  Detected type:  ${project_type}"
echo "  Framework:      ${framework}"
echo "  Languages:      ${languages}"
echo "  Source dir:     ${src_dir}/"
echo "  Test dir:       ${test_dir}/"
echo "  Frontend:       ${has_frontend}"
echo "  Backend:        ${has_backend}"
echo

if [ "$DRY_RUN" = "--dry-run" ]; then
    echo "  [DRY RUN] Would write project-config.json:"
    echo "    project_type=${project_type}  framework=${framework}"
    echo "    src_dir=${src_dir}  test_dir=${test_dir}"
    echo "    has_frontend=${has_frontend}  has_backend=${has_backend}"
    echo
    echo "  [DRY RUN] Would adapt hooks:"
    summarize_hooks "$has_frontend" "$framework"
    echo
    echo "  [DRY RUN] Would update CLAUDE.md tech-stack section"
else
    write_project_config "$project_type" "$framework" "$src_dir" "$test_dir" "$has_frontend" "$has_backend" "$languages"
    write_hooks_config "$has_frontend" "$framework"
    echo
    summarize_hooks "$has_frontend" "$framework"
    echo
    update_claude_md "$project_type" "$framework" "$languages" "$has_frontend"
fi

echo
echo "======================================================="
echo "  ADAPTATION COMPLETE"
echo "======================================================="
