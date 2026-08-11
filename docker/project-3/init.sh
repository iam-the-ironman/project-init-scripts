#!/usr/bin/env bash
# esc bash - Docker Project #3 setup
set -euo pipefail
mkdir -p /root/report-tool
cat > /root/report-tool/main.go <<'EOF'
package main

import "fmt"

func main() {
    fmt.Println("report ready")
}
EOF
cat > /root/report-tool/go.mod <<'EOF'
module report-tool

go 1.22
EOF
echo "Project 3 ready. Source: /root/report-tool/"
echo "Write a multistage Dockerfile to optimize the image and publish to a local registry."
