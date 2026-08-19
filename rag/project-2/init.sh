#!/usr/bin/env bash
set -e
mkdir -p /root/kb /root/tickets /root/replies
cat > /root/kb/article-1.md <<'DOC'
Refunds: Orders can be refunded within 30 days of purchase. The
refund goes back to the original payment method within 5 working
days of approval.
DOC
cat > /root/kb/article-2.md <<'DOC'
Account deletion: A user can delete their account from the privacy
page. All data is removed within 14 days, and this cannot be
undone.
DOC
cat > /root/kb/article-3.md <<'DOC'
Subscription changes: Plan upgrades apply at once, and the price
difference is charged immediately. Downgrades apply at the start of
the next billing period.
DOC
cat > /root/kb/article-4.md <<'DOC'
Data export: Users can export all their data as a ZIP file from the
settings page. The export link arrives by email within one hour.
DOC
cat > /root/tickets/ticket-1.txt <<'DOC'
I bought the wrong plan two days ago. Can I get my money back?
DOC
cat > /root/tickets/ticket-2.txt <<'DOC'
I want a copy of everything you store about me. How do I get it?
DOC
cat > /root/tickets/ticket-3.txt <<'DOC'
If I move to the cheaper plan today, when does it start?
DOC
echo "Seeded /root/kb with 4 articles and /root/tickets with 3 tickets."
