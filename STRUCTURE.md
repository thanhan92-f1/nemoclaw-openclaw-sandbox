# Repository Structure

## Top-Level Layout

```text
nemoclaw-openclaw/
├─ .github/
│  ├─ CODEOWNERS
│  ├─ ISSUE_TEMPLATE/
│  │  ├─ bug_report.md
│  │  ├─ config.yml
│  │  ├─ question.md
│  │  ├─ security_report.md
│  │  └─ feature_request.md
│  ├─ workflows/
│  │  ├─ ci.yml
│  │  └─ codeql.yml
│  └─ PULL_REQUEST_TEMPLATE.md
├─ docs/
│  ├─ README.md
│  ├─ backup-and-restore.md
│  ├─ access-control.md
│  ├─ audit-checklist.md
│  ├─ capacity-planning.md
│  ├─ change-management.md
│  ├─ cloudservice-vps-setup.md
│  ├─ command-reference.md
│  ├─ communications-plan.md
│  ├─ configuration-baseline.md
│  ├─ control-mapping.md
│  ├─ credential-handling.md
│  ├─ dependency-review.md
│  ├─ disaster-recovery.md
│  ├─ decommissioning.md
│  ├─ faq.md
│  ├─ hardening.md
│  ├─ install-script.md
│  ├─ incident-response.md
│  ├─ known-limitations.md
│  ├─ licensing.md
│  ├─ logging.md
│  ├─ maintenance.md
│  ├─ maintenance-windows.md
│  ├─ migration.md
│  ├─ monitoring.md
│  ├─ networking.md
│  ├─ oncall-runbook.md
│  ├─ operator-onboarding.md
│  ├─ operator-handover.md
│  ├─ operations-checklist.md
│  ├─ operations-sla.md
│  ├─ policies.md
│  ├─ provider-rotation.md
│  ├─ providers.md
│  ├─ rollback-strategy.md
│  ├─ risk-register.md
│  ├─ acceptance-checklist.md
│  ├─ release-checklist.md
│  ├─ security-checklist.md
│  ├─ service-dependencies-matrix.md
│  ├─ skills-and-plugins.md
│  ├─ support-model.md
│  ├─ service-readiness.md
│  ├─ telegram-setup.md
│  ├─ troubleshooting.md
│  ├─ upgrade-runbook.md
│  ├─ validation-matrix.md
│  ├─ post-incident-review.md
│  └─ services-and-dependencies.md
├─ .env.example
├─ .gitignore
├─ CHANGELOG.md
├─ COMMERCIAL-LICENSE.md
├─ CONTRIBUTING.md
├─ INSTALL.md
├─ install.sh
├─ LICENSE
├─ NOTICE
├─ README.md
├─ RELEASING.md
├─ SECURITY.md
├─ STRUCTURE.md
├─ repo-sync.sh
├─ uninstall.sh
├─ update.sh
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
- `COMMERCIAL-LICENSE.md` — commercial rights and separate written permission guidance.
- `RELEASING.md` — release cadence and semantic versioning policy.
- `LICENSE` — canonical non-commercial license terms.
- `NOTICE` — short-form license notice and summary.
- `.env.example` — local environment variable template for safe operator setup.
- `install.sh` — primary lifecycle automation script.
- `update.sh` — wrapper for `install.sh update`.
- `uninstall.sh` — wrapper for `install.sh uninstall`.
- `repo-sync.sh` — wrapper for `install.sh repo-sync`.
- `.gitignore` — repository ignore rules.

### Source Guides

- `NemoClaw on Cloud or VPS.md` — primary deployment walkthrough.
- `NemoClaw_Command_Guide.md` — advanced operations, policies, skills, and channels.

### GitHub Automation

- `.github/CODEOWNERS` — default ownership and review routing.
- `.github/PULL_REQUEST_TEMPLATE.md` — pull request checklist.
- `.github/ISSUE_TEMPLATE/bug_report.md` — bug issue template.
- `.github/ISSUE_TEMPLATE/config.yml` — issue template configuration and contact links.
- `.github/ISSUE_TEMPLATE/question.md` — general clarification and usage question template.
- `.github/ISSUE_TEMPLATE/security_report.md` — security issue template for non-active disclosures and hardening concerns.
- `.github/ISSUE_TEMPLATE/feature_request.md` — feature issue template.
- `.github/workflows/ci.yml` — Markdown linting and workflow validation.
- `.github/workflows/codeql.yml` — GitHub Advanced Security scanning workflow.

### Documentation Directory

- `docs/README.md` — docs index.
- `docs/backup-and-restore.md` — backup and restore operations guide.
- `docs/access-control.md` — operator access boundary guide.
- `docs/audit-checklist.md` — periodic audit checklist.
- `docs/capacity-planning.md` — capacity review and sizing guide.
- `docs/change-management.md` — change planning and validation guide.
- `docs/cloudservice-vps-setup.md` — consolidated cloud service or VPS deployment runbook.
- `docs/services-and-dependencies.md` — required services, dependencies, ports, and file locations.
- `docs/command-reference.md` — operational command catalog.
- `docs/communications-plan.md` — operational communication planning guide.
- `docs/configuration-baseline.md` — expected runtime and host baseline guide.
- `docs/control-mapping.md` — control coverage and risk mapping guide.
- `docs/credential-handling.md` — credential handling and rotation hygiene guide.
- `docs/dependency-review.md` — dependency review and follow-up guide.
- `docs/disaster-recovery.md` — host rebuild and service recovery guide.
- `docs/decommissioning.md` — host retirement and shutdown guide.
- `docs/faq.md` — quick operator FAQ and navigation guide.
- `docs/hardening.md` — host and runtime hardening guide.
- `docs/install-script.md` — install and lifecycle script usage guide.
- `docs/incident-response.md` — incident triage and containment guide.
- `docs/known-limitations.md` — documented limits and non-goals guide.
- `docs/licensing.md` — non-commercial licensing explainer and commercial-use boundary guide.
- `docs/logging.md` — log collection and triage guide.
- `docs/maintenance.md` — routine maintenance guide.
- `docs/maintenance-windows.md` — maintenance planning and validation guide.
- `docs/migration.md` — migration and cutover guide.
- `docs/monitoring.md` — operational monitoring and health review guide.
- `docs/networking.md` — network exposure and routing guide.
- `docs/oncall-runbook.md` — first-response and escalation guide.
- `docs/operator-onboarding.md` — new operator onboarding guide.
- `docs/operator-handover.md` — operational handover guide.
- `docs/telegram-setup.md` — Telegram bridge and dashboard channel setup.
- `docs/operations-sla.md` — internal service expectation guide.
- `docs/providers.md` — provider registration and model routing guide.
- `docs/provider-rotation.md` — provider rotation and rollback guide.
- `docs/rollback-strategy.md` — rollback planning and validation guide.
- `docs/risk-register.md` — tracked risk overview and mitigation guide.
- `docs/acceptance-checklist.md` — deployment and change acceptance checklist.
- `docs/policies.md` — OpenShell network policy management guide.
- `docs/release-checklist.md` — release validation and publication checklist.
- `docs/security-checklist.md` — repeatable security review checklist.
- `docs/service-dependencies-matrix.md` — runtime dependency summary guide.
- `docs/skills-and-plugins.md` — skill import and plugin operations guide.
- `docs/support-model.md` — support routing and escalation guide.
- `docs/service-readiness.md` — service readiness and go-live guide.
- `docs/troubleshooting.md` — troubleshooting and recovery guide.
- `docs/operations-checklist.md` — install and operational checklists.
- `docs/upgrade-runbook.md` — upgrade planning, validation, and rollback guide.
- `docs/validation-matrix.md` — change validation summary guide.
- `docs/post-incident-review.md` — incident review and follow-up guide.

### Governance Files

- `SECURITY.md` — security reporting and hardening policy.
- `RELEASING.md` — release cadence and semantic versioning policy.

## Documentation Principles

- Keep instructions English-only.
- Prefer reproducible commands and explicit file paths.
- Separate install-time guidance from day-2 operations.
- Keep public exposure limited to reverse proxy endpoints.
