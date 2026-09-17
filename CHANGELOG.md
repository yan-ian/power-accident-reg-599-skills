# Changelog

本文件记录本 skill 包的所有重要变更。
格式遵循 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.1.0/)，版本号遵循 [语义化版本](https://semver.org/lang/zh-CN/)。

## [1.0.0] - 2026-09-17

### 新增

- 首次发布，蒸馏自《电力安全事故应急处置和调查处理条例》（国务院令第599号公布，第845号修订，2027-01-01 施行）。
- 交付 5 个 skill：
  - `power-accident-grade-classify` — 事故等级判定（五维度取高）
  - `power-accident-reporting` — 事故报告流程
  - `power-accident-emergency-response` — 事故应急处置
  - `power-accident-investigation` — 事故调查处理
  - `power-accident-liability-penalty` — 法律责任与罚则
- 每个 skill 含 `SKILL.md`（RIA++ 结构）与 `test-prompts.json`（darwin 兼容测试用例）。
- 附录文档：条例精华长文、术语词典、蒸馏产物索引。

### 说明

- 定级阈值与罚则依据 845 号修订版蒸馏。**法规修订后需同步更新。**
- 事故等级判定已明确排除纯人员伤亡/纯经济损失的生产安全事故（应适用《生产安全事故报告和调查处理条例》）。

[1.0.0]: https://github.com/yan-ian/power-accident-reg-599-skills/releases/tag/v1.0.0
