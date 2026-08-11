#!/usr/bin/env bash
# esc bash - Python for DevOps Project #1 setup
set -euo pipefail
mkdir -p /root/mission /root/scripts /root/answers
cat > /root/mission/app.log <<'EOF'
2026-07-24 10:00:01 INFO service started
2026-07-24 10:00:02 DEBUG loaded config from /etc/app.conf
2026-07-24 10:00:03 INFO request handled ok
2026-07-24 10:00:04 INFO request handled ok
2026-07-24 10:00:05 WARNING slow response from upstream
2026-07-24 10:00:06 INFO request handled ok
2026-07-24 10:00:07 DEBUG cache miss for key user:42
2026-07-24 10:00:08 INFO request handled ok
2026-07-24 10:00:09 ERROR upstream connection refused
2026-07-24 10:00:10 WARNING retrying upstream call
2026-07-24 10:00:11 INFO request handled ok
2026-07-24 10:00:12 INFO request handled ok
2026-07-24 10:00:13 DEBUG cache hit for key user:42
2026-07-24 10:00:14 WARNING disk usage at 81 percent
2026-07-24 10:00:15 INFO request handled ok
2026-07-24 10:00:16 ERROR request failed with status 500
2026-07-24 10:00:17 INFO request handled ok
2026-07-24 10:00:18 CRITICAL worker pool exhausted
2026-07-24 10:00:19 WARNING slow response from upstream
2026-07-24 10:00:20 DEBUG heartbeat sent
2026-07-24 10:00:21 INFO request handled ok
2026-07-24 10:00:22 ERROR upstream connection refused
2026-07-24 10:00:23 CRITICAL out of memory killing worker
2026-07-24 10:00:24 WARNING disk usage at 83 percent
EOF
echo "Project 1 ready. Sample log: /root/mission/app.log"
echo "Write /root/scripts/loganalyzer.py to analyze it."
