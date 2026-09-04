#!/usr/bin/env bash
set -euo pipefail

mkdir -p /root/hproject-1/task1 /root/hproject-1/task2 /root/hproject-1/task3

cat > /root/hproject-1/tasks.md <<'DOC'
# Coding tasks for the agent

Three small tasks. Point your agent at one task folder at a time.

## task1 - fix a bug
/root/hproject-1/task1/report.py prints the disk usage percent.
It currently prints the wrong number. Expected output when run:
usage: 80%
Fix the one broken line. Do not change anything else.

## task2 - implement a function
/root/hproject-1/task2/sizeparse.py has a function with a docstring
but no body. Implement parse_size exactly as the docstring says.

## task3 - write a file from a spec
Read /root/hproject-1/task3/spec.md and create the config file it
describes, at the path it names, with exactly the listed lines.
DOC

cat > /root/hproject-1/task1/report.py <<'DOC'
# Prints the disk usage percent for a fixed snapshot.
# Expected output: usage: 80%

used_gb = 400
total_gb = 500

percent = int(total_gb / used_gb * 100)

print(f"usage: {percent}%")
DOC

cat > /root/hproject-1/task2/sizeparse.py <<'DOC'
def parse_size(text):
    """Convert a size string to bytes.

    The input is a number followed by one letter unit:
    K = 1024, M = 1024 * 1024, G = 1024 * 1024 * 1024.
    A plain number with no unit is already bytes.

    Examples:
    parse_size("512") returns 512
    parse_size("10K") returns 10240
    parse_size("2M") returns 2097152
    parse_size("1G") returns 1073741824

    Raise ValueError for anything else.
    """
    raise NotImplementedError
DOC

cat > /root/hproject-1/task3/spec.md <<'DOC'
# Spec: backup job config

Create the file /root/hproject-1/task3/backup.cfg with exactly
these five lines, in this order:

job=nightly-backup
source=/var/lib/appdata
target=s3://acme-backups/appdata
retention_days=14
notify=oncall@acme.example
DOC

echo "Seeded /root/hproject-1 with tasks.md and 3 task folders."
