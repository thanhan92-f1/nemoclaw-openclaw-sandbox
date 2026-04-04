# Telegram Setup

## Purpose

This guide isolates the Telegram channel setup from the broader installation flow.

## Prerequisites

- sandbox already provisioned
- Telegram policy enabled for the sandbox
- access to the host shell
- access to the OpenClaw dashboard
- Telegram bot token from `@BotFather`
- your personal Telegram numeric user ID from `@userinfobot`

## 1. Create the Telegram Bot

1. Open Telegram.
2. Message `@BotFather`.
3. Run `/newbot`.
4. Choose the bot name and username.
5. Save the bot token securely.

## 2. Ensure Policy Access Exists

Recommended approach:

```bash
nemoclaw nemoclaw-sandbox policy-add
```

Select the `telegram` preset when prompted.

To confirm:

```bash
nemoclaw nemoclaw-sandbox policy-list
```

If you manage policies manually, verify the Telegram endpoints are present in the full sandbox policy before applying it with `openshell policy set`.

## 3. Start the Host-Side Bridge

Run on the host:

```bash
export TELEGRAM_BOT_TOKEN="your-token-here"
nemoclaw start
```

Make the token persistent only if your operational model requires it:

```bash
echo 'export TELEGRAM_BOT_TOKEN="your-token"' >> ~/.bashrc
```

Note:

- `nemoclaw start` is separate from `nemoclaw nemoclaw-sandbox connect`
- both processes may be needed at the same time

## 4. Restrict Telegram Access in the Dashboard

Open the dashboard and update the channel config.

Example:

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

Recommendations:

- keep `dmPolicy` on `allowlist`
- keep `groupPolicy` on `allowlist`
- only allow trusted user IDs and groups

## 5. VPS-Specific Dashboard Mitigation

If the dashboard rewrites Telegram config incorrectly, set:

- `channels.telegram.configWrites = false`

## 6. Operational Checks

Verify:

- bridge process is running
- Telegram preset is present in policy
- dashboard allowlist is set correctly
- bot can receive and answer only from approved users

## 7. Security Notes

- Never commit the Telegram bot token.
- Avoid broad allowlists.
- Remember that approved endpoints can still become an exfiltration path if policies are too broad.
