#!/usr/bin/env bash
# Instala la skill meta-ads-strategist y los comandos /meta-brief y /meta-audit
# en ~/.claude/. Idempotente: correrlo de nuevo actualiza los archivos.

set -euo pipefail

REPO_URL="https://github.com/pietro-narkan/consultor-meta"
BRANCH="main"
SKILLS_DIR="${HOME}/.claude/skills"
COMMANDS_DIR="${HOME}/.claude/commands"

# Si el script se ejecuta desde una copia local del repo, usar esa.
# Si se ejecuta vía curl | sh, clonar a un tmpdir.
if [[ -f "$(dirname "${BASH_SOURCE[0]}")/skills/meta-ads-strategist/SKILL.md" ]]; then
  SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  echo "→ Instalando desde copia local: $SRC"
else
  TMPDIR="$(mktemp -d)"
  trap 'rm -rf "$TMPDIR"' EXIT
  echo "→ Descargando consultor-meta..."
  git clone --depth 1 --branch "$BRANCH" "$REPO_URL" "$TMPDIR/consultor-meta" >/dev/null 2>&1
  SRC="$TMPDIR/consultor-meta"
fi

mkdir -p "$SKILLS_DIR" "$COMMANDS_DIR"

echo "→ Copiando skill meta-ads-strategist..."
rm -rf "$SKILLS_DIR/meta-ads-strategist"
cp -r "$SRC/skills/meta-ads-strategist" "$SKILLS_DIR/"

echo "→ Copiando comandos /meta-brief y /meta-audit..."
cp "$SRC/commands/meta-brief.md" "$COMMANDS_DIR/"
cp "$SRC/commands/meta-audit.md" "$COMMANDS_DIR/"

echo ""
echo "✓ Instalado:"
echo "  - $SKILLS_DIR/meta-ads-strategist/"
echo "  - $COMMANDS_DIR/meta-brief.md"
echo "  - $COMMANDS_DIR/meta-audit.md"
echo ""
echo "Abrí una sesión nueva de Claude Code para que cargue la skill y los comandos."
