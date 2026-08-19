#!/usr/bin/env bash
set -e
mkdir -p /root/runbook-assistant
cat > /root/runbook.md <<'DOC'
# Payments service runbook

## Deploys
The payments service deploys every Wednesday at 11:00 UTC. Deploys
are frozen during the last week of each quarter.

## Restarts
A stuck worker is restarted with the worker-restart script. Restart
one worker at a time and wait for its health check to pass.

## Queues
If the payment queue grows past 10000 messages, scale the workers
to 8 with the scale command and page the on-call engineer.

## Certificates
The payment gateway certificate is renewed automatically. If
renewal fails, the fallback is a manual renewal with the certbot
command, followed by a gateway restart.

## Logs
Payment logs are kept for 30 days in the central log system.
Card numbers never appear in logs; if one is found, declare an
incident immediately.
DOC
echo "Seeded /root/runbook.md."
