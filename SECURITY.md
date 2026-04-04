# Security Policy

## Supported Scope

This repository primarily contains deployment and operational documentation for a `NemoClaw` and `OpenClaw` sandbox environment.

Security-sensitive areas include:

- host firewall exposure
- reverse proxy configuration
- `OpenShell` policy changes
- provider credential handling
- `systemd` service behavior
- channel integrations such as `Telegram`

## Reporting a Vulnerability

Do not open a public issue for active security vulnerabilities involving:

- exposed services
- leaked credentials or tokens
- sandbox escape concerns
- policy bypass paths
- reverse proxy misconfiguration
- provider secret disclosure

Instead, report privately to the repository maintainers with:

- summary of the issue
- affected files or services
- reproduction conditions
- impact assessment
- suggested mitigation if available

If the repository exposes a dedicated private security reporting channel, use that channel first.

For non-active hardening gaps, documentation corrections, or low-risk security improvements, the dedicated `security_report` issue template may be used.

## Operational Security Rules

- Publicly expose only `80` and `443`.
- Keep `127.0.0.1:18789` private behind `Caddy`.
- Store real provider credentials on the host through `OpenShell` providers.
- Do not commit `.env` files, tokens, credentials, or private keys.
- Prefer permanent policy updates over repeated session-only approvals.
- Treat destructive commands as high risk and document them clearly.

## Hardening Priorities

1. Minimize public network exposure.
2. Keep reverse proxy and gateway boundaries explicit.
3. Review policy changes before applying them with `openshell policy set`.
4. Validate binary paths and permissions for `systemd` units.
5. Restrict Telegram or other channel access with allowlists.

## Non-Goals

This repository does not provide a managed secret storage service or automated incident response workflow.
