# Access Control Guide

## Purpose

This guide documents operator access boundaries for a NemoClaw and OpenClaw deployment.

Use it with:

- `security-checklist.md`
- `hardening.md`
- `credential-handling.md`

## Access Principles

- grant the minimum access needed for each operator
- prefer named administrator accounts over shared accounts
- use SSH keys instead of passwords where possible
- review and remove stale access regularly

## Host Access

- maintain a limited set of approved operators
- prefer non-root users with controlled sudo access
- keep emergency root access tightly restricted and documented

## Service Access

- treat Docker group membership as privileged access
- restrict who can edit `systemd` units and Caddy config
- limit who can rotate provider credentials or change active inference settings

## Operational Reviews

- review SSH keys monthly
- review sudoers and operator accounts monthly
- remove access promptly when responsibilities change
- verify optional channel allowlists after each access-related update