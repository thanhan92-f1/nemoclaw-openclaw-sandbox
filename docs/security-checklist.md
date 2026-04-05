# Security Checklist

## Purpose

This checklist provides a repeatable security review for a NemoClaw and OpenClaw deployment on a cloud service or VPS.

Use it with:

- `../SECURITY.md`
- `hardening.md`
- `networking.md`
- `provider-rotation.md`

## 1. Host Access Checklist

- [ ] root login is restricted or disabled where operationally possible
- [ ] password SSH login is disabled where operationally possible
- [ ] only approved administrator keys are present
- [ ] stale operator accounts are removed or disabled
- [ ] sudo access is limited to the intended operators

## 2. Network Exposure Checklist

- [ ] only `80` and `443` are publicly exposed for application access
- [ ] `22` is exposed only when SSH administration is required
- [ ] `127.0.0.1:18789` is not publicly reachable
- [ ] firewall rules match the documented exposure model
- [ ] DNS points only to the intended host

## 3. Reverse Proxy Checklist

- [ ] `/etc/caddy/Caddyfile` points to `127.0.0.1:18789`
- [ ] Caddy config validates successfully
- [ ] old domains or routes are removed after migration
- [ ] HTTPS is active and serving the intended hostname only

## 4. Provider Security Checklist

- [ ] provider credentials are stored on the host through OpenShell
- [ ] no real provider secrets are placed in sandbox config
- [ ] old or unused provider keys are rotated or revoked
- [ ] `openshell inference get` matches the intended active provider

## 5. Policy Checklist

- [ ] policy rules were reviewed before apply
- [ ] endpoint scope is limited to required destinations only
- [ ] stale allow rules were removed after retired integrations
- [ ] Telegram or other channel access uses allowlists where applicable

## 6. Runtime and Service Checklist

- [ ] `docker`, `caddy`, and `nemoclaw-connect` are healthy
- [ ] `nemoclaw-connect` is not restarting unexpectedly
- [ ] binary paths in systemd units still match installed locations
- [ ] no unnecessary privileged runtime changes were introduced

## 7. Repository Hygiene Checklist

- [ ] `.env` files with real values are not committed
- [ ] credentials, tokens, and private keys are not present in docs
- [ ] examples use placeholders instead of live secrets
- [ ] `CHANGELOG.md` reflects security-relevant repository changes

## 8. Review Cadence

- [ ] daily service reachability review completed
- [ ] weekly firewall and provider review completed
- [ ] monthly patch and hardening review completed
- [ ] post-change validation completed after every security-sensitive update