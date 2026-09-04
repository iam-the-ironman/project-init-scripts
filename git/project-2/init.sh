#!/usr/bin/env bash
# esc bash - Git Project #2 setup: recipes repo with a local bare remote
set -euo pipefail

PRIYA=(-c user.name="Priya Sharma" -c user.email="priya@example.com")
export GIT_AUTHOR_DATE="2026-01-12T09:00:00" GIT_COMMITTER_DATE="2026-01-12T09:00:00"

rm -rf /root/recipes /root/team-remote.git /root/.project2-meta /tmp/priya-recipes
mkdir -p /root/recipes/recipes
cd /root/recipes
git init -q -b main

cat > README.md <<'EOF'
# Team recipes

Shared recipes for the office kitchen.
EOF
cat > recipes/pasta.md <<'EOF'
# Pasta

- Boil a large pot of water.
- Cook the pasta for 10 minutes.
- Drain and serve with sauce.
EOF
git add .
git "${PRIYA[@]}" commit -q -m "add readme and pasta recipe"

cat > recipes/soup.md <<'EOF'
# Tomato soup

- Chop two onions and four tomatoes.
- Simmer for 30 minutes.
- Blend until smooth.
EOF
git add recipes/soup.md
git "${PRIYA[@]}" commit -q -m "add tomato soup recipe"

# the team remote is a bare repository on this same machine
git init -q --bare -b main /root/team-remote.git
git remote add origin /root/team-remote.git
git push -q origin main

# record the learner's start point BEFORE the teammate moves the remote
echo "START=$(git rev-parse main)" > /root/.project2-meta

# Priya pushes a conflicting change to the remote after you cloned your copy
export GIT_AUTHOR_DATE="2026-01-12T09:30:00" GIT_COMMITTER_DATE="2026-01-12T09:30:00"
git clone -q /root/team-remote.git /tmp/priya-recipes
cd /tmp/priya-recipes
sed -i 's/Cook the pasta for 10 minutes./Cook the pasta for 12 minutes./' recipes/pasta.md
git add recipes/pasta.md
git "${PRIYA[@]}" commit -q -m "adjust pasta cooking time"
git push -q origin main
echo "TEAMMATE=$(git rev-parse HEAD)" >> /root/.project2-meta
cd /
rm -rf /tmp/priya-recipes

git ls-remote /root/team-remote.git refs/heads/main >/dev/null

echo "Project 2 ready. Your repository: /root/recipes (origin is /root/team-remote.git)."
echo "Seeded: two commits on main, pushed to the bare team remote."
echo "Priya has already pushed one more commit to the remote that you do not have yet."
echo "Start and teammate commit hashes are recorded in /root/.project2-meta for grading. Do not edit that file."
