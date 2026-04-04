# Command Reference

## Safe Daily Operations

### Sandbox Lifecycle

```bash
nemoclaw nemoclaw-sandbox connect
nemoclaw nemoclaw-sandbox status
nemoclaw nemoclaw-sandbox logs --follow
openshell sandbox list
```

### Forwarding and Connectivity

```bash
openshell forward list
ss -tlnp | grep 18789
systemctl status nemoclaw-connect
systemctl restart nemoclaw-connect
```

### Inference Providers

```bash
openshell provider list
openshell inference get
openshell inference set --provider anthropic-prod --model claude-sonnet-4-6
openshell inference set --provider openai-prod --model gpt-4.1 --no-verify
```

### Security Monitor

```bash
openshell term
```

## Policy Management

### Locate Policies

```bash
NEMOCLAW_POLICIES="$(npm root -g)/nemoclaw/nemoclaw-blueprint/policies"
cat "$NEMOCLAW_POLICIES/openclaw-sandbox.yaml"
ls "$NEMOCLAW_POLICIES/presets/"
```

### Apply a Full Policy File

```bash
openshell policy set --policy "$NEMOCLAW_POLICIES/openclaw-sandbox.yaml" nemoclaw-sandbox
```

Important note:

- `openshell policy set` replaces the entire policy, not a partial fragment.

### Add Preset Policies

```bash
nemoclaw nemoclaw-sandbox policy-add
nemoclaw nemoclaw-sandbox policy-list
```

## Telegram Operations

### Start the Telegram Bridge

```bash
export TELEGRAM_BOT_TOKEN="your-token-here"
nemoclaw start
```

### Dashboard Channel Example

```json5
channels: {
  telegram: {
    enabled: true,
    dmPolicy: 'allowlist',
    allowFrom: [
      'YOUR_NUMERIC_ID',
    ],
    groupPolicy: 'allowlist',
    streaming: 'partial',
  },
},
```

### VPS-Specific Mitigation

Set in dashboard config:

- `channels.telegram.configWrites = false`

## Skills and Plugins

### Skills

```bash
openclaw skills list
openclaw skills check
openclaw skills info <name>
```

Host-side acquisition:

```bash
npm install -g clawhub
clawhub install <skill-name>
cat /root/skills/<skill-name>/SKILL.md
```

Copy into sandbox:

```bash
docker cp /root/skills/<skill-name> openshell-cluster-nemoclaw:/tmp/<skill-name>
docker exec openshell-cluster-nemoclaw kubectl cp /tmp/<skill-name> openshell/nemoclaw-sandbox:/sandbox/.openclaw-data/skills/<skill-name>
```

### Plugins

```bash
openclaw plugins list
openclaw plugins install <package-name>
openclaw plugins enable <name>
openclaw plugins disable <name>
openclaw plugins update
openclaw plugins uninstall <name>
openclaw plugins info <name>
```

## Monitoring

```bash
openshell term
nemoclaw nemoclaw-sandbox logs --follow
openshell inference get
systemctl status caddy
```

## Commands to Avoid

Do not use these casually:

```bash
openclaw configure
nemoclaw onboard
openshell gateway destroy
nemoclaw nemoclaw-sandbox destroy
```

Reason:

- they can destroy state, wipe configuration, or recreate the sandbox unexpectedly.
