# Installation Guide

## Repository Reference

Deployment repository reference:

- `https://github.com/thanhan92-f1/nemoclaw-openclaw-sandbox.git`

If you want a local copy of the repository before deployment work, clone it first:

```bash
git clone https://github.com/thanhan92-f1/nemoclaw-openclaw-sandbox.git
cd nemoclaw-openclaw-sandbox
```

## Scripted Installation Option

This repository also provides `install.sh` for repeatable install, update, repo sync, and managed uninstall operations.

Optional convenience wrappers are also included:

- `update.sh`
- `uninstall.sh`
- `repo-sync.sh`

An example environment template is also included in `.env.example` for local operator reference.

Example:

```bash
sudo bash install.sh install --domain sandbox.example.cloud
```

Wrapper examples:

```bash
sudo bash update.sh --repo-ref main --domain sandbox.example.cloud
sudo bash repo-sync.sh --repo-ref v0.1.0
sudo bash uninstall.sh --yes
```

For usage details, see `docs/install-script.md`.

## Target Platform

- Provider: `Cloud service or VPS`
- OS: `Ubuntu 24.04`
- Minimum recommended size: `4 vCPU / 8 GB RAM / 50 GB disk`
- Access level: `root` shell on the VPS host

## Required Inputs

Prepare these before running the installation:

- Cloud service or VPS with firewall access
- NVIDIA API key (`nvapi-...`)
- Anthropic API key (`sk-ant-...`) if Claude will be used
- Optional OpenAI API key if OpenAI models will be used
- Public domain or subdomain such as `sandbox.example.cloud`

## Service and Dependency Summary

Required host-side services and dependencies:

- `Docker`
- `OpenShell`
- `NemoClaw`
- `OpenClaw Gateway`
- `Caddy`
- `systemd`
- `SSH keepalive` configuration

Optional services:

- `Telegram bridge`
- `cloudflared` tunnel started by `nemoclaw start`
- extra providers such as `OpenAI`

See `docs/services-and-dependencies.md` for the detailed matrix.

## Installation Sequence

### 1. Open the Cloud Firewall

Only expose public ports `80` and `443` in your cloud firewall or VPS panel.
Do not expose `18789` publicly.

### 2. Update the Host and Install Docker

```bash
apt update && apt upgrade -y && \
curl -fsSL https://get.docker.com | sh && \
systemctl enable docker && systemctl start docker && \
usermod -aG docker $USER && newgrp docker
```

### 3. Fix Docker cgroup Mode and Install OpenShell

```bash
echo '{"default-cgroupns-mode": "host"}' > /etc/docker/daemon.json && \
systemctl restart docker && \
curl -LsSf https://raw.githubusercontent.com/NVIDIA/OpenShell/main/install.sh | sh && \
source ~/.bashrc
```

### 4. Install NemoClaw

```bash
export NVM_DIR="$HOME/.nvm" && \
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" ; \
curl -fsSL https://nvidia.com/nemoclaw.sh | bash
```

### 5. Persist PATH Fixes

```bash
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> ~/.bashrc && \
echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc && \
source ~/.bashrc
```

### 6. Run the Onboarding Wizard

```bash
nemoclaw onboard
```

Recommended values:

- Sandbox name: `nemoclaw-sandbox`
- Policy preset flow: choose `list`, then use `slack,telegram` if those channels are required

### 7. Start the Sandbox Gateway Connection

```bash
nemoclaw nemoclaw-sandbox connect
```

Expected result:

- sandbox prompt appears
- local gateway forward becomes available on `127.0.0.1:18789`

### 8. Configure Auto-Reconnect with SSH Keepalive and systemd

Create the SSH keepalive configuration:

```bash
mkdir -p ~/.ssh
cat >> ~/.ssh/config << 'EOF'
Host *
  ServerAliveInterval 30
  ServerAliveCountMax 3
  TCPKeepAlive yes
EOF
chmod 600 ~/.ssh/config
```

Create the `systemd` service:

```bash
sudo tee /etc/systemd/system/nemoclaw-connect.service > /dev/null << 'EOF'
[Unit]
Description=NemoClaw Gateway Connection
After=network-online.target docker.service
Wants=network-online.target docker.service

[Service]
Type=simple
User=root
Environment=PATH=/root/.nvm/versions/node/v22.22.1/bin:/root/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ExecStartPre=/bin/bash -c 'until /root/.local/bin/openshell status 2>/dev/null | grep -q Connected; do sleep 5; done'
ExecStart=/root/.nvm/versions/node/v22.22.1/bin/nemoclaw nemoclaw-sandbox connect
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable nemoclaw-connect
sudo systemctl start nemoclaw-connect
```

Update the binary paths if `which nemoclaw` or `which openshell` returns different locations.

### 9. Install and Configure Caddy

```bash
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list
apt update && apt install caddy -y
```

Create `/etc/caddy/Caddyfile`:

```caddyfile
YOUR-DOMAIN-OR-SUBDOMAIN {
  reverse_proxy 127.0.0.1:18789 {
    header_up Host 127.0.0.1:18789
    header_up Origin http://127.0.0.1:18789
  }
}
```

Start and enable it:

```bash
systemctl restart caddy && systemctl enable caddy
```

### 10. Register Providers

Host-side provider setup examples:

```bash
export ANTHROPIC_API_KEY="sk-ant-YOUR-KEY-HERE"
openshell provider create --name anthropic-prod --type anthropic --from-existing

export OPENAI_API_KEY="sk-proj-YOUR-KEY-HERE"
openshell provider create --name openai-prod --type openai --from-existing
```

Select the active model:

```bash
openshell inference set --provider anthropic-prod --model claude-sonnet-4-6
# or
openshell inference set --provider openai-prod --model gpt-4.1 --no-verify
```

### 11. Configure OpenClaw Providers Inside the Sandbox

Connect to the sandbox and apply provider configuration:

```bash
openclaw config set models.providers.openai '{"baseUrl":"https://inference.local/v1","apiKey":"unused","api":"openai-completions","models":[{"id":"gpt-4.1","name":"GPT-4.1"},{"id":"gpt-4o","name":"GPT-4o"}]}'
openclaw config set models.providers.anthropic '{"baseUrl":"https://inference.local/v1","apiKey":"unused","api":"anthropic-messages","models":[{"id":"claude-sonnet-4-6","name":"Claude Sonnet 4.6"},{"id":"claude-opus-4-6","name":"Claude Opus 4.6"}]}'
openclaw config set agents.defaults.model.primary "openai/gpt-4.1"
```

Restart the gateway inside the sandbox:

```bash
openclaw gateway stop
openclaw gateway
```

## Post-Install Verification

Run these checks on the VPS host:

```bash
ss -tlnp | grep 18789
openshell forward list
nemoclaw nemoclaw-sandbox status
openshell inference get
systemctl status caddy
systemctl status nemoclaw-connect
```

## Optional Telegram Channel Setup

```bash
export TELEGRAM_BOT_TOKEN="your-token-here"
nemoclaw start
```

Make it persistent if required:

```bash
echo 'export TELEGRAM_BOT_TOKEN="your-token"' >> ~/.bashrc
```

Then apply Telegram channel configuration in the dashboard as documented in `docs/command-reference.md`.

## Important Warnings

Avoid these commands unless you intentionally want destructive behavior:

- `openclaw configure`
- `nemoclaw onboard` for routine policy changes
- `openshell gateway destroy`
- `nemoclaw nemoclaw-sandbox destroy`
