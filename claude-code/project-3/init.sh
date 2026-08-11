#!/usr/bin/env bash
# esc bash - Claude Code Project #3 setup
set -euo pipefail
mkdir -p /root/setupme
cat > /root/setupme/greetings.py <<'EOF'
def greeting(name):
    return f"Hello, {name}!"
EOF
cat > /root/setupme/app.py <<'EOF'
from greetings import greeting

if __name__ == "__main__":
    print(greeting("esc bash"))
EOF
echo "Project 3 ready. Python project at /root/setupme/"
echo "Use Claude to configure CLAUDE.md, .claude/commands, and .claude/settings.json"
