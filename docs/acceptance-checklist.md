# Acceptance Checklist

## Purpose

This checklist helps operators decide whether a new deployment, migration, upgrade, or major change is ready for normal operation.

## Usage

Use this checklist after:

- first-time installation
- host migration
- domain or proxy cutover
- provider rotation with material config changes
- major upgrade or rollback event

## Deployment Acceptance

- [ ] host is reachable through approved administration paths
- [ ] Ubuntu baseline and package updates were applied intentionally
- [ ] Docker is running and enabled
- [ ] OpenShell commands work under the intended operator account
- [ ] NemoClaw install completed without unresolved errors
- [ ] sandbox connection is active
- [ ] OpenClaw gateway is reachable on `127.0.0.1:18789`
- [ ] public HTTPS endpoint responds as expected
- [ ] only ports `80` and `443` are publicly exposed
- [ ] reverse proxy configuration was reviewed before reload

## Provider Acceptance

- [ ] active provider is configured and verified
- [ ] fallback provider exists or risk is accepted explicitly
- [ ] provider credentials are stored on the host, not inside sandbox files
- [ ] model routing through `https://inference.local/v1` works as expected

## Operational Acceptance

- [ ] `nemoclaw-connect.service` is enabled if persistent reconnect is required
- [ ] service restart and reboot behavior were tested
- [ ] essential commands are documented for the operator handoff
- [ ] monitoring and log review paths are known
- [ ] backup scope is defined
- [ ] rollback path is documented for the applied change

## Security Acceptance

- [ ] no secrets were committed to the repository
- [ ] log samples and tickets were sanitized
- [ ] SSH and host access follow the documented control model
- [ ] policy changes were reviewed for least privilege
- [ ] no unnecessary public network exposure remains

## Documentation Acceptance

- [ ] affected runbooks were updated
- [ ] README or docs index references were updated if needed
- [ ] change notes were added to `CHANGELOG.md` if repository content changed
- [ ] open follow-up risks or limitations were recorded

## Sign-Off Guidance

Accept the change only when:

- the public path works end to end
- operators can recover using documented steps
- no unresolved high-risk issue remains without explicit approval

## Related Guides

- `operations-checklist.md`
- `release-checklist.md`
- `change-management.md`
- `upgrade-runbook.md`
- `migration.md`