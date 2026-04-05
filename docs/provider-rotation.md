# Provider Rotation Guide

## Purpose

This guide explains how to rotate provider credentials or switch the active upstream model provider with minimal disruption.

Use it with:

- `providers.md`
- `monitoring.md`
- `logging.md`
- `upgrade-runbook.md`

## When to Rotate

Rotate provider configuration when:

- credentials are nearing expiry
- a key may have been exposed
- billing or quota controls changed
- the active model family should change
- the primary provider is degraded

## Preparation Checklist

- identify the current active provider with `openshell inference get`
- ensure replacement credentials are ready
- confirm required policy coverage for any new upstream endpoint
- schedule the change during a controlled maintenance window if production traffic exists

## Step 1: Review Current State

```bash
openshell provider list
openshell inference get
```

## Step 2: Create or Refresh the Replacement Provider

### Anthropic example

```bash
export ANTHROPIC_API_KEY="sk-ant-YOUR-NEW-KEY-HERE"
openshell provider create --name anthropic-prod --type anthropic --from-existing
```

### OpenAI example

```bash
export OPENAI_API_KEY="sk-proj-YOUR-NEW-KEY-HERE"
openshell provider create --name openai-prod --type openai --from-existing
```

## Step 3: Switch the Active Provider

### Switch to Anthropic

```bash
openshell inference set --provider anthropic-prod --model claude-sonnet-4-6
```

### Switch to OpenAI

```bash
openshell inference set --provider openai-prod --model gpt-4.1 --no-verify
```

## Step 4: Validate End-to-End Behavior

```bash
openshell inference get
nemoclaw nemoclaw-sandbox status
```

Then run one real request through the dashboard or client path.

## Sandbox Model Definitions

If the target provider family changes, update the sandbox-side provider definitions in `providers.md` and restart the gateway.

## Emergency Fallback

If the new provider fails:

1. switch back to the previous known-good provider
2. confirm `openshell inference get`
3. review `logging.md` for provider-related errors
4. document the failure before retrying

## Post-Rotation Actions

- revoke old credentials when safe
- update operational notes if names or defaults changed
- verify monitoring and alerting still reflect the active provider