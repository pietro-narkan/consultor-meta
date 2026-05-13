#!/usr/bin/env bash
# Desinstala la skill meta-ads-strategist y los comandos asociados.

set -euo pipefail

SKILLS_DIR="${HOME}/.claude/skills"
COMMANDS_DIR="${HOME}/.claude/commands"

rm -rf "$SKILLS_DIR/meta-ads-strategist"
rm -f "$COMMANDS_DIR/meta-brief.md"
rm -f "$COMMANDS_DIR/meta-audit.md"

echo "✓ Desinstalado meta-ads-strategist y comandos asociados."
