#!/usr/bin/env bash
# esc bash - GitHub Actions project-1 setup: seeds /root/gha-project-ci
set -euo pipefail

PRIYA=(-c user.name="Priya Sharma" -c user.email="priya@example.com")
export GIT_AUTHOR_DATE="2026-02-02T10:00:00" GIT_COMMITTER_DATE="2026-02-02T10:00:00"

rm -rf /root/gha-project-ci
mkdir -p /root/gha-project-ci
cd /root/gha-project-ci
git init -q -b main

cat > README.md <<'FIXTURE_EOF'
# pixelpost

A tiny blog engine. It turns post titles into URL slugs and
lists the latest posts for the home page feed.

Run the tests:

    python3 -m unittest discover -s tests -t .
FIXTURE_EOF

mkdir -p pixelpost
touch pixelpost/__init__.py

mkdir -p pixelpost
cat > pixelpost/feed.py <<'FIXTURE_EOF'
def latest_posts(posts, count):
    """Return the newest posts first, limited to count items.

    posts is a list of (date_string, title) tuples.
    """
    ordered = sorted(posts, key=lambda post: post[0], reverse=True)
    return ordered[:count]
FIXTURE_EOF

mkdir -p pixelpost
cat > pixelpost/slug.py <<'FIXTURE_EOF'
def slugify(title):
    """Turn a post title into a URL slug.

    "Hello World" becomes "hello-world".
    """
    return title
FIXTURE_EOF

cat > requirements.txt <<'FIXTURE_EOF'
pytest
FIXTURE_EOF

mkdir -p tests
touch tests/__init__.py

mkdir -p tests
cat > tests/test_feed.py <<'FIXTURE_EOF'
import unittest

from pixelpost.feed import latest_posts


POSTS = [
    ("2026-01-10", "Old post"),
    ("2026-02-01", "Newest post"),
    ("2026-01-20", "Middle post"),
]


class FeedTests(unittest.TestCase):
    def test_newest_first(self):
        result = latest_posts(POSTS, 3)
        self.assertEqual(result[0][1], "Newest post")

    def test_limit_is_applied(self):
        self.assertEqual(len(latest_posts(POSTS, 2)), 2)
FIXTURE_EOF

mkdir -p tests
cat > tests/test_slug.py <<'FIXTURE_EOF'
import unittest

from pixelpost.slug import slugify


class SlugifyTests(unittest.TestCase):
    def test_lowercases_the_title(self):
        self.assertEqual(slugify("Hello"), "hello")

    def test_replaces_spaces_with_hyphens(self):
        self.assertEqual(slugify("Hello World"), "hello-world")

    def test_longer_title(self):
        self.assertEqual(
            slugify("My First Post Ever"), "my-first-post-ever"
        )
FIXTURE_EOF

git add README.md requirements.txt pixelpost tests/__init__.py
git "${PRIYA[@]}" commit -q -m "add the pixelpost app"

export GIT_AUTHOR_DATE="2026-02-02T10:05:00" GIT_COMMITTER_DATE="2026-02-02T10:05:00"
git add tests
git "${PRIYA[@]}" commit -q -m "add the test suite"

echo "pixelpost is ready at /root/gha-project-ci"
