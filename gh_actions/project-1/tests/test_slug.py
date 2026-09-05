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
