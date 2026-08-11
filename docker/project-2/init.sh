#!/usr/bin/env bash
# esc bash - Docker Project #2 setup
set -euo pipefail
mkdir -p /root/orders-stack
cat > /root/orders-stack/app.py <<'EOF'
import os
from http.server import BaseHTTPRequestHandler, HTTPServer

import psycopg2

DB_HOST = os.environ.get("DB_HOST", "db")
DB_USER = os.environ.get("DB_USER", "orders")
DB_PASSWORD = os.environ.get("DB_PASSWORD", "orders")
DB_NAME = os.environ.get("DB_NAME", "orders")


def connect():
    conn = psycopg2.connect(
        host=DB_HOST, user=DB_USER, password=DB_PASSWORD, dbname=DB_NAME
    )
    conn.autocommit = True
    with conn.cursor() as cur:
        cur.execute(
            "CREATE TABLE IF NOT EXISTS orders (id serial PRIMARY KEY)"
        )
    return conn


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        try:
            conn = connect()
            with conn.cursor() as cur:
                if self.path == "/add":
                    cur.execute("INSERT INTO orders DEFAULT VALUES")
                    body = b"order recorded\n"
                else:
                    cur.execute("SELECT count(*) FROM orders")
                    body = f"orders: {cur.fetchone()[0]}\n".encode()
            conn.close()
            status = 200
        except Exception as exc:
            body = f"database error: {exc}\n".encode()
            status = 500
        self.send_response(status)
        self.send_header("Content-Type", "text/plain")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, fmt, *args):
        pass


HTTPServer(("0.0.0.0", 8000), Handler).serve_forever()
EOF
cat > /root/orders-stack/Dockerfile <<'EOF'
FROM python:3.12-slim
WORKDIR /app
RUN pip install psycopg2-binary
COPY app.py .
CMD ["python", "app.py"]
EOF
echo "Project 2 ready. Source: /root/orders-stack/"
echo "app.py requires DB_HOST, DB_USER, DB_PASSWORD, DB_NAME environment variables"
echo "Write compose.yaml to orchestrate the API and database containers."
