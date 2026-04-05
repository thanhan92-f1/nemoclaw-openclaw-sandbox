# Dependency Review Guide

## Purpose

This guide defines a simple review model for external and internal dependencies used by the documented deployment.

## Review Scope

Review dependencies such as:

- Docker
- OpenShell
- NemoClaw
- Caddy
- provider integrations
- optional Telegram channel components

## Review Questions

- is the dependency still required?
- does it remain supported and reachable?
- does it introduce new operational or security risk?
- is there a documented rollback or fallback path?

## Review Cadence

- monthly for high-impact runtime dependencies
- after incidents involving dependency behavior
- before major upgrades or migration work

## Minimum Review Output

Record:

- dependency name
- current operational role
- known failure effect
- fallback or replacement path
- follow-up action if needed

## Related Guides

- `services-and-dependencies.md`
- `service-dependencies-matrix.md`
- `risk-register.md`
- `capacity-planning.md`