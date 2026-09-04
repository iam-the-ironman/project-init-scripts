#!/usr/bin/env bash
# esc bash - Git Project #3 setup: portfolio site files, no repository yet
set -euo pipefail

rm -rf /root/portfolio
mkdir -p /root/portfolio/css
cd /root/portfolio

cat > index.html <<'EOF'
<h1>My Portfolio</h1>
<p>Welcome to my portfolio.</p>
<p>Projects and notes live here.</p>
EOF
cat > about.md <<'EOF'
# About

DevOps engineer learning Git one project at a time.
EOF
cat > css/style.css <<'EOF'
body { font-family: sans-serif; max-width: 40rem; }
h1 { color: #333; }
EOF
cat > local-notes.txt <<'EOF'
Private scratch notes. This file must never reach GitHub.
EOF

test -f /root/portfolio/index.html

echo "Project 3 ready. Files: /root/portfolio (index.html, about.md, css/style.css, local-notes.txt)."
echo "There is no Git repository here yet. That part is your job."
echo "local-notes.txt is private and must stay out of version control."
