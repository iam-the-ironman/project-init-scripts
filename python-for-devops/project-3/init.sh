#!/usr/bin/env bash
# esc bash - Python for DevOps Project #3 setup
set -euo pipefail
mkdir -p /root/mission/backup /root/scripts /root/answers
cat > /root/mission/backup/config.yaml <<'EOF'
app: esc-bash
env: production
retries: 3
EOF
cat > /root/mission/backup/notes.txt <<'EOF'
Nightly backup of the batch job output directory.
EOF
cat > /root/mission/backup/servers.csv <<'EOF'
name,ip,role
web-1,10.0.0.11,web
db-1,10.0.0.21,db
EOF
echo "Project 3 ready. Backup dir: /root/mission/backup"
echo "Files: config.yaml, notes.txt, servers.csv"
echo "Write /root/scripts/s3backup.py to upload them to S3."
