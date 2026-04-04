# Repository Structure

## Top-Level Layout

```text
nemoclaw-openclaw/
├─ .github/
│  ├─ CODEOWNERS
│  ├─ ISSUE_TEMPLATE/
│  │  ├─ bug_report.md
│  │  ├─ config.yml
│  │  ├─ security_report.md
│  │  └─ feature_request.md
│  ├─ workflows/
│  │  └─ ci.yml
│  └─ PULL_REQUEST_TEMPLATE.md
├─ docs/
│  ├─ README.md
│  ├─ cloudservice-vps-setup.md
│  ├─ command-reference.md
│  ├─ operations-checklist.md
│  ├─ policies.md
│  ├─ providers.md
│  ├─ skills-and-plugins.md
│  ├─ telegram-setup.md
│  ├─ troubleshooting.md
│  └─ services-and-dependencies.md
├─ .gitignore
├─ CHANGELOG.md
├─ CONTRIBUTING.md
├─ INSTALL.md
├─ README.md
├─ RELEASING.md
├─ SECURITY.md
├─ STRUCTURE.md
├─ NemoClaw on Cloud or VPS.md
└─ NemoClaw_Command_Guide.md
```

## File Roles

### Root Files

- `README.md` — project overview and entry point.
- `INSTALL.md` — installation guide with bootstrap flow and repository reference.
- `STRUCTURE.md` — this file.
- `CONTRIBUTING.md` — contribution and review expectations.
- `CHANGELOG.md` — tracked repository-level changes.
- `RELEASING.md` — release cadence and semantic versioning policy.
- `.gitignore` — repository ignore rules.

### Source Guides

- `NemoClaw on Cloud or VPS.md` — primary deployment walkthrough.
- `NemoClaw_Command_Guide.md` — advanced operations, policies, skills, and channels.

### GitHub Automation

- `.github/CODEOWNERS` — default ownership and review routing.
- `.github/PULL_REQUEST_TEMPLATE.md` — pull request checklist.
- `.github/ISSUE_TEMPLATE/bug_report.md` — bug issue template.
- `.github/ISSUE_TEMPLATE/config.yml` — issue template configuration and contact links.
- `.github/ISSUE_TEMPLATE/security_report.md` — security issue template for non-active disclosures and hardening concerns.
- `.github/ISSUE_TEMPLATE/feature_request.md` — feature issue template.
- `.github/workflows/ci.yml` — markdown and workflow validation.

### Documentation Directory

- `docs/README.md` — docs index.
- `docs/cloudservice-vps-setup.md` — consolidated cloud service or VPS deployment runbook.
- `docs/services-and-dependencies.md` — required services, dependencies, ports, and file locations.
- `docs/command-reference.md` — operational command catalog.
- `docs/telegram-setup.md` — Telegram bridge and dashboard channel setup.
- `docs/providers.md` — provider registration and model routing guide.
- `docs/policies.md` — OpenShell network policy management guide.
- `docs/skills-and-plugins.md` — skill import and plugin operations guide.
- `docs/troubleshooting.md` — troubleshooting and recovery guide.
- `docs/operations-checklist.md` — install and operational checklists.

### Governance Files

- `SECURITY.md` — security reporting and hardening policy.
- `RELEASING.md` — release cadence and semantic versioning policy.

## Documentation Principles

- Keep instructions English-only.
- Prefer reproducible commands and explicit file paths.
- Separate install-time guidance from day-2 operations.
- Keep public exposure limited to reverse proxy endpoints.
