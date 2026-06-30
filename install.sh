#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
# ADI Auto-Dev — One-Time Installer
#
# Installs the `adi-auto-dev` CLI and ecosystem data to your system.
# After this, run `adi-auto-dev init` in any project root to deploy.
#
# Usage:
#   curl -sSL <url>/install.sh | bash
#   — or —
#   git clone <repo> && cd <repo>/adi-ecosystem && bash install.sh
# ─────────────────────────────────────────────────────────────
set -euo pipefail

ECOSYSTEM_SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_BIN="${HOME}/.local/bin"
INSTALL_DATA="${HOME}/.adi-ecosystem"

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

info()  { printf "${GREEN}[adi]${NC} %s\n" "$*"; }
warn()  { printf "${YELLOW}[adi]${NC} %s\n" "$*"; }
error() { printf "${RED}[adi]${NC} %s\n" "$*" >&2; }

# ── Check prerequisites ──────────────────────────────────────
command -v git >/dev/null 2>&1 || { error "git required. Install git first."; exit 1; }
command -v python3 >/dev/null 2>&1 || { error "python3 required. Install python3 first."; exit 1; }

# ── Create directories ───────────────────────────────────────
mkdir -p "${INSTALL_BIN}"
mkdir -p "${INSTALL_DATA}"

# ── Copy CLI script ──────────────────────────────────────────
cp "${ECOSYSTEM_SRC}/bin/adi-auto-dev" "${INSTALL_BIN}/adi-auto-dev"
chmod +x "${INSTALL_BIN}/adi-auto-dev"
info "CLI installed: ${INSTALL_BIN}/adi-auto-dev"

# ── Copy ecosystem data ──────────────────────────────────────
# Commands
cp -r "${ECOSYSTEM_SRC}/share/commands/"* "${INSTALL_DATA}/commands/" 2>/dev/null || true
mkdir -p "${INSTALL_DATA}/commands/project"
cp "${ECOSYSTEM_SRC}/share/commands/project/"*.md "${INSTALL_DATA}/commands/project/" 2>/dev/null || true
cp "${ECOSYSTEM_SRC}/share/commands/GUIDE.md" "${INSTALL_DATA}/commands/" 2>/dev/null || true

# Skills
if [ -d "${ECOSYSTEM_SRC}/adi-skills" ]; then
  cp -r "${ECOSYSTEM_SRC}/adi-skills/"* "${INSTALL_DATA}/skills/" 2>/dev/null || true
elif [ -d "${ECOSYSTEM_SRC}/share/skills" ]; then
  cp -r "${ECOSYSTEM_SRC}/share/skills/"* "${INSTALL_DATA}/skills/" 2>/dev/null || true
fi

# Hooks
cp -r "${ECOSYSTEM_SRC}/share/hooks/"* "${INSTALL_DATA}/hooks/" 2>/dev/null || true
cp -r "${ECOSYSTEM_SRC}/auto-dev/hooks/"* "${INSTALL_DATA}/hooks/" 2>/dev/null || true
if [ -f "${ECOSYSTEM_SRC}/hooks/run_hooks.py" ]; then
  cp "${ECOSYSTEM_SRC}/hooks/run_hooks.py" "${INSTALL_DATA}/hooks/" 2>/dev/null || true
fi

# Settings template
cp "${ECOSYSTEM_SRC}/settings.json" "${INSTALL_DATA}/settings.json" 2>/dev/null || true

# Ecosystem state
mkdir -p "${INSTALL_DATA}/ecosystem"
cp "${ECOSYSTEM_SRC}/ecosystem/feedback.json" "${INSTALL_DATA}/ecosystem/feedback.json" 2>/dev/null || true

# Adapt command template
cp "${ECOSYSTEM_SRC}/adapt-command.md" "${INSTALL_DATA}/adapt-command.md" 2>/dev/null || true

SKILL_COUNT=$(find "${INSTALL_DATA}/skills" -name "SKILL.md" 2>/dev/null | wc -l)
CMD_COUNT=$(find "${INSTALL_DATA}/commands" -name "*.md" 2>/dev/null | wc -l)
HOOK_COUNT=$(find "${INSTALL_DATA}/hooks" -maxdepth 1 -type d 2>/dev/null | tail -n +2 | wc -l)

info "Ecosystem data installed: ${INSTALL_DATA}"
info "  ${SKILL_COUNT} skills, ${CMD_COUNT} commands, ${HOOK_COUNT} hooks"

# ── PATH check ───────────────────────────────────────────────
if [[ ":${PATH}:" != *":${INSTALL_BIN}:"* ]]; then
  warn ""
  warn "⚠  ${INSTALL_BIN} is not in your PATH."
  warn ""
  warn "Add this to your shell profile (~/.bashrc, ~/.zshrc, or ~/.profile):"
  warn ""
  warn "    export PATH=\"\$HOME/.local/bin:\$PATH\""
  warn ""
  warn "Then restart your shell or run:"
  warn "    source ~/.bashrc   (or ~/.zshrc)"
  warn ""
fi

# ── Done ─────────────────────────────────────────────────────
echo ""
info "✅ Installation complete!"
echo ""
info "Quick start:"
info "  1. cd your-project/"
info "  2. adi-auto-dev init"
info "  3. Start Claude Code — ecosystem is active"
echo ""
info "Commands:"
info "  adi-auto-dev init          Deploy ecosystem to current project"
info "  adi-auto-dev init --global Deploy skills globally (all projects)"
info "  adi-auto-dev status        Show ecosystem status"
info "  adi-auto-dev remove        Remove ecosystem from current project"
info "  adi-auto-dev --help        Show all options"
echo ""
