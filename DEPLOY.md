# 部署说明（DEPLOY）

本文件说明如何把本 skill 包发布到 GitHub。

**当前状态**：本地仓库已初始化并完成 2 次提交，**尚待推送至远端**。
推送需先完成下面「第一步」的凭证配置。

---

## 第一步：配置 GitHub 凭证（二选一）

### 方案 A：gh CLI（推荐，最省事）

```bash
# 1. 安装 gh CLI
#    Windows: winget install --id GitHub.cli
#    或下载: https://cli.github.com/

# 2. 登录（浏览器交互式授权）
gh auth login
#    → 选择 GitHub.com → HTTPS → 用浏览器登录

# 3. 一键部署（脚本会创建仓库并推送）
bash scripts/deploy.sh yan-ian power-accident-reg-599-skills
```

### 方案 B：手动创建仓库 + git push

若不便安装 gh CLI：

1. 打开 <https://github.com/new>
2. 仓库名填 `power-accident-reg-599-skills`，**不要**勾选 "Add a README"（本地已有）
3. 创建后执行：

```bash
cd <本目录>

# 使用 Personal Access Token（PAT）
git remote add origin https://github.com/yan-ian/power-accident-reg-599-skills.git
git push -u origin main
# 提示输入密码时，粘贴 PAT（需 repo 权限）
```

如已有 SSH key，可改用：

```bash
git remote add origin git@github.com:yan-ian/power-accident-reg-599-skills.git
git push -u origin main
```

> **Token 创建**：<https://github.com/settings/tokens> → Fine-grained token → 勾选目标仓库的 `Contents: Read and write`。

---

## 第二步：验证部署

推送成功后应能在以下地址看到仓库：

```
https://github.com/yan-ian/power-accident-reg-599-skills
```

同时 `.github/workflows/validate-skills.yml` 会自动运行，校验：

- 根目录必需文件是否齐全
- 每个 skill 是否都有 `SKILL.md` + `test-prompts.json`
- `SKILL.md` 的 frontmatter 字段是否完整、`name` 是否与目录名一致
- RIA++ 段落（R / I / A1 / A2）是否齐全
- `test-prompts.json` 是否为合法 JSON

---

## 第三步（可选）：开启 GitHub Pages

交互式知识库 `knowledge-base/index.html` 可部署为在线页面：

1. 仓库 → Settings → Pages
2. Source 选 `Deploy from a branch`
3. Branch 选 `main`，目录选 `/ (root)`
4. 保存后访问：`https://yan-ian.github.io/power-accident-reg-599-skills/knowledge-base/`

---

## 备选：不推 GitHub，直接离线分发

已生成发布包，可直接发给他人或上传到任意平台：

```
D:\WorkBuddyWorkspace\2026-09-17-13-03-34\power-accident-reg-599-skills.zip
```

对方解压后把 `skills/*` 复制到自己的 skills 目录即可使用。

---

## 疑难排查

| 现象 | 原因 | 处理 |
|---|---|---|
| `403 Resource not accessible by integration` | 使用了只读的 MCP connector 授权 | 改用本文件第一步的 gh CLI / PAT 方式 |
| `remote origin already exists` | 已配置过远端 | `git remote set-url origin <新URL>` |
| `failed to push some refs` | 远端有本地没有的提交 | `git pull --rebase origin main` 后再推 |
| `Permission denied (publickey)` | SSH key 未配置 | 改用 HTTPS + PAT，或配置 SSH key |
