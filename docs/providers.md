# Providers Guide

## Purpose

This guide explains how host-side providers and sandbox-side model definitions work together.

## Architecture

- Real API keys stay on the host.
- `OpenShell` stores credentials as providers.
- The sandbox calls `https://inference.local/v1`.
- `OpenShell` injects the real credential and forwards the request to the active upstream provider.

## Supported Provider Pattern

Documented provider flows in this repository:

- `Anthropic`
- `OpenAI`
- baseline `NVIDIA` or default provider flow when supplied by onboarding

## 1. Create Providers on the Host

### Anthropic

```bash
export ANTHROPIC_API_KEY="sk-ant-YOUR-KEY-HERE"
openshell provider create --name anthropic-prod --type anthropic --from-existing
```

### OpenAI

```bash
export OPENAI_API_KEY="sk-proj-YOUR-KEY-HERE"
openshell provider create --name openai-prod --type openai --from-existing
```

List providers:

```bash
openshell provider list
```

## 2. Select the Active Inference Provider

### Switch to Anthropic

```bash
openshell inference set --provider anthropic-prod --model claude-sonnet-4-6
```

### Switch to OpenAI

```bash
openshell inference set --provider openai-prod --model gpt-4.1 --no-verify
```

Check the current state:

```bash
openshell inference get
```

## 3. Register Provider Definitions Inside the Sandbox

Connect to the sandbox and set OpenClaw provider definitions.

### OpenAI-compatible definition

```bash
openclaw config set models.providers.openai '{"baseUrl":"https://inference.local/v1","apiKey":"unused","api":"openai-completions","models":[{"id":"gpt-4.1","name":"GPT-4.1"},{"id":"gpt-4o","name":"GPT-4o"}]}'
```

### Anthropic definition

```bash
openclaw config set models.providers.anthropic '{"baseUrl":"https://inference.local/v1","apiKey":"unused","api":"anthropic-messages","models":[{"id":"claude-sonnet-4-6","name":"Claude Sonnet 4.6"},{"id":"claude-opus-4-6","name":"Claude Opus 4.6"}]}'
```

### Default model

```bash
openclaw config set agents.defaults.model.primary "openai/gpt-4.1"
```

## 4. Restart the Gateway

Inside the sandbox:

```bash
openclaw gateway stop
openclaw gateway
```

## 5. Security Notes

- Do not place real production keys in sandbox config.
- Prefer host-side provider storage.
- Validate policy coverage before adding new upstream endpoints.
- Review which provider is active with `openshell inference get`.

## 6. Troubleshooting

If providers do not appear in the UI:

1. confirm the host-side provider exists
2. confirm `openshell inference get` returns the expected provider
3. confirm sandbox config entries were written successfully
4. restart the gateway
5. start a fresh chat session in the dashboard if needed
