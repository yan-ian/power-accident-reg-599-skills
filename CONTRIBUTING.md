# 贡献指南

感谢你对本 skill 包的兴趣。本仓库的定位是**把电力安全法规蒸馏成 agent 可直接使用的可执行技能**，因此贡献标准与普通文档仓库不同。

---

## 什么是最有价值的贡献

按优先级排序：

### 1. 法规更新同步（最高优先级）

条例修订后，以下内容必须同步：

- **定级阈值**（`power-accident-grade-classify`）——减供负荷比例、停电用户比例、电压偏离阈值等
- **罚则金额**（`power-accident-liability-penalty`）——单位罚款区间、个人年收入罚款比例
- **报告时限**（`power-accident-reporting`）——逐级报告的时限要求
- **调查期限**（`power-accident-investigation`）——60 日 / 45 日等
- **文号与施行日期**（全仓库 README 与本文件）

提交时请附**官方文本链接或文号**作为依据。

### 2. 真实案例补充

在对应 skill 的 `A1 — 书中的应用` 段落补充真实案例。格式：

```markdown
### 案例 N：<一句话标题>
- **问题**: <事实>
- **方法论使用**: <用了哪条判定逻辑>
- **结论**: <定级/处置结果>
- **结果**: <后续动作或关联 skill>
```

**要求**：脱敏处理，不得包含可识别当事单位与人员的真实信息。

### 3. 触发出错修复（对应 `test-prompts.json`）

如果你发现 skill **误触发**（该响应的场景没响应）或**漏触发**（不该响应却响应了），请提交对应的 prompt 样本：

```json
{
  "prompt": "你的输入",
  "expected_skill": "power-accident-grade-classify",
  "expected_behaviour": "应输出特别重大事故",
  "category": "positive | negative | decoy"
}
```

其中 `decoy` 类型（跨 skill 诱饵）尤其有价值——它检验 skill 之间的边界是否清晰。

---

## 什么不会被接受

- **法规全文搬运**：本仓库不是法条库，只接受蒸馏后的可执行逻辑
- **主观评论或政策建议**：保持中立、可溯源
- **未脱敏的真实事故信息**
- **引入外部依赖**：`SKILL.md` 必须保持纯文本、零依赖、可离线使用

---

## SKILL.md 结构规范

所有 skill 必须遵循 **RIA++ 结构**，不得删减段落：

```markdown
---
name: <skill-name，与目录名一致>
description: |
  <正向触发场景>。不适用于：<负向排除>。关键 trigger：<用户可能说的原话>
source_book: <法源>
source_chapter: <对应条文/附件>
tags: [<标签>]
related_skills: [<相邻 skill>]
---

# <中文标题>

## R — 原文（Reading）
## I — 方法论骨架（Interpretation）
## A1 — 书中的应用（Past Application）
## A2 — 触发场景（Future Trigger）★
## E — 执行步骤（Execution）
```

**关键要求**：

- `description` 必须同时写**正向 trigger** 和**负向排除**，这是避免 skill 串味的核心机制
- **R 段引用的原文必须可追溯到具体条文编号**
- **A2 段的语言信号**应尽量贴近用户真实口语（「这算几级」「够不够特别重大」）

---

## 提交流程

```bash
# 1. Fork 本仓库
# 2. 创建分支
git checkout -b feat/add-case-xxx

# 3. 提交（遵循 Conventional Commits）
git commit -m "feat(grade-classify): 补充省会城市档位定级案例"

# 4. 推送并开 PR
git push origin feat/add-case-xxx
```

Commit 类型约定：

| 类型 | 用途 |
|---|---|
| `feat` | 新增案例/skill/文档 |
| `fix` | 修正错误阈值、错别字、失效链接 |
| `sync` | 法规更新同步 |
| `docs` | 纯文档调整 |
| `chore` | 仓库配置 |

---

## 审核标准

PR 合并前会检查：

1. **准确性**：数值、条文编号是否与官方文本一致
2. **可追溯性**：是否注明依据来源
3. **结构完整性**：RIA++ 段落是否齐全
4. **脱敏**：是否移除真实当事方信息
5. **零依赖**：是否引入外部链接（除法源外）

---

## License

提交即表示同意你的贡献以 [MIT](./LICENSE) 许可发布。
