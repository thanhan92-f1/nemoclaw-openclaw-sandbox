# Control Mapping Guide

## Purpose

This guide maps operational controls to the main risk areas in the documented deployment.

## Control Areas

| Risk Area | Primary Control | Supporting Guides |
|---|---|---|
| Public exposure | Limit public ports and keep gateway on localhost | `networking.md`, `hardening.md` |
| Credential handling | Keep secrets on the host and sanitize logs | `credential-handling.md`, `security-checklist.md` |
| Change risk | Use planned change and rollback workflow | `change-management.md`, `rollback-strategy.md` |
| Availability | Monitor services and maintain reconnect behavior | `monitoring.md`, `operations-sla.md` |
| Recovery readiness | Maintain backups and recovery guides | `backup-and-restore.md`, `disaster-recovery.md` |
| Documentation drift | Audit docs and update indexes after changes | `audit-checklist.md`, `README.md`, `docs/README.md` |
| Operator transition risk | Use structured handover and support routing | `operator-handover.md`, `support-model.md` |

## How to Use This Map

- review during audits
- review after incidents
- review when adding new automation or channels
- use it to identify weak control coverage

## Review Questions

- does each major risk area have at least one documented control?
- are the controls still practical for a single-host deployment?
- are the supporting guides current?

## Related Guides

- `risk-register.md`
- `audit-checklist.md`
- `security-checklist.md`
- `change-management.md`