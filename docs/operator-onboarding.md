# Operator Onboarding Guide

## Purpose

This guide gives a lightweight onboarding path for new operators who need to understand the documented deployment model.

## Onboarding Goals

- understand the host and sandbox architecture
- learn the core services and dependencies
- know the main runbooks for change, incident, and rollback work
- know where credentials and provider settings belong

## Recommended Reading Order

1. `../INSTALL.md`
2. `services-and-dependencies.md`
3. `cloudservice-vps-setup.md`
4. `command-reference.md`
5. `acceptance-checklist.md`
6. `oncall-runbook.md`
7. `rollback-strategy.md`
8. `operator-handover.md`

## Minimum Skills

New operators should be able to:

- check service status
- identify the active provider
- confirm the local gateway and public endpoint
- find rollback guidance
- hand over the system to another operator safely

## Suggested First Commands

```bash
systemctl status docker
systemctl status caddy
systemctl status nemoclaw-connect
openshell inference get
openshell forward list
nemoclaw nemoclaw-sandbox status
```

## Onboarding Completion

An operator is ready for limited responsibility when they can:

- explain the dependency chain
- locate the major runbooks
- complete basic validation checks
- describe when to escalate instead of improvising

## Related Guides

- `services-and-dependencies.md`
- `service-readiness.md`
- `support-model.md`
- `operator-handover.md`