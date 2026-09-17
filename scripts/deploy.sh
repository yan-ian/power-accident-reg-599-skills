#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
# 一键部署脚本：把本 skill 包推送到 GitHub
#
# 使用前提：本地已有可用的 GitHub 凭证（HTTPS token 或 SSH key）
# 用法：
#   bash scripts/deploy.sh <你的GitHub用户名> [仓库名]
# 示例：
#   bash scripts/deploy.sh yan-ian power-accident-reg-599-skills
# ─────────────────────────────────────────────────────────────
set -euo pipefail

OWNER="${1:-yan-ian}"
REPO="${2:-power-accident-reg-599-skills}"
DESCRIPTION="《电力安全事故应急处置和调查处理条例》（国务院令第599号公布/第845号修订）蒸馏而成的 Agent Skills 套件"

cd "$(dirname "$0")/.."

echo "▶ 目标仓库: ${OWNER}/${REPO}"

# ── 1. 检查凭证 ─────────────────────────────────────────────
if ! command -v gh >/dev/null 2>&1; then
  echo "✗ 未检测到 gh CLI。"
  echo "  安装：https://cli.github.com/  然后执行: gh auth login"
  echo "  或手动创建仓库后执行: git remote add origin <url> && git push -u origin main"
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "✗ gh 未登录。请先执行: gh auth login"
  exit 1
fi

# ── 2. 创建远端仓库（已存在则跳过）──────────────────────────
if gh repo view "${OWNER}/${REPO}" >/dev/null 2>&1; then
  echo "• 仓库已存在，跳过创建"
else
  echo "• 创建远端仓库…"
  gh repo create "${OWNER}/${REPO}" --public --description "$DESCRIPTION"
fi

# ── 3. 关联并推送 ───────────────────────────────────────────
if ! git remote get-url origin >/dev/null 2>&1; then
  git remote add origin "https://github.com/${OWNER}/${REPO}.git"
fi

echo "• 推送 main 分支…"
git push -u origin main --force

echo ""
echo "✓ 部署完成：https://github.com/${OWNER}/${REPO}"
