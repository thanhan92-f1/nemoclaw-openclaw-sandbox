# Incident Response Guide

## Purpose

This guide defines a practical response flow for security, availability, or configuration incidents affecting a NemoClaw and OpenClaw deployment.

Use it with:

- `security-checklist.md`
- `logging.md`
- `disaster-recovery.md`
- `migration.md`

## Incident Types

Use this guide for:

- public endpoint outage
- suspected credential exposure
- unintended configuration drift
- provider failure with operational impact
- suspicious access or policy behavior

## Immediate Response Priorities

1. stop making non-essential changes
2. assess whether the incident is active
3. preserve logs and current state evidence
4. contain the issue before broad remediation
5. document timeline, commands, and observed impact

## Triage Questions

- is the issue availability, integrity, or credential-related?
- is public access still required during investigation?
- did the issue start after a config, release, or provider rotation?
- is the fault host-side, proxy-side, sandbox-side, or provider-side?

## Initial Containment Actions

Depending on the incident:

- disable public exposure if the endpoint is unsafe
- rotate suspected exposed credentials
- revert to the last known-good provider or repository ref
- stop optional channels such as Telegram if they increase risk
- pause rollout or migration activity until the issue is understood

## Evidence Collection

Capture before destructive repair:

```bash
systemctl --failed
journalctl -u caddy -n 200 --no-pager
journalctl -u nemoclaw-connect -n 200 --no-pager
openshell forward list
openshell inference get
nemoclaw nemoclaw-sandbox status
```

Also record:

- exact failing command or request
- timestamps in UTC if possible
- affected domain or host
- recent config or DNS changes

## Containment by Scenario

### Credential Exposure

- revoke or rotate affected keys immediately
- confirm replacement provider configuration
- review logs for unauthorized usage signs

### Public Endpoint Exposure or Misrouting

- review firewall rules and Caddy config
- remove unintended routes or DNS records
- validate that `127.0.0.1:18789` is still private

### Broken Upgrade or Config Regression

- pin back to the last known-good repo ref
- validate service health after rollback
- document the exact change that triggered the issue

## Recovery Decision

Choose the lightest safe path:

- repair in place if impact is limited and evidence is sufficient
- roll back if a recent controlled change caused the incident
- rebuild or migrate if trust in the host state is no longer adequate

## Post-Incident Actions

- update runbooks if the incident exposed a documentation gap
- update `CHANGELOG.md` if repository-facing controls changed
- rotate remaining related credentials if scope is uncertain
- schedule a hardening review after recovery