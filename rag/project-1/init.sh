#!/usr/bin/env bash
set -e
mkdir -p /root/docs /root/docsbot
cat > /root/docs/deploys.md <<'DOC'
# Deploys

The web app deploys to production every Monday and Thursday at
14:00 UTC. A deploy is started with the ship command from the main
branch. Rollbacks re-deploy the previous tagged release and take
about five minutes.
DOC
cat > /root/docs/backups.md <<'DOC'
# Backups

Database backups run every night at 03:00 and are stored for 45
days. Restoring a backup is done with the restore tool and needs
approval from the data team.
DOC
cat > /root/docs/access.md <<'DOC'
# Access

Production access requires a hardware security key. New engineers
request access through the platform portal, and approval takes two
working days.
DOC
cat > /root/docs/incidents.md <<'DOC'
# Incidents

Incidents are declared in the incident channel with the declare
command. Every incident gets a review meeting within one week of
being resolved.
DOC
echo "Seeded /root/docs with 4 markdown files."
