# NemoClaw OpenClaw Sandbox

Operational documentation and repository scaffolding for deploying a `NemoClaw` sandbox with `OpenClaw` on a Cloud Service or VPS.

## Purpose

This repository standardizes installation, operations, contribution workflow, and GitHub collaboration files for a production-style NemoClaw deployment.

## Deployment Scope

This documentation is based on the local guides in:

- `NemoClaw on  Cloud Service or VPS VPS.md`
- `NemoClaw_Command_Guide.md`

It covers:

- VPS bootstrap on Ubuntu 24.04
- Docker and OpenShell installation
- NemoClaw onboarding and sandbox connection
- HTTPS exposure through Caddy
- systemd auto-reconnect service
- Provider configuration for `Anthropic` and `OpenAI`
- Optional Telegram bridge and policy management
- Skills, plugins, and operational commands

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

[![CI](https://github.com/thanhan92-f1/nemoclaw-openclaw-sandbox/actions/workflows/ci.yml/badge.svg)](https://github.com/thanhan92-f1/nemoclaw-openclaw-sandbox/actions/workflows/ci.yml)
[![License: GPL-3.0-or-later](https://img.shields.io/badge/license-GPL--3.0--or--later-blue.svg)](./LICENSE)
[![Docs](https://img.shields.io/badge/docs-operational-green.svg)](./docs/README.md)

Operational documentation and repository scaffolding for deploying a `NemoClaw` sandbox with `OpenClaw` on a cloud service or VPS.
## Core Components

- `NemoClaw on Cloud or VPS.md`
- `Docker`
3. Follow `docs/cloudservice-vps-setup.md` for end-to-end deployment.
- Operational baseline for `cloud service or VPS` deployment
- `Cloud service or VPS` with Ubuntu 24.04
- `CHANGELOG.md` — tracked repository changes
- `RELEASING.md` — release and versioning policy
- `docs/README.md` — documentation index
- `docs/cloudservice-vps-setup.md` — deployment runbook
- Optional channel services such as `Telegram`

## Security Baseline
- `docs/troubleshooting.md` — common failure patterns and recovery steps
- `docs/operations-checklist.md` — install, verification, and day-2 checklists

- Expose only ports `80` and `443` publicly.
- Keep `127.0.0.1:18789` private behind Caddy.
- Store provider credentials on the VPS host through `OpenShell providers`.
- Use network policies instead of ad-hoc runtime approvals for permanent access.
- Treat `nemoclaw destroy`, `openshell gateway destroy`, and `openclaw configure` as destructive commands.

## Documentation Map

- `STRUCTURE.md` — repository layout
- `INSTALL.md` — installation and bootstrap guide
- `SECURITY.md` — security reporting and operational hardening notes
- `CHANGELOG.md` — tracked repository changes
- `docs/README.md` — documentation index
- `docs/cloudservice-vps-setup.md` — deployment runbook
- `docs/services-and-dependencies.md` — services, dependencies, ports, and files
- `docs/command-reference.md` — command reference and operational notes
- `docs/telegram-setup.md` — Telegram bridge and allowlist setup
- `docs/providers.md` — provider architecture and model configuration
- `docs/policies.md` — permanent and preset-based network policy management
- `docs/skills-and-plugins.md` — curated skill and plugin operations

## License

See `LICENSE`.

Attribution: `Nguyen Thanh An by Pho Tue SoftWare Solutions JSC`
