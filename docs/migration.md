# Migration Guide

## Purpose

This guide describes how to migrate a NemoClaw and OpenClaw deployment between hosts or domains with controlled downtime.

Use it with:

- `backup-and-restore.md`
- `disaster-recovery.md`
- `networking.md`
- `install-script.md`

## Common Migration Scenarios

- moving to a new VPS provider
- moving to a larger host size
- changing the public domain or subdomain
- rebuilding on a cleaner baseline host

## Pre-Migration Checklist

- capture current provider state
- back up relevant configuration and notes
- document active DNS records
- identify the desired repository ref for the target host
- confirm rollback path if the migration must be reversed

## Migration Flow

### 1. Prepare the New Host

- provision the new Ubuntu host
- restore SSH administrative access
- clone the repository or sync the chosen ref

### 2. Build the New Environment

Use manual or scripted install:

```bash
sudo bash install.sh install --domain sandbox.example.cloud
```

### 3. Recreate Providers and Policies

- re-create host-side providers
- restore intended inference selection
- reapply required policies and optional channel integrations

### 4. Validate Before Cutover

- confirm local gateway health
- confirm Caddy validation
- confirm public HTTPS on the new host if staged DNS is available

### 5. Cut Over DNS

- update DNS to the new host
- monitor TLS and reachability after propagation

### 6. Decommission the Old Host

- revoke or rotate credentials if needed
- archive final logs if required
- remove old public exposure once the new host is stable