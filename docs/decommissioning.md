# Decommissioning Guide

## Purpose

This guide describes how to retire a host or deployment safely after migration, replacement, or service shutdown.

Use it with:

- `migration.md`
- `disaster-recovery.md`
- `credential-handling.md`

## Pre-Decommission Checklist

- confirm replacement service is stable if migration occurred
- confirm required backups and logs were archived
- identify credentials that must be rotated or revoked
- confirm DNS cutover is complete

## Decommission Flow

1. disable public routing to the old host
2. archive required logs and operational notes
3. rotate or revoke old provider and channel credentials if needed
4. remove public firewall exposure
5. remove or destroy the host only after verification that it is no longer needed

## After Decommission

- update documentation if the topology changed
- remove stale DNS records
- confirm no old host references remain in runbooks or checklists