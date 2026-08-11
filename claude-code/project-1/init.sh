#!/usr/bin/env bash
# esc bash - Claude Code Project #1 setup
set -euo pipefail
mkdir -p /root/wordcount
cat > /root/wordcount/README.md <<'EOF'
# wordcount

Build `wc.sh`: a bash script that takes one file path as its only
argument, reads that file, and prints the word count and the line count,
each with a clear label. The script must be executable.
EOF
echo "Project 1 ready. Project spec: /root/wordcount/README.md"
echo "Use Claude to build the wc.sh script and CLAUDE.md documentation."
