#!/usr/bin/env bash
set -e
mkdir -p /root/mission /root/answers
cat > /root/mission/servers.json <<'EOF'
[
  {"name": "web1", "cpu": 2},
  {"name": "web2", "cpu": 4},
  {"name": "db1", "cpu": 8}
]
EOF
