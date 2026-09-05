#!/usr/bin/env bash
# esc bash - GitHub Actions project-3 setup: seeds /root/gha-project-deploy
set -euo pipefail

PRIYA=(-c user.name="Priya Sharma" -c user.email="priya@example.com")
export GIT_AUTHOR_DATE="2026-02-16T10:00:00" GIT_COMMITTER_DATE="2026-02-16T10:00:00"

rm -rf /root/gha-project-deploy
mkdir -p /root/gha-project-deploy
cd /root/gha-project-deploy
git init -q -b main

cat > README.md <<'FIXTURE_EOF'
# pixelpost home

The pixelpost home page renderer. It reads the release version
from the VERSION file and renders the home page as plain text.

Run the tests:

    python3 -m unittest discover -s tests -t .

Deploy to this machine (used by the deploy workflow):

    DEPLOY_TOKEN=some-value bash scripts/deploy.sh
FIXTURE_EOF

cat > VERSION <<'FIXTURE_EOF'
2.0.0
FIXTURE_EOF

mkdir -p pixelpost
touch pixelpost/__init__.py

mkdir -p pixelpost
cat > pixelpost/app.py <<'FIXTURE_EOF'
import os


def read_version():
    """Read the release version from the VERSION file."""
    here = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    with open(os.path.join(here, "VERSION")) as handle:
        return handle.read().strip()


def render_home(version):
    """Render the home page as plain text."""
    lines = [
        "pixelpost",
        "version " + version,
        "Posts by the team.",
    ]
    return "\n".join(lines)
FIXTURE_EOF

cat > requirements.txt <<'FIXTURE_EOF'
pytest
FIXTURE_EOF

mkdir -p scripts
cat > scripts/deploy.sh <<'FIXTURE_EOF'
#!/usr/bin/env bash
# Deploy pixelpost to /opt/pixelpost on this machine.
# Refuses to run without a deploy token in the environment.
set -euo pipefail
: "${DEPLOY_TOKEN:?DEPLOY_TOKEN is not set}"
mkdir -p /opt/pixelpost
cp pixelpost/*.py /opt/pixelpost/
cp VERSION /opt/pixelpost/VERSION
date -u +"deployed at %Y-%m-%dT%H:%M:%SZ" > /opt/pixelpost/release.info
echo "deployed version $(cat VERSION) to /opt/pixelpost"
FIXTURE_EOF
chmod +x scripts/deploy.sh

mkdir -p tests
touch tests/__init__.py

mkdir -p tests
cat > tests/test_app.py <<'FIXTURE_EOF'
import unittest

from pixelpost.app import read_version, render_home


class AppTests(unittest.TestCase):
    def test_version_comes_from_the_version_file(self):
        self.assertEqual(read_version(), "2.0.0")

    def test_home_page_shows_the_version(self):
        page = render_home("2.0.0")
        self.assertIn("pixelpost", page)
        self.assertIn("version 2.0.0", page)
FIXTURE_EOF

git add README.md requirements.txt VERSION pixelpost tests/__init__.py
git "${PRIYA[@]}" commit -q -m "add the pixelpost home app"

export GIT_AUTHOR_DATE="2026-02-16T10:05:00" GIT_COMMITTER_DATE="2026-02-16T10:05:00"
git add tests scripts
git "${PRIYA[@]}" commit -q -m "add tests and the deploy script"

echo "pixelpost home is ready at /root/gha-project-deploy"
