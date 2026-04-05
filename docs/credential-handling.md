# Credential Handling Guide

## Purpose

This guide defines safe handling rules for provider keys, tokens, and related secrets used by the deployment.

Use it with:

- `providers.md`
- `provider-rotation.md`
- `security-checklist.md`

## Handling Rules

- keep real provider credentials on the host through OpenShell providers
- do not commit secrets to the repository
- do not paste live credentials into documentation or issue reports
- rotate credentials after suspected exposure or operator turnover

## Environment Files

- use `.env.example` only as a placeholder reference
- keep any real local environment files outside version control
- verify shells and logs do not expose exported secrets unnecessarily

## Rotation Triggers

- suspected exposure
- staff or operator access changes
- provider-side revocation or expiry
- planned security maintenance