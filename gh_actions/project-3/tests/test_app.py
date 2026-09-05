import unittest

from pixelpost.app import read_version, render_home


class AppTests(unittest.TestCase):
    def test_version_comes_from_the_version_file(self):
        self.assertEqual(read_version(), "2.0.0")

    def test_home_page_shows_the_version(self):
        page = render_home("2.0.0")
        self.assertIn("pixelpost", page)
        self.assertIn("version 2.0.0", page)
