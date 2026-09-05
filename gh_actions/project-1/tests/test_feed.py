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
