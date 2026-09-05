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
