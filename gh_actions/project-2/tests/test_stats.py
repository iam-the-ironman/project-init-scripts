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
