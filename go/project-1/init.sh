#!/usr/bin/env bash
set -e
mkdir -p /root/mission /root/answers
cat > /root/mission/app.log <<'EOF'
2026-07-24 10:00:01 INFO service started
2026-07-24 10:00:02 DEBUG loading config
2026-07-24 10:00:03 INFO request handled ok
2026-07-24 10:00:04 WARNING slow response
2026-07-24 10:00:05 INFO request handled ok
2026-07-24 10:00:06 DEBUG cache miss
2026-07-24 10:00:07 ERROR upstream timeout
2026-07-24 10:00:08 INFO request handled ok
2026-07-24 10:00:09 DEBUG cache hit
2026-07-24 10:00:10 INFO request handled ok
2026-07-24 10:00:11 WARNING retry scheduled
2026-07-24 10:00:12 INFO request handled ok
2026-07-24 10:00:13 DEBUG connection reused
2026-07-24 10:00:14 ERROR database unavailable
2026-07-24 10:00:15 INFO request handled ok
2026-07-24 10:00:16 WARNING disk almost full
2026-07-24 10:00:17 INFO request handled ok
2026-07-24 10:00:18 DEBUG gc cycle
2026-07-24 10:00:19 CRITICAL out of memory
2026-07-24 10:00:20 INFO request handled ok
2026-07-24 10:00:21 WARNING high latency
2026-07-24 10:00:22 DEBUG worker idle
2026-07-24 10:00:23 ERROR upstream timeout
2026-07-24 10:00:24 INFO request handled ok
EOF
