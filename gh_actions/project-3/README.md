# pixelpost home

The pixelpost home page renderer. It reads the release version
from the VERSION file and renders the home page as plain text.

Run the tests:

    python3 -m unittest discover -s tests -t .

Deploy to this machine (used by the deploy workflow):

    DEPLOY_TOKEN=some-value bash scripts/deploy.sh
