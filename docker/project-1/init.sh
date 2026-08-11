#!/usr/bin/env bash
# esc bash - Docker Project #1 setup
set -euo pipefail
mkdir -p /root/orders-web
cat > /root/orders-web/app.py <<'EOF'
from http.server import BaseHTTPRequestHandler, HTTPServer


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        body = b"esc bash orders v1\n"
        self.send_response(200)
        self.send_header("Content-Type", "text/plain")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, fmt, *args):
        pass


HTTPServer(("0.0.0.0", 8000), Handler).serve_forever()
EOF
cat > /root/orders-web/requirements.txt <<'EOF'
# stdlib only - nothing to install
EOF
echo "Project 1 ready. Source: /root/orders-web/"
echo "Write Dockerfile to containerize this web service."
