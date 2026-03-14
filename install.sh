#!/usr/bin/env bash
set -euo pipefail

# ─────────────────────────────────────────────────────
# OPNet Knowledge Plugin — Installer
# ─────────────────────────────────────────────────────

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${HOME}/.claude"
RULES_DIR="${CLAUDE_DIR}/rules/common"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[✓]${NC} $1"; }
warn() { echo -e "${YELLOW}[!]${NC} $1"; }

echo ""
echo "  OPNet Knowledge for Claude Code"
echo "  ────────────────────────────────"
echo ""

# Copy agent routing rules
mkdir -p "$RULES_DIR"
cp "${SCRIPT_DIR}/rules/agent-routing.md" "${RULES_DIR}/opnet-agent-routing.md"
info "Installed agent routing rules to ${RULES_DIR}/opnet-agent-routing.md"

echo ""
echo "  ────────────────────────────────"
echo ""
echo "  The routing rules are installed globally."
echo "  Claude will automatically detect OPNet projects and use"
echo "  the right agents based on what you're doing."
echo ""
echo "  To also get the slash commands and agents, run Claude with:"
echo ""
echo "    claude --plugin-dir ${SCRIPT_DIR}"
echo ""
echo "  Or add the marketplace:"
echo "    /plugin marketplace add shoebillrexmail-cmyk/opnet-knowledge"
echo ""

info "Installation complete!"
