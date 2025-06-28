#!/usr/bin/env bash
echo "Installs /etc/hosts file to redirect spam, malicious, etc. to 0.0.0.0"
echo "warning: takes around 21MB, and download requires time"
echo "be careful when opening /etc/hosts: it is huge"
echo "ctrl-c to cancel"
read -r
address="https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/hosts/ultimate.txt"
curl "$address" -o finalhosts
cat hosts >> finalhosts
