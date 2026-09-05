#!/usr/bin/env bash
# esc bash - GitHub Actions debug-workflow fixture
# Places a broken workflow into the learner's actions-journey clone.
# It does NOT commit or push - the learner does that themselves.
set -euo pipefail

if [ ! -d /root/actions-journey/.git ]; then
  echo "actions-journey clone not found at /root/actions-journey" >&2
  echo "The lesson's setup hook clones it; open the task again." >&2
  exit 1
fi

mkdir -p /root/actions-journey/.github/workflows
cat > /root/actions-journey/.github/workflows/broken.yml <<'YML'
name: site-check
on: push
jobs:
  verify:
    runs-on: ubuntu-latest
    steps:
      - name: Read the readme
        run: cat README.md
      - name: Show the Python version
        run: pyhton3 --version
YML

echo "Broken workflow placed at /root/actions-journey/.github/workflows/broken.yml"
echo "Commit and push it yourself to see it fail on GitHub."
