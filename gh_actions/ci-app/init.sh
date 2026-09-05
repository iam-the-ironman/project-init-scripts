#!/bin/bash
# Seeds the notekeeper app into /root/actions-pipelines for the
# gha-ci-for-an-app topic. Idempotent: does nothing if the repo
# already exists.
set -e

if [ -d /root/actions-pipelines/.git ]; then
  exit 0
fi

mkdir -p /root/actions-pipelines
cd /root/actions-pipelines

base="https://raw.githubusercontent.com/Esc-Bash/project-init-scripts/main/gh_actions/ci-app"
for f in notes.py test_notes.py requirements.txt README.md; do
  curl -fsSL "$base/$f" -o "$f"
done

export GIT_AUTHOR_DATE="2026-01-15T10:00:00"
export GIT_COMMITTER_DATE="2026-01-15T10:00:00"

git init -b main .
git -c user.name="Priya Sharma" -c user.email="priya@example.com" add notes.py README.md
git -c user.name="Priya Sharma" -c user.email="priya@example.com" commit -m "Add the notekeeper CLI"
git -c user.name="Priya Sharma" -c user.email="priya@example.com" add test_notes.py requirements.txt
git -c user.name="Priya Sharma" -c user.email="priya@example.com" commit -m "Add the pytest test suite"
