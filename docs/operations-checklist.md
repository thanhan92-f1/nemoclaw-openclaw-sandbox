# Operations Checklist

## Purpose

This checklist provides repeatable validation steps for installation, first launch, and day-2 operations.

## 1. Pre-Install Checklist

- [ ] Ubuntu `24.04` host is provisioned
- [ ] minimum sizing target is met
- [ ] firewall access is available
- [ ] ports `80` and `443` are the only planned public ports
- [ ] NVIDIA API key is available
- [ ] Anthropic and optional OpenAI API keys are available
- [ ] public domain or subdomain is available

## 2. Host Bootstrap Checklist

- [ ] `apt update && apt upgrade -y` completed
- [ ] Docker installed and enabled
- [ ] `/etc/docker/daemon.json` updated for cgroup mode
- [ ] OpenShell installed
- [ ] NemoClaw installed
- [ ] `~/.bashrc` updated for `nvm` and `~/.local/bin`
- [ ] `which nemoclaw` returns a valid binary path
- [ ] `which openshell` returns a valid binary path

## 3. Onboarding Checklist

- [ ] `nemoclaw onboard` completed
- [ ] sandbox name confirmed
- [ ] required presets selected only when needed
- [ ] local connection starts successfully
- [ ] gateway available on `127.0.0.1:18789`

## 4. Resilience Checklist

- [ ] `~/.ssh/config` contains keepalive settings
- [ ] `/etc/systemd/system/nemoclaw-connect.service` created
- [ ] `systemctl enable nemoclaw-connect` completed
- [ ] `systemctl status nemoclaw-connect` is healthy

## 5. HTTPS Checklist

- [ ] Caddy installed
- [ ] `/etc/caddy/Caddyfile` points to `127.0.0.1:18789`
- [ ] `systemctl status caddy` is healthy
- [ ] public domain resolves correctly
- [ ] HTTPS endpoint is reachable

## 6. Provider Checklist

- [ ] host-side providers created
- [ ] `openshell provider list` shows expected providers
- [ ] `openshell inference get` shows the intended active provider
- [ ] sandbox-side model config updated
- [ ] gateway restarted after provider changes

## 7. Channel Checklist

### Telegram

- [ ] Telegram bot token configured on the host
- [ ] `nemoclaw start` running when channel bridge is needed
- [ ] Telegram policy preset or manual endpoint policy applied
- [ ] dashboard allowlist configured
- [ ] test message succeeds from an approved user

## 8. Policies Checklist

- [ ] policy edits reviewed before apply
- [ ] full policy file applied, not a fragment
- [ ] endpoint scope kept narrow
- [ ] changes documented in repository docs if permanent

## 9. Skills and Plugins Checklist

- [ ] downloaded skills reviewed before import
- [ ] imported skills copied to the correct sandbox path
- [ ] plugins installed only when needed
- [ ] fresh dashboard session started after skill changes

## 10. Day-2 Health Checks

Run regularly:

```bash
systemctl status docker
systemctl status caddy
systemctl status nemoclaw-connect
openshell inference get
openshell forward list
nemoclaw nemoclaw-sandbox status
```

## 11. Change Management Checklist

- [ ] docs updated with behavior changes
- [ ] security-sensitive changes reviewed
- [ ] destructive commands clearly documented
- [ ] changelog updated when repository standards change
- [ ] release notes prepared when publishing a tagged release
