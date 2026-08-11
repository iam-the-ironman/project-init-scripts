#!/usr/bin/env bash
# esc bash - Python for DevOps Project #2 setup
set -euo pipefail
mkdir -p /root/mission/health /root/scripts /root/answers
cat > /root/mission/services.yaml <<'EOF'
services:
  - name: nginx
    check_file: /root/mission/health/nginx.pid
  - name: api
    check_file: /root/mission/health/api.pid
  - name: redis
    check_file: /root/mission/health/redis.pid
  - name: worker
    check_file: /root/mission/health/worker.pid
EOF
touch /root/mission/health/nginx.pid /root/mission/health/api.pid
echo "Project 2 ready. Config: /root/mission/services.yaml"
echo "Health files: nginx.pid and api.pid exist (UP), redis.pid and worker.pid absent (DOWN)"
echo "Write /root/scripts/healthcheck.py to monitor them."
