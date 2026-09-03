#!/usr/bin/env bash
set -euo pipefail
mkdir -p /root/project-3/docs

cat > /root/project-3/customer-brief.md <<'DOC'
# Customer Brief: Velora Freight

Velora Freight is a mid-size logistics company. They move parcels
between 40 depots. Their support team answers around 600 questions
per day, mostly "where is my shipment" and questions about the
company's own shipping rules (cut-off times, damaged parcels,
customs paperwork).

They want an internal assistant for their support agents that:
- answers policy questions from the internal docs, with citations
- looks up live shipment status from their tracking API
- refuses to answer anything not covered by docs or the API

Their tracking API is mocked for this engagement (see
/root/project-3/tracking_api.py). Budget matters: they asked for a
monthly cost estimate before signing off.
DOC

cat > /root/project-3/docs/shipping-rules.md <<'DOC'
# Shipping Rules

Same-day dispatch cut-off is 16:30 local depot time. Parcels
scanned after cut-off leave with the next day's run. Maximum parcel
weight is 31.5 kg; heavier freight goes through the pallet service.
DOC

cat > /root/project-3/docs/damaged-parcels.md <<'DOC'
# Damaged Parcels

Customers report damage within 7 days of delivery. The support
agent opens a damage case with photos attached. Compensation is
paid out within 14 days after the case is approved. Maximum
compensation without insurance is 500 EUR per parcel.
DOC

cat > /root/project-3/docs/customs.md <<'DOC'
# Customs Paperwork

Shipments outside the EU need a CN23 form. The sender fills it in
through the customer portal before drop-off. Missing customs forms
hold the parcel at the export depot for up to 5 working days before
it is returned to the sender.
DOC

cat > /root/project-3/docs/refunds.md <<'DOC'
# Refunds for Late Delivery

Express parcels delivered more than 24 hours late get the shipping
fee refunded automatically. Standard parcels have no delivery time
guarantee and no lateness refund. Refunds appear on the next
invoice.
DOC

cat > /root/project-3/docs/pickup.md <<'DOC'
# Pickup Service

Business customers can book a daily pickup slot. Slots are booked
at least one working day in advance through the portal. A missed
pickup (driver arrived, nothing to collect) is charged at 12 EUR
after the second occurrence in a month.
DOC

cat > /root/project-3/tracking_api.py <<'PY'
"""Mock Velora Freight tracking API.

Run it with: python3 /root/project-3/tracking_api.py
It listens on http://localhost:8200

Endpoint: GET /shipments/<tracking_id> -> shipment JSON
"""
import json
from http.server import BaseHTTPRequestHandler, HTTPServer

SHIPMENTS = {
    "VF-70001": {"tracking_id": "VF-70001", "status": "in transit", "last_depot": "Rotterdam", "eta_days": 1},
    "VF-70002": {"tracking_id": "VF-70002", "status": "delivered", "last_depot": "Lyon", "eta_days": 0},
    "VF-70003": {"tracking_id": "VF-70003", "status": "held at customs", "last_depot": "Basel", "eta_days": 4},
    "VF-70004": {"tracking_id": "VF-70004", "status": "out for delivery", "last_depot": "Porto", "eta_days": 0},
    "VF-70005": {"tracking_id": "VF-70005", "status": "delayed", "last_depot": "Gdansk", "eta_days": 3},
}


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        parts = [p for p in self.path.split("/") if p]
        if len(parts) == 2 and parts[0] == "shipments":
            shipment = SHIPMENTS.get(parts[1])
            if shipment is None:
                self._send(404, {"error": "shipment not found"})
            else:
                self._send(200, shipment)
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
    print("tracking API listening on http://localhost:8200")
    HTTPServer(("127.0.0.1", 8200), Handler).serve_forever()
PY

cat > /root/project-3/golden.jsonl <<'JSONL'
{"id": "g-01", "question": "What is the same-day dispatch cut-off time?", "must_contain": ["16:30"]}
{"id": "g-02", "question": "What is the maximum parcel weight?", "must_contain": ["31.5"]}
{"id": "g-03", "question": "Within how many days must a customer report a damaged parcel?", "must_contain": ["7"]}
{"id": "g-04", "question": "What is the maximum compensation without insurance?", "must_contain": ["500"]}
{"id": "g-05", "question": "Which form is needed for shipments outside the EU?", "must_contain": ["CN23"]}
{"id": "g-06", "question": "Do standard parcels get a refund for late delivery?", "must_contain": ["no"]}
{"id": "g-07", "question": "What is the status of shipment VF-70001?", "must_contain": ["in transit"]}
{"id": "g-08", "question": "Where was shipment VF-70003 last seen?", "must_contain": ["Basel"]}
{"id": "g-09", "question": "What is the status of shipment VF-70005?", "must_contain": ["delayed"]}
{"id": "g-10", "question": "How much is a missed pickup charged after the second occurrence?", "must_contain": ["12"]}
JSONL

cat > /root/project-3/price-sheet.md <<'DOC'
# Model Price Sheet (per 1 million tokens, USD)

| model                  | input | output |
|------------------------|-------|--------|
| deepseek-v4-flash      | 0.30  | 1.20   |
| deepseek-v4-pro        | 1.50  | 6.00   |
| glm-5.2                | 0.90  | 3.50   |
| text-embedding-3-small | 0.02  | -      |
DOC

echo "Seeded /root/project-3 with customer-brief.md, docs/ (5 files), tracking_api.py, golden.jsonl (10 items) and price-sheet.md."
