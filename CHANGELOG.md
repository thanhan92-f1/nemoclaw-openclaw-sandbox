# Changelog

All notable changes to this repository will be documented in this file.

The format is based on `Keep a Changelog` and this repository currently tracks documentation and repository-governance changes.

## [Unreleased]

### Added

- initial repository documentation set for NemoClaw and OpenClaw deployment
- `INSTALL.md`, `STRUCTURE.md`, and `CONTRIBUTING.md`
- deployment runbooks in `docs/`
- GitHub pull request and issue templates
- GitHub Actions workflow for Markdown and workflow validation
- `SECURITY.md` and `.github/CODEOWNERS`
- focused setup guides for Telegram, providers, policies, skills, and plugins
- `docs/troubleshooting.md` and `docs/operations-checklist.md`
- `RELEASING.md` and `.github/ISSUE_TEMPLATE/security_report.md`
- `.github/workflows/ci.yml` for Markdown linting and workflow validation
- `docs/backup-and-restore.md` and `docs/upgrade-runbook.md`
- `.github/ISSUE_TEMPLATE/question.md`
- `install.sh` and `docs/install-script.md`
- `update.sh`, `uninstall.sh`, and `repo-sync.sh`
- `docs/hardening.md`
- `docs/disaster-recovery.md`
- `docs/monitoring.md`
- `docs/logging.md`
- `docs/faq.md`
- `.env.example`
- `docs/networking.md`
- `docs/provider-rotation.md`
- `docs/release-checklist.md`
- `docs/security-checklist.md`
- `docs/maintenance.md`
- `docs/migration.md`
- `docs/known-limitations.md`
- `docs/incident-response.md`
- `docs/access-control.md`
- `docs/credential-handling.md`
- `docs/decommissioning.md`
- `docs/operations-sla.md`
- `docs/support-model.md`
- `docs/audit-checklist.md`
- `docs/change-management.md`
- `docs/oncall-runbook.md`
- `docs/risk-register.md`
- `docs/acceptance-checklist.md`
- `docs/service-dependencies-matrix.md`
- `docs/capacity-planning.md`
- `docs/configuration-baseline.md`
- `docs/rollback-strategy.md`
- `docs/post-incident-review.md`
- `docs/operator-handover.md`
- `docs/maintenance-windows.md`
- `docs/control-mapping.md`
- `docs/validation-matrix.md`
- `docs/communications-plan.md`
- `docs/dependency-review.md`
- `docs/service-readiness.md`
- `docs/operator-onboarding.md`
- `docs/licensing.md`

### Changed

- expanded `.gitignore` for repository hygiene
- normalized docs references around the cloud service or VPS runbook filename
- standardized repository-facing branding around cloud service or VPS deployment wording
- aligned `LICENSE`, `NOTICE`, `COMMERCIAL-LICENSE.md`, `README.md`, and `web/index.html` around explicit non-commercial usage terms and commercial-rights reservation
- added early non-commercial license guidance to `CONTRIBUTING.md` and `.github/ISSUE_TEMPLATE/config.yml`
- added non-commercial compliance prompts to the PR template and public issue templates
- extended license guidance to `security_report.md` and linked `docs/licensing.md` from the website license section
- added a deployment-facing non-commercial license notice at the top of `INSTALL.md`
- harmonized the public commercial-rights warning text across `README.md`, `INSTALL.md`, and `web/index.html`
