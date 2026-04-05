# Post-Incident Review Guide

## Purpose

This guide defines a lightweight review process after an operational or security incident.

## Review Goals

- understand what happened
- identify contributing technical and process factors
- improve documentation and prevention controls
- avoid repeating the same failure mode

## When to Run a Review

Run a review after:

- critical public outage
- credential exposure concern
- failed rollback with production impact
- repeated reconnect instability
- any incident that revealed a major documentation or process gap

## Minimum Review Inputs

Collect:

- incident timeline
- impacted services and users
- commands and changes applied
- logs and status output
- rollback or recovery actions taken
- open follow-up risks

## Review Questions

- what was the triggering event?
- what made detection fast or slow?
- what increased the blast radius?
- what worked well during response?
- which runbooks were missing, unclear, or outdated?
- what should change in monitoring, baseline, or rollout process?

## Output Sections

Document the review using sections such as:

1. summary
2. impact
3. timeline
4. root cause or best current explanation
5. containment and recovery steps
6. lessons learned
7. follow-up actions

## Follow-Up Actions

Typical follow-up work includes:

- updating runbooks
- improving alerts or health checks
- tightening configuration baseline controls
- adding rollback checkpoints
- recording new risks in `risk-register.md`

## Review Discipline

- focus on process and technical learning
- keep evidence-based notes
- avoid vague conclusions without an action owner
- review whether acceptance criteria were weak or bypassed

## Related Guides

- `incident-response.md`
- `oncall-runbook.md`
- `change-management.md`
- `risk-register.md`