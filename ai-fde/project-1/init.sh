#!/usr/bin/env bash
set -euo pipefail
mkdir -p /root/project-1/docs
cd /root/project-1/docs

cat > hr-policy.md <<'DOC'
# Northwind Robotics - HR Policy

Full time employees get 24 days of paid leave per year. Unused days
do not carry over to the next year. Leave requests go through the
PeopleHub portal and need manager approval at least 5 working days
before the first day off.

Sick leave is separate: up to 10 paid sick days per year, no
approval needed, just message your manager before 10:00.
DOC

cat > vpn-setup.md <<'DOC'
# VPN Setup

everyone connecting to internal systems must use the corporate VPN.

steps:
1. install WireGuard from the software portal
2. request a config file by opening a ticket with the IT team (queue: NET-ACCESS)
3. import the config, the tunnel name must be nw-corp
4. test with ping intranet.northwind.local

configs expire every 90 days. if the tunnel stops working, request a new config, do NOT reuse an old file.
DOC

cat > expenses.md <<'DOC'
# Expense Rules

Meals during business travel: up to 40 EUR per day, receipts required.
Hotel: book through TravelDesk only. Self-booked hotels are NOT reimbursed.
Software purchases under 50 EUR: allowed with manager approval, submit in Expensify within 30 days.
Anything above 50 EUR needs a procurement ticket first.

Late submissions (more than 30 days after the purchase) are rejected automatically.
DOC

cat > on-call.md <<'DOC'
ON-CALL GUIDE (platform team)
=============================

Rotation is weekly, Monday 09:00 to Monday 09:00.
Primary gets paged first. If no ack in 10 minutes, secondary is paged.

Compensation: 250 EUR per on-call week, paid with the next salary.

During an incident:
- acknowledge the page in PagerDuty
- open an incident channel named inc-<date>-<short-name>
- if customer facing for more than 15 minutes, update the status page
DOC

cat > laptop-refresh.txt <<'DOC'
laptop refresh policy

laptops are replaced every 36 months. you get an email from IT when
yours is due. old laptops must be returned within 2 weeks or the
replacement is cancelled. developers can choose between a 14 inch
and a 16 inch model. no personal purchases are reimbursed.
DOC

cat > remote-work.md <<'DOC'
# Remote Work

Northwind is hybrid. Everyone works from the office at least 2 days
per week (Tuesday is the anchor day for all teams). Fully remote
work for more than 2 consecutive weeks needs written approval from
your department head and HR.

Working from another country: max 30 days per year, request through
PeopleHub at least 4 weeks in advance.
DOC

cat > security-basics.md <<'DOC'
# Security Basics

- password manager (1Password) is mandatory for all work accounts
- hardware security key required for production systems
- phishing reports go to phishing@northwind-robotics.example
- lost or stolen device: report to IT within 4 hours, any time of day
- screen lock after 5 minutes is enforced by MDM, do not disable it
DOC

cat > meeting-rooms.txt <<'DOC'
booking meeting rooms

rooms are booked in Google Calendar. rooms named Mars, Venus and
Jupiter have video equipment, the small rooms (Pluto, Ceres) do not.
no-show for 10 minutes releases the room automatically.
recurring bookings longer than 3 months are cleaned up every quarter.
DOC

cat > onboarding.md <<'DOC'
# Onboarding Checklist (first week)

Day 1: collect laptop and badge at the front desk, HR intro at 10:00.
Day 2: security training (mandatory, link comes by email).
Day 3: set up VPN and development environment with your buddy.
By Friday: first ticket merged, even a small one. Your buddy helps.

Your buddy is assigned by your manager before you start.
DOC

cat > travel.md <<'DOC'
# Business Travel

Book flights and hotels through TravelDesk. Economy class for
flights under 6 hours, premium economy allowed above that.
Travel insurance is covered automatically for booked trips.

Rental cars need prior manager approval. Taxis and public transport
are expensed normally (see expense rules).
DOC

cat > it-support.txt <<'DOC'
getting IT help

all requests go through the servicedesk portal. urgent issues
(cannot work at all): call the hotline, extension 4444.
average response time for normal tickets is 1 business day.
hardware requests: use the HARDWARE queue, approval by your manager.
network and VPN issues: NET-ACCESS queue.
DOC

cat > holidays.md <<'DOC'
# Public Holidays and Office Closures

The office follows the public holidays of the country of your
contract. In addition, the office is closed between December 24
and January 1. These closure days do not count against your
personal leave.
DOC

cat > referrals.md <<'DOC'
# Employee Referrals

Refer a candidate through PeopleHub. If they are hired and pass
probation, you receive a 1500 EUR bonus with the next salary.
Referrals for your own direct reports do not qualify.
DOC

echo "Seeded /root/project-1/docs with $(ls /root/project-1/docs | wc -l | tr -d ' ') handbook files."
