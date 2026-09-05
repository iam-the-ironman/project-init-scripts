def latest_posts(posts, count):
    """Return the newest posts first, limited to count items.

    posts is a list of (date_string, title) tuples.
    """
    ordered = sorted(posts, key=lambda post: post[0], reverse=True)
    return ordered[:count]
