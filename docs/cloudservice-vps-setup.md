# Cloud Service or VPS Setup Runbook

## 1. Prerequisites

- Ubuntu `24.04`
- Minimum `4 vCPU`, `8 GB RAM`, `50 GB disk`
- Cloud Service or VPS access
- Root shell access over SSH
- NVIDIA API key for the onboarding wizard
- Anthropic and optionally OpenAI API keys for inference providers

## 2. Firewall Rules

In Cloud Service or VPS, allow only:

- `TCP/80`
- `TCP/443`

Do not expose `18789` publicly.

## 3. Host Bootstrap

### Install Docker

```bash
apt update && apt upgrade -y && \
curl -fsSL https://get.docker.com | sh && \
systemctl enable docker && systemctl start docker && \
usermod -aG docker $USER && newgrp docker
```

### Install OpenShell and fix cgroup mode

```bash
echo '{"default-cgroupns-mode": "host"}' > /etc/docker/daemon.json && \
systemctl restart docker && \
curl -LsSf https://raw.githubusercontent.com/NVIDIA/OpenShell/main/install.sh | sh && \
source ~/.bashrc
```

### Install NemoClaw

```bash
export NVM_DIR="$HOME/.nvm" && \
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" ; \
curl -fsSL https://nvidia.com/nemoclaw.sh | bash
```

### Persist host shell PATH

```bash
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc && \
echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"' >> ~/.bashrc && \
echo 'export PATH="$PATH:$HOME/.local/bin"' >> ~/.bashrc && \
source ~/.bashrc
```

## 4. Onboarding Wizard

Run:

```bash
nemoclaw onboard
```

Recommended values:

- sandbox name: `nemoclaw-sandbox`
- policy presets: `slack,telegram` only if required

If policy preset application fails during onboarding, complete the wizard and apply the policy later with `openshell policy set`.

## 5. Start the Sandbox Connection

```bash
nemoclaw nemoclaw-sandbox connect
```

Expected outcome:

- sandbox session opens
- local port forward becomes active on `127.0.0.1:18789`

If a port conflict already exists, inspect with:

```bash
openshell forward list
```

## 6. Keep the Connection Alive

### SSH Keepalive

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

### systemd Service

Create `/etc/systemd/system/nemoclaw-connect.service` and enable it:

```bash
sudo systemctl daemon-reload
sudo systemctl enable nemoclaw-connect
sudo systemctl start nemoclaw-connect
```

Use the service content from `../INSTALL.md` and validate the binary paths with `which nemoclaw` and `which openshell`.

## 7. Capture the Gateway Token

From the host:

```bash
nemoclaw nemoclaw-sandbox connect
python3 -c "import json; d=json.load(open('/sandbox/.openclaw/openclaw.json')); print('TOKEN:', d['gateway']['auth']['token'])"
exit
```

Store the token securely.

## 8. HTTPS with Caddy

Install and enable Caddy on the host. Configure it to reverse proxy:

- from `https://YOUR-SUBDOMAIN.hstgr.cloud`
- to `http://127.0.0.1:18789`

Only Caddy should be internet-facing.

## 9. Provider Setup

Create providers on the host with `openshell provider create`, then point `inference.local` to the active provider with `openshell inference set`.

Inside the sandbox, register provider definitions in OpenClaw config and restart the gateway.

## 10. Verification

Run:

```bash
ss -tlnp | grep 18789
openshell forward list
nemoclaw nemoclaw-sandbox status
openshell inference get
systemctl status caddy
systemctl status nemoclaw-connect
```

## 11. Optional Channel Services

Telegram support requires:

- Telegram bot token
- Telegram policy enabled
- `nemoclaw start` running on the host
- dashboard allowlist configuration