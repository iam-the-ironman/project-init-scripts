#!/usr/bin/env bash
set -e
mkdir -p /root/mission/health /root/answers
cat > /root/mission/services.json <<'EOF'
[
  {"name": "nginx", "check_file": "/root/mission/health/nginx.pid"},
  {"name": "postgres", "check_file": "/root/mission/health/postgres.pid"},
  {"name": "redis", "check_file": "/root/mission/health/redis.pid"},
  {"name": "api", "check_file": "/root/mission/health/api.pid"}
]
EOF
echo 1234 > /root/mission/health/nginx.pid
echo 5678 > /root/mission/health/postgres.pid
# redis.pid and api.pid are intentionally absent (services down)
