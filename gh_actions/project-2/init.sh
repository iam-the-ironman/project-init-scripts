#!/usr/bin/env bash
# esc bash - GitHub Actions project-2 setup: seeds /root/gha-project-release
set -euo pipefail

PRIYA=(-c user.name="Priya Sharma" -c user.email="priya@example.com")
export GIT_AUTHOR_DATE="2026-02-09T10:00:00" GIT_COMMITTER_DATE="2026-02-09T10:00:00"

rm -rf /root/gha-project-release
mkdir -p /root/gha-project-release
cd /root/gha-project-release
git init -q -b main

cat > README.md <<'FIXTURE_EOF'
# pixelpost stats

Small text statistics used by the pixelpost editor: word counts
and estimated reading time for a post.

Run the tests:

    python3 -m unittest discover -s tests -t .

Build a release tarball:

    bash build.sh
FIXTURE_EOF

cat > VERSION <<'FIXTURE_EOF'
1.2.0
FIXTURE_EOF

cat > build.sh <<'FIXTURE_EOF'
#!/usr/bin/env bash
# Build a versioned release tarball into dist/.
set -euo pipefail
VERSION="$(cat VERSION)"
mkdir -p dist
tar -czf "dist/app-${VERSION}.tar.gz" pixelpost VERSION
echo "built dist/app-${VERSION}.tar.gz"
FIXTURE_EOF
chmod +x build.sh

mkdir -p pixelpost
touch pixelpost/__init__.py

mkdir -p pixelpost
cat > pixelpost/stats.py <<'FIXTURE_EOF'
def word_count(text):
    """Count the words in a post body."""
    return len(text.split())


def reading_time_minutes(text, words_per_minute=200):
    """Estimate reading time in whole minutes, at least 1."""
    words = word_count(text)
    minutes = (words + words_per_minute - 1) // words_per_minute
    return max(minutes, 1)
FIXTURE_EOF

cat > requirements.txt <<'FIXTURE_EOF'
pytest
FIXTURE_EOF

mkdir -p tests
touch tests/__init__.py

mkdir -p tests
cat > tests/test_stats.py <<'FIXTURE_EOF'
import unittest

from pixelpost.stats import reading_time_minutes, word_count


class StatsTests(unittest.TestCase):
    def test_word_count(self):
        self.assertEqual(word_count("one two three"), 3)

    def test_empty_text_has_zero_words(self):
        self.assertEqual(word_count(""), 0)

    def test_short_text_reads_in_one_minute(self):
        self.assertEqual(reading_time_minutes("a few words"), 1)

    def test_long_text_rounds_up(self):
        text = "word " * 250
        self.assertEqual(reading_time_minutes(text), 2)
FIXTURE_EOF

git add README.md requirements.txt VERSION pixelpost tests/__init__.py
git "${PRIYA[@]}" commit -q -m "add the pixelpost stats app"

export GIT_AUTHOR_DATE="2026-02-09T10:05:00" GIT_COMMITTER_DATE="2026-02-09T10:05:00"
git add tests build.sh
git "${PRIYA[@]}" commit -q -m "add tests and the release build script"

echo "pixelpost stats is ready at /root/gha-project-release"
