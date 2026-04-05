# Operations SLA Guide

## Purpose

This guide defines a lightweight service expectation model for operating the documented NemoClaw and OpenClaw deployment.

## Scope

This repository does not create a contractual SLA. It provides internal operating targets for:

- service availability review
- response prioritization
- maintenance planning
- incident communication discipline

## Suggested Service Targets

### Availability Target

- target public endpoint availability: `99.5%` monthly for a single-host deployment baseline

### Response Targets

- critical outage: investigate immediately
- degraded public access: investigate within the same operating day
- documentation-only issue: schedule in normal change planning

## Priority Model

### Critical

- public endpoint unavailable
- credential exposure with active risk
- failed rollback with production impact

### High

- provider routing broken but host reachable
- repeated reconnect failures
- major documentation mismatch causing unsafe operations

### Normal

- minor doc corrections
- non-blocking operational clarifications
- future improvements and follow-up tasks

## Review Model

- review daily health checks
- review weekly incident patterns
- review monthly whether targets remain realistic for the current host model

## Related Guides

- `maintenance.md`
- `incident-response.md`
- `support-model.md`