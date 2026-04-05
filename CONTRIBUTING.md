# Contributing

## Scope

Contributions should improve deployment reliability, documentation quality, operational safety, or GitHub collaboration standards for the NemoClaw/OpenClaw sandbox stack.

## Before You Start

- Read `README.md` and `INSTALL.md`.
- Review the original operational guides.
- Keep changes aligned with Ubuntu 24.04 and cloud service or VPS assumptions unless clearly documented otherwise.
- Preserve security defaults: public `80/443` only, local gateway on `127.0.0.1:18789`.

## Contribution Flow

1. Create a focused branch.
2. Make small, reviewable changes.
3. Update related documentation when behavior changes.
4. Open a pull request using the repository template.

## Documentation Standards

- Use concise, enterprise-style English.
- Prefer verified commands over speculative notes.
- Mark destructive commands clearly.
- Use fenced code blocks with the correct language.
- Use backticks for commands, files, ports, services, and environment variables.

## Recommended Change Types

- Installation improvements
- Security hardening notes
- Command corrections
- Service dependency clarifications
- CI, template, and repository hygiene improvements

## Pull Request Expectations

Every pull request should include:

- What changed
- Why it changed
- Impacted files or services
- Validation performed
- Any rollback or migration considerations

## Validation Checklist

Before submitting:

- All Markdown files render correctly.
- Commands are internally consistent.
- Ports, paths, service names, and repository links are correct.
- GitHub Actions workflow remains valid.
- New instructions do not contradict the source guides without explicitly stating the reason.

## Security Review

Flag any change that affects:

- `OpenShell` policies
- exposed ports
- provider credentials
- `systemd` service behavior
- reverse proxy configuration
- Telegram or other channel integrations

## Out of Scope

Do not submit unreviewed secrets, tokens, credentials, or personally identifying information.
