#!/usr/bin/env bash
set -euo pipefail
mkdir -p /root/project-2

cat > /root/project-2/orders_api.py <<'PY'
"""Mock orders API for the support assistant project.

Run it with: python3 /root/project-2/orders_api.py
It listens on http://localhost:8100

Endpoints:
  GET /orders/<order_id>          -> order details as JSON
  GET /orders/<order_id>/status   -> just the status
"""
import json
from http.server import BaseHTTPRequestHandler, HTTPServer

ORDERS = {
    "ORD-1001": {"order_id": "ORD-1001", "customer": "Mia Chen", "item": "standing desk", "status": "shipped", "carrier": "DHL", "eta_days": 2},
    "ORD-1002": {"order_id": "ORD-1002", "customer": "Ravi Patel", "item": "office chair", "status": "processing", "carrier": None, "eta_days": 5},
    "ORD-1003": {"order_id": "ORD-1003", "customer": "Sara Novak", "item": "monitor arm", "status": "delivered", "carrier": "UPS", "eta_days": 0},
    "ORD-1004": {"order_id": "ORD-1004", "customer": "Tom Baker", "item": "desk lamp", "status": "delayed", "carrier": "DHL", "eta_days": 9},
    "ORD-1005": {"order_id": "ORD-1005", "customer": "Lena Fischer", "item": "keyboard", "status": "cancelled", "carrier": None, "eta_days": None},
    "ORD-1006": {"order_id": "ORD-1006", "customer": "Omar Haddad", "item": "webcam", "status": "shipped", "carrier": "UPS", "eta_days": 3},
}


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        parts = [p for p in self.path.split("/") if p]
        if len(parts) >= 2 and parts[0] == "orders":
            order = ORDERS.get(parts[1])
            if order is None:
                self._send(404, {"error": "order not found"})
            elif len(parts) == 3 and parts[2] == "status":
                self._send(200, {"order_id": order["order_id"], "status": order["status"]})
            else:
                self._send(200, order)
        else:
            self._send(404, {"error": "unknown path"})

    def _send(self, code, payload):
        body = json.dumps(payload).encode()
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def log_message(self, *args):
        pass


if __name__ == "__main__":
    print("orders API listening on http://localhost:8100")
    HTTPServer(("127.0.0.1", 8100), Handler).serve_forever()
PY

cat > /root/project-2/tickets.csv <<'CSV'
ticket_id,order_id,question
T-01,ORD-1001,Where is my standing desk?
T-02,ORD-1002,Has my chair shipped yet?
T-03,ORD-1003,Did my monitor arm arrive?
T-04,ORD-1004,My lamp is late. What is going on?
T-05,ORD-1005,I cancelled my keyboard. Is that confirmed?
T-06,ORD-1006,Which carrier has my webcam?
T-07,ORD-1001,When will order ORD-1001 arrive?
T-08,ORD-1004,How many days until ORD-1004 arrives?
T-09,ORD-1002,What is the status of ORD-1002?
T-10,ORD-9999,Where is order ORD-9999?
T-11,ORD-1003,Who was the carrier for ORD-1003?
T-12,ORD-1006,Is ORD-1006 delayed?
T-13,ORD-1001,Which carrier ships ORD-1001?
T-14,ORD-1005,What is the status of ORD-1005?
T-15,ORD-1002,What item is in order ORD-1002?
T-16,ORD-1004,Which carrier has ORD-1004?
T-17,ORD-1003,What is the status of ORD-1003?
T-18,ORD-1006,When does ORD-1006 arrive?
T-19,ORD-8888,What is the status of ORD-8888?
T-20,ORD-1001,What item did I order in ORD-1001?
CSV

cat > /root/project-2/golden.jsonl <<'JSONL'
{"id": "g-01", "question": "What is the status of ORD-1001?", "must_contain": ["shipped"]}
{"id": "g-02", "question": "Which carrier has ORD-1001?", "must_contain": ["DHL"]}
{"id": "g-03", "question": "What is the status of ORD-1002?", "must_contain": ["processing"]}
{"id": "g-04", "question": "Did ORD-1003 arrive?", "must_contain": ["delivered"]}
{"id": "g-05", "question": "What is the status of ORD-1004?", "must_contain": ["delayed"]}
{"id": "g-06", "question": "How many days until ORD-1004 arrives?", "must_contain": ["9"]}
{"id": "g-07", "question": "What is the status of ORD-1005?", "must_contain": ["cancelled"]}
{"id": "g-08", "question": "Which carrier has ORD-1006?", "must_contain": ["UPS"]}
JSONL

echo "Seeded /root/project-2 with orders_api.py, tickets.csv (20 tickets) and golden.jsonl (8 items)."
