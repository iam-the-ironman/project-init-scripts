#!/usr/bin/env bash
# esc bash - Claude Code Project #2 setup
set -euo pipefail
mkdir -p /root/brokenrepo
cat > /root/brokenrepo/stats.sh <<'EOF'
#!/bin/bash
# Sum the numbers in the file given as the first argument.
total=0
while read -r n; do
  total=$n
done < "$1"
echo "$total"
EOF
chmod +x /root/brokenrepo/stats.sh
cat > /root/brokenrepo/test.sh <<'EOF'
#!/bin/bash
tmp=$(mktemp)
printf '3\n5\n7\n' > "$tmp"
got="$(bash /root/brokenrepo/stats.sh "$tmp")"
rm -f "$tmp"
if [ "$got" = "15" ]; then
  echo PASS
  exit 0
fi
echo "FAIL: got $got, wanted 15"
exit 1
EOF
chmod +x /root/brokenrepo/test.sh
echo "Project 2 ready. Broken repo at /root/brokenrepo/"
echo "The test.sh fails because stats.sh has a bug (overwrites instead of accumulates)"
echo "Use Claude to read both scripts and fix stats.sh."
