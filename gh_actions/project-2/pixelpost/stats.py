def word_count(text):
    """Count the words in a post body."""
    return len(text.split())


def reading_time_minutes(text, words_per_minute=200):
    """Estimate reading time in whole minutes, at least 1."""
    words = word_count(text)
    minutes = (words + words_per_minute - 1) // words_per_minute
    return max(minutes, 1)
