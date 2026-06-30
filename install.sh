#!/usr/bin/env bash
# -------------------------------------------------------------
# ADI Ecosystem -- One-Time Installer
#
# Installs the `adi-ecosystem` CLI and ecosystem data to your system.
# After this, run `adi-ecosystem init` in any project root to deploy.
#
# Usage (from repo):
#   git clone <repo> && cd adi-ecosystem && bash install.sh
#
# Usage (remote):
#   curl -sSL https://raw.githubusercontent.com/aditya8281/adi-ecosystem/main/install.sh | bash
# -------------------------------------------------------------
set -euo pipefail

ECOSYSTEM_SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
INSTALL_BIN="${HOME}/.local/bin"
INSTALL_DATA="${HOME}/.adi-ecosystem"

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

info()  { printf "${GREEN}[adi]${NC} %s\n" "$*"; }
warn()  { printf "${YELLOW}[adi]${NC} %s\n" "$*"; }
error() { printf "${RED}[adi]${NC} %s\n" "$*" >&2; }

# -- Check prerequisites --------------------------------------
command -v git >/dev/null 2>&1 || { error "git required. Install git first."; exit 1; }
command -v python3 >/dev/null 2>&1 || { error "python3 required. Install python3 first."; exit 1; }

# -- Create directories ---------------------------------------
mkdir -p "${INSTALL_BIN}"
mkdir -p "${INSTALL_DATA}"

# -- Copy CLI script ------------------------------------------
cp "${ECOSYSTEM_SRC}/bin/adi-ecosystem" "${INSTALL_BIN}/adi-ecosystem"
chmod +x "${INSTALL_BIN}/adi-ecosystem"
info "CLI installed: ${INSTALL_BIN}/adi-ecosystem"

# -- Copy ecosystem data --------------------------------------
# Skills
mkdir -p "${INSTALL_DATA}/skills"
cp -r "${ECOSYSTEM_SRC}/skills/"* "${INSTALL_DATA}/skills/" 2>/dev/null || true

# Commands
mkdir -p "${INSTALL_DATA}/commands"
cp -r "${ECOSYSTEM_SRC}/commands/"* "${INSTALL_DATA}/commands/" 2>/dev/null || true

# Hooks
mkdir -p "${INSTALL_DATA}/hooks"
cp -r "${ECOSYSTEM_SRC}/hooks/"* "${INSTALL_DATA}/hooks/" 2>/dev/null || true

# Auto-enhance
mkdir -p "${INSTALL_DATA}/auto-enhance"
cp -r "${ECOSYSTEM_SRC}/auto-enhance/"* "${INSTALL_DATA}/auto-enhance/" 2>/dev/null || true

# Settings template
cp "${ECOSYSTEM_SRC}/settings.json" "${INSTALL_DATA}/settings.json" 2>/dev/null || true

# Ecosystem state
mkdir -p "${INSTALL_DATA}/ecosystem"
cp "${ECOSYSTEM_SRC}/ecosystem/feedback.json" "${INSTALL_DATA}/ecosystem/feedback.json" 2>/dev/null || true

SKILL_COUNT=$(find "${INSTALL_DATA}/skills" -name "SKILL.md" 2>/dev/null | wc -l)
CMD_COUNT=$(find "${INSTALL_DATA}/commands" -maxdepth 1 -name "*.md" 2>/dev/null | wc -l)
HOOK_COUNT=$(find "${INSTALL_DATA}/hooks" -maxdepth 1 -type d 2>/dev/null | tail -n +2 | wc -l)

info "Ecosystem data installed: ${INSTALL_DATA}"
info "  ${SKILL_COUNT} skills, ${CMD_COUNT} commands, ${HOOK_COUNT} hooks"

# -- PATH check -----------------------------------------------
if [[ ":${PATH}:" != *":${INSTALL_BIN}:"* ]]; then
  warn ""
  warn "${INSTALL_BIN} is not in your PATH."
  warn ""
  warn "Add this to your shell profile (~/.bashrc, ~/.zshrc, or ~/.profile):"
  warn ""
  warn "    export PATH=\"\$HOME/.local/bin:\$PATH\""
  warn ""
  warn "Then restart your shell or run:"
  warn "    source ~/.bashrc   (or ~/.zshrc)"
  warn ""
fi

# -- Done -----------------------------------------------------
echo ""
info "Installation complete!"
echo ""
info "Quick start:"
info "  1. cd your-project/"
info "  2. adi-ecosystem init"
info "  3. Start Claude Code -- ecosystem is active"
echo ""
info "Commands:"
info "  adi-ecosystem init          Deploy ecosystem to current project"
info "  adi-ecosystem init --global Deploy skills globally (all projects)"
info "  adi-ecosystem adapt         Adapt ecosystem to current project"
info "  adi-ecosystem enhance       Run learning cycle"
info "  adi-ecosystem status        Show ecosystem status"
info "  adi-ecosystem remove        Remove ecosystem from current project"
info "  adi-ecosystem uninstall     Remove CLI and all data from system"
info "  adi-ecosystem --help        Show all options"
echo ""
