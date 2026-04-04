# Documentation Index

## Documents

- `cloudservice-vps-setup.md` — full deployment runbook for cloud service or VPS deployment.
- `services-and-dependencies.md` — required services, dependencies, ports, files, and ownership.
- `command-reference.md` — operations, policies, skills, plugins, and monitoring commands.
- `telegram-setup.md` — Telegram bridge, policy, and allowlist setup.
- `providers.md` — provider registration and `inference.local` model routing.
- `policies.md` — permanent policy editing and preset workflow.
- `skills-and-plugins.md` — safe skill import and plugin management.
- `troubleshooting.md` — recovery guidance for common operational failures.
- `operations-checklist.md` — install, validation, and day-2 checklists.

## Recommended Reading Order

1. `../INSTALL.md`
2. `cloudservice-vps-setup.md`
3. `services-and-dependencies.md`
4. `command-reference.md`
5. `providers.md`
6. `telegram-setup.md`
7. `policies.md`
8. `skills-and-plugins.md`
9. `troubleshooting.md`
10. `operations-checklist.md`

## Operational Model

The deployment pattern is:

1. A cloud service or VPS provides the Ubuntu host.
2. Docker and OpenShell manage the secure sandbox runtime.
3. NemoClaw provisions and connects the sandbox.
4. OpenClaw serves the gateway locally on `127.0.0.1:18789`.
5. Caddy exposes HTTPS on `443`.
6. systemd keeps the connection healthy across reboots and session expiry.
