# Skills and Plugins Guide

## Purpose

This guide separates `skills` and `plugins` operations from the general command reference.

## Skills Overview

Skills extend agent behavior with curated capability packages.

Inside the sandbox, you can inspect them with:

```bash
openclaw skills list
openclaw skills check
openclaw skills info <name>
```

## Safe Skill Installation Flow

Skills should be acquired on the host, reviewed, then copied into the sandbox.

### 1. Install ClawHub CLI on the host

```bash
npm install -g clawhub
```

### 2. Download a skill

```bash
clawhub install <skill-name>
```

### 3. Review the skill before import

```bash
cat /root/skills/<skill-name>/SKILL.md
```

### 4. Copy the skill into the sandbox

```bash
docker cp /root/skills/<skill-name> openshell-cluster-nemoclaw:/tmp/<skill-name>
docker exec openshell-cluster-nemoclaw kubectl cp /tmp/<skill-name> openshell/nemoclaw-sandbox:/sandbox/.openclaw-data/skills/<skill-name>
```

## Batch Import Example

```bash
for skill in /root/skills/*/; do
  name=$(basename "$skill")
  docker cp "$skill" openshell-cluster-nemoclaw:/tmp/$name
  docker exec openshell-cluster-nemoclaw kubectl exec -n openshell nemoclaw-sandbox -- rm -rf /sandbox/.openclaw-data/skills/$name
  docker exec openshell-cluster-nemoclaw kubectl cp /tmp/$name openshell/nemoclaw-sandbox:/sandbox/.openclaw-data/skills/$name
done
```

## Skill File Locations

| Location | Purpose |
|---|---|
| `/root/skills/` | host-side skill staging |
| `/sandbox/.openclaw-data/skills/` | active sandbox skill directory |

## Plugins Overview

Plugins are managed through the `openclaw` binary.

Common commands:

```bash
openclaw plugins list
openclaw plugins install <package-name>
openclaw plugins enable <name>
openclaw plugins disable <name>
openclaw plugins update
openclaw plugins uninstall <name>
openclaw plugins info <name>
```

## Operational Recommendation

After importing new skills, start a fresh chat session in the dashboard so the agent loads the updated skill set.

## Security Recommendations

- review every downloaded skill before import
- prefer minimal trusted skill sets
- treat channel-enabled or network-enabled skills as higher risk
- document non-default skills that become part of the operating baseline
