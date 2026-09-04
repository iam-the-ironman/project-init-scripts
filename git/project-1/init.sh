#!/usr/bin/env bash
# esc bash - Git Project #1 setup: a messy repository to rescue
set -euo pipefail

PRIYA=(-c user.name="Priya Sharma" -c user.email="priya@example.com")
export GIT_AUTHOR_DATE="2026-01-05T10:00:00" GIT_COMMITTER_DATE="2026-01-05T10:00:00"

rm -rf /root/blog-site /root/.project1-meta
mkdir -p /root/blog-site/posts /root/blog-site/config
cd /root/blog-site
git init -q -b main

cat > index.html <<'EOF'
<h1>ESC Bash Blog</h1>
<p>Posts by the team.</p>
EOF
cat > style.css <<'EOF'
body { font-family: sans-serif; }
h1 { color: darkblue; }
EOF
cat > posts/first-post.md <<'EOF'
# First post

Welcome to the team blog.
EOF
git add .
git "${PRIYA[@]}" commit -q -m "add site skeleton"

cat > config/secrets.env <<'EOF'
DEPLOY_TOKEN=tok_9f3a1c77e2
DB_PASSWORD=hunter2-prod
EOF
git add config/secrets.env
git "${PRIYA[@]}" commit -q -m "add config"

export GIT_AUTHOR_DATE="2026-01-05T10:05:00" GIT_COMMITTER_DATE="2026-01-05T10:05:00"
cat > index.html <<'EOF'
<h1>ESC Bash Blg</h1>
<p>Posts by the team.</p>
<!-- BROKEN NAVBAR EXPERIMENT -->
EOF
git add index.html
git "${PRIYA[@]}" commit -q -m "stuff"
echo "BAD_COMMIT=$(git rev-parse HEAD)" > /root/.project1-meta

# stale branch that points at an older commit already contained in main
git branch old-design HEAD~1

# a change Priya stashed and never finished
sed -i 's/darkblue/#1a237e/' style.css
git "${PRIYA[@]}" stash push -q -m "wip color tweak" style.css

# uncommitted draft work left in the working tree
cat >> posts/first-post.md <<'EOF'

This draft paragraph explains what the blog will cover.
EOF

# untracked junk files
echo "debug output line" > debug.log
echo "scratch notes" > notes.tmp

git rev-parse HEAD >/dev/null

echo "Project 1 ready. Repository: /root/blog-site"
echo "Seeded: a committed secret (config/secrets.env), a bad commit with the message 'stuff',"
echo "an old-design branch, a stashed style change, an uncommitted draft in posts/first-post.md,"
echo "and untracked junk files (debug.log, notes.tmp)."
echo "The bad commit hash is recorded in /root/.project1-meta for grading. Do not edit that file."
