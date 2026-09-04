#!/usr/bin/env bash
set -euo pipefail

mkdir -p /root/hproject-3/docs /root/hproject-3/transcripts

cat > /root/hproject-3/ticket_api.py <<'DOC'
"""Mock ticket API on localhost:8300. Run: python3 ticket_api.py &"""
import json
from http.server import BaseHTTPRequestHandler, HTTPServer

TICKETS = {
    "T-101": {"id": "T-101", "subject": "Cannot log in after password reset",
              "body": "User resets password, then login fails with error 401 on the web app.",
              "label": None},
    "T-102": {"id": "T-102", "subject": "Invoice charged twice this month",
              "body": "Customer reports two identical charges on the March invoice.",
              "label": None},
    "T-103": {"id": "T-103", "subject": "Dashboard loads very slowly",
              "body": "The analytics dashboard takes over 40 seconds to render since Monday.",
              "label": None},
    "T-104": {"id": "T-104", "subject": "Request to export all account data",
              "body": "Customer asks for a full export of their account data for an audit.",
              "label": None},
    "T-105": {"id": "T-105", "subject": "API returns 500 on order creation",
              "body": "POST /orders returns 500 for one customer since the last deploy.",
              "label": None},
    "T-106": {"id": "T-106", "subject": "How do I add a teammate to my plan",
              "body": "Customer wants to know the steps to invite a second user.",
              "label": None},
}

VALID_LABELS = ["auth", "billing", "performance", "data-request", "bug", "how-to"]


class Handler(BaseHTTPRequestHandler):
    def _send(self, code, payload):
        body = json.dumps(payload).encode()
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        if self.path == "/tickets":
            self._send(200, [{"id": t["id"], "subject": t["subject"]}
                             for t in TICKETS.values()])
        elif self.path.startswith("/tickets/"):
            tid = self.path.split("/")[2]
            if tid in TICKETS:
                self._send(200, TICKETS[tid])
            else:
                self._send(404, {"error": "no such ticket"})
        else:
            self._send(404, {"error": "unknown path"})

    def do_POST(self):
        parts = self.path.split("/")
        if len(parts) == 4 and parts[1] == "tickets" and parts[3] == "label":
            tid = parts[2]
            length = int(self.headers.get("Content-Length", 0))
            data = json.loads(self.rfile.read(length) or b"{}")
            label = data.get("label")
            if tid not in TICKETS:
                self._send(404, {"error": "no such ticket"})
            elif label not in VALID_LABELS:
                self._send(400, {"error": "invalid label",
                                 "valid": VALID_LABELS})
            else:
                TICKETS[tid]["label"] = label
                self._send(200, {"ok": True, "id": tid, "label": label})
        else:
            self._send(404, {"error": "unknown path"})

    def log_message(self, *args):
        pass


if __name__ == "__main__":
    print("ticket api listening on http://localhost:8300")
    HTTPServer(("127.0.0.1", 8300), Handler).serve_forever()
DOC

cat > /root/hproject-3/docs/labels.md <<'DOC'
# Triage labels

Every ticket gets exactly one label:

auth - login, passwords, sessions, permissions
billing - charges, invoices, refunds, plans and prices
performance - slow pages, timeouts, high latency
data-request - exports, deletion requests, audit requests
bug - broken behavior that is not auth, billing, or performance
how-to - the customer asks how to do something, nothing is broken

Apply labels through the API: POST /tickets/<id>/label with a JSON
body like {"label": "billing"}. GET /tickets lists tickets, GET
/tickets/<id> returns one ticket with its body.
DOC

cat > /root/hproject-3/golden.jsonl <<'DOC'
{"ticket_id": "T-101", "expected_label": "auth"}
{"ticket_id": "T-102", "expected_label": "billing"}
{"ticket_id": "T-103", "expected_label": "performance"}
{"ticket_id": "T-104", "expected_label": "data-request"}
{"ticket_id": "T-105", "expected_label": "bug"}
{"ticket_id": "T-106", "expected_label": "how-to"}
DOC

cat > /root/hproject-3/price-sheet.json <<'DOC'
{
  "deepseek-v4-flash": {"input_per_1m_tokens_usd": 0.28, "output_per_1m_tokens_usd": 0.42},
  "deepseek-v4-pro": {"input_per_1m_tokens_usd": 1.20, "output_per_1m_tokens_usd": 2.40}
}
DOC

echo "Seeded /root/hproject-3 with ticket_api.py, docs, golden.jsonl, and price-sheet.json."
echo "Start the API with: python3 /root/hproject-3/ticket_api.py &"
