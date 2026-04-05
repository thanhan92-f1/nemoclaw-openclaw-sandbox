# NemoClaw OpenClaw Sandbox

[![CI](https://github.com/thanhan92-f1/nemoclaw-openclaw-sandbox/actions/workflows/ci.yml/badge.svg)](https://github.com/thanhan92-f1/nemoclaw-openclaw-sandbox/actions/workflows/ci.yml)
[![License: Non-commercial](https://img.shields.io/badge/license-non--commercial-blue.svg)](./LICENSE)
[![Docs](https://img.shields.io/badge/docs-operational-green.svg)](./docs/README.md)

Operational documentation and repository scaffolding for deploying a `NemoClaw` sandbox with `OpenClaw` on a cloud service or VPS.

## Purpose

This repository standardizes installation, operations, contribution workflow, and GitHub collaboration files for a production-style NemoClaw deployment.

## Deployment Scope

This documentation is based on the local guides in:

- `NemoClaw on Cloud or VPS.md`
- `NemoClaw_Command_Guide.md`

It covers:

- VPS bootstrap on Ubuntu 24.04
- Docker and OpenShell installation
- NemoClaw onboarding and sandbox connection
- HTTPS exposure through Caddy
- systemd auto-reconnect service
- provider configuration for `Anthropic` and `OpenAI`
- optional Telegram bridge and policy management
- skills, plugins, and operational commands

## Repository Reference

Primary sandbox repository reference:

- `https://github.com/thanhan92-f1/nemoclaw-openclaw-sandbox.git`

## Quick Start

1. Read `INSTALL.md`.
2. Review `docs/services-and-dependencies.md`.
3. Follow `docs/cloudservice-vps-setup.md` for end-to-end deployment.
4. Use `docs/command-reference.md` for day-2 operations.
5. See `CONTRIBUTING.md` before opening changes.

## Repository Status

- Documentation-first repository
- Operational baseline for `cloud service or VPS` deployment
- Includes GitHub templates, CI validation, and governance files

## Core Components

- `Cloud service or VPS` with Ubuntu 24.04
- `Docker`
- `OpenShell`
- `NemoClaw`
- `OpenClaw Gateway`
- `Caddy`
- `systemd`
- optional channel services such as `Telegram`

## Security Baseline

- Expose only ports `80` and `443` publicly.
- Keep `127.0.0.1:18789` private behind Caddy.
- Store provider credentials on the VPS host through `OpenShell` providers.
- Use network policies instead of ad-hoc runtime approvals for permanent access.
- Treat `nemoclaw destroy`, `openshell gateway destroy`, and `openclaw configure` as destructive commands.

## Documentation Map

- `STRUCTURE.md` — repository layout
- `INSTALL.md` — installation and bootstrap guide
- `SECURITY.md` — security reporting and operational hardening notes
- `CHANGELOG.md` — tracked repository changes
- `RELEASING.md` — release and versioning policy
- `.env.example` — local-only environment variable template for operators
- `install.sh` — host bootstrap, repo sync, update, and managed uninstall helper
- `update.sh` / `uninstall.sh` / `repo-sync.sh` — thin wrappers around `install.sh` actions
- `docs/README.md` — documentation index
- `docs/cloudservice-vps-setup.md` — deployment runbook
- `docs/services-and-dependencies.md` — services, dependencies, ports, and files
- `docs/command-reference.md` — command reference and operational notes
- `docs/telegram-setup.md` — Telegram bridge and allowlist setup
- `docs/providers.md` — provider architecture and model configuration
- `docs/policies.md` — permanent and preset-based network policy management
- `docs/skills-and-plugins.md` — curated skill and plugin operations
- `docs/troubleshooting.md` — common failure patterns and recovery steps
- `docs/operations-checklist.md` — install, verification, and day-2 checklists
- `docs/backup-and-restore.md` — backup scope, archive workflow, and restore validation
- `docs/upgrade-runbook.md` — controlled upgrade workflow and rollback guidance
- `docs/install-script.md` — usage guide for `install.sh` and repo-ref based updates
- `docs/hardening.md` — host, SSH, Docker, proxy, and policy hardening baseline
- `docs/disaster-recovery.md` — service recovery flow for host loss or failed upgrades
- `docs/monitoring.md` — service health, reachability, and capacity review baseline
- `docs/logging.md` — primary log sources and incident log triage workflow
- `docs/faq.md` — quick operator answers for install, update, rollback, and recovery
- `docs/networking.md` — DNS, firewall, loopback gateway, and proxy network model
- `docs/provider-rotation.md` — provider key rotation and active provider switch workflow
- `docs/release-checklist.md` — repeatable release validation and tagging checklist
- `docs/security-checklist.md` — repeatable security review checklist
- `docs/maintenance.md` — daily, weekly, and monthly maintenance baseline
- `docs/migration.md` — controlled host or domain migration workflow
- `docs/known-limitations.md` — documented operational limits and constraints
- `docs/incident-response.md` — triage, containment, and recovery decision flow
- `docs/access-control.md` — operator access boundaries and review model
- `docs/credential-handling.md` — safe provider and token handling rules
- `docs/decommissioning.md` — host retirement and shutdown checklist
- `docs/operations-sla.md` — internal service targets and incident priority model
- `docs/support-model.md` — support routing and escalation model
- `docs/audit-checklist.md` — periodic operational and documentation audit checklist
- `docs/change-management.md` — controlled change workflow and validation discipline
- `docs/oncall-runbook.md` — first-response workflow and escalation model for operators
- `docs/risk-register.md` — tracked operational and security risks for the deployment model
- `docs/acceptance-checklist.md` — deployment and major-change acceptance criteria
- `docs/service-dependencies-matrix.md` — summarized dependency chain across host, runtime, proxy, and channels
- `docs/capacity-planning.md` — lightweight capacity review and host sizing guidance
- `docs/configuration-baseline.md` — expected deployment baseline and allowed deviation model
- `docs/rollback-strategy.md` — safe rollback decision and validation workflow
- `docs/post-incident-review.md` — lightweight review process after incidents
- `docs/operator-handover.md` — minimum transfer checklist for operational ownership
- `docs/maintenance-windows.md` — planning and validation model for maintenance windows
- `docs/control-mapping.md` — mapping of operational controls to deployment risk areas
- `docs/validation-matrix.md` — minimum validation expectations for common change types
- `docs/communications-plan.md` — communication model for planned work, incidents, and handover
- `docs/dependency-review.md` — lightweight dependency review and follow-up model
- `docs/service-readiness.md` — minimum readiness criteria after install, change, or recovery
- `docs/operator-onboarding.md` — onboarding path and basic responsibilities for new operators

## License

Non-commercial use only.

### Usage Terms

Allowed without separate commercial permission:

- personal learning and private experimentation
- academic or educational work
- internal research, testing, and evaluation
- internal non-commercial use by a company or organization

Not allowed without prior written commercial permission:

- selling, sublicensing, or commercializing the project or derivatives
- paid consulting, implementation, integration, deployment, or training
- paid client work, contract delivery, managed services, or outsourcing
- including the project in a paid product, hosted service, SaaS, bundle, or marketplace listing
- using the project in a workflow intended to generate revenue or commercial advantage

Important: availability on GitHub or npm does not grant any commercial right.

References:

- `LICENSE` — controlling license terms
- `NOTICE` — short license notice
- `COMMERCIAL-LICENSE.md` — commercial licensing information
- `docs/licensing.md` — operator-friendly licensing explainer

Attribution: `Nguyen Thanh An by Pho Tue SoftWare Solutions JSC`
