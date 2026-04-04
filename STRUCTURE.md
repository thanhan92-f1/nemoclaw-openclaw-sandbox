# Repository Structure

## Top-Level Layout

```text
nemoclaw-openclaw/
├─ .github/
│  ├─ CODEOWNERS
│  ├─ ISSUE_TEMPLATE/
│  │  ├─ bug_report.md
│  │  └─ feature_request.md
│  ├─ workflows/
│  │  └─ ci.yml
│  └─ PULL_REQUEST_TEMPLATE.md
├─ docs/
│  ├─ README.md
│  ├─ command-reference.md
│  ├─  Cloud Service or VPS-vps-setup.md
│  ├─ policies.md
│  ├─ providers.md
│  ├─ skills-and-plugins.md
│  ├─ telegram-setup.md
│  └─ services-and-dependencies.md
├─ .gitignore
├─ CHANGELOG.md
├─ CONTRIBUTING.md
├─ INSTALL.md
├─ README.md
├─ SECURITY.md
├─ STRUCTURE.md
├─ NemoClaw on  Cloud Service or VPS VPS.md
└─ NemoClaw_Command_Guide.md
```

## File Roles

### Root Files

- `README.md` — project overview and entry point.
- `INSTALL.md` — installation guide with bootstrap flow and repository reference.
- `STRUCTURE.md` — this file.
- `CONTRIBUTING.md` — contribution and review expectations.
- `CHANGELOG.md` — tracked repository-level changes.
- `.gitignore` — repository ignore rules.

### Source Guides

- `NemoClaw on  Cloud Service or VPS VPS.md` — primary deployment walkthrough.
- `NemoClaw_Command_Guide.md` — advanced operations, policies, skills, and channels.

### GitHub Automation

- `.github/CODEOWNERS` — default ownership and review routing.
- `.github/PULL_REQUEST_TEMPLATE.md` — pull request checklist.
- `.github/ISSUE_TEMPLATE/bug_report.md` — bug issue template.
- `.github/ISSUE_TEMPLATE/feature_request.md` — feature issue template.
- `.github/workflows/ci.yml` — markdown and workflow validation.

### Documentation Directory

- `docs/README.md` — docs index.
- `docs/ Cloud Service or VPS-setup.md` — consolidated  Cloud Service or VPS deployment runbook.
- `docs/services-and-dependencies.md` — required services, dependencies, ports, and file locations.
- `docs/command-reference.md` — operational command catalog.
- `docs/telegram-setup.md` — Telegram bridge and dashboard channel setup.
- `docs/providers.md` — provider registration and model routing guide.
- `docs/policies.md` — OpenShell network policy management guide.
- `docs/skills-and-plugins.md` — skill import and plugin operations guide.

### Governance Files

- `SECURITY.md` — security reporting and hardening policy.

## Documentation Principles

- Keep instructions English-only.
- Prefer reproducible commands and explicit file paths.
- Separate install-time guidance from day-2 operations.
- Keep public exposure limited to reverse proxy endpoints.
