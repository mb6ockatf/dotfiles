#!/usr/bin/env bash
# install_hosts.sh - install good /etc/hosts contents that ban malicious stuff,
# advertising, etc
#
#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
echo "Installs /etc/hosts file to redirect spam, malicious, etc. to 0.0.0.0"
echo "warning: takes around 21MB, and download requires time"
echo "be careful when opening /etc/hosts: it is huge"
echo "ctrl-c to cancel"
read -r
address="https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/hosts/ultimate.txt"
curl "$address" -o finalhosts
cat hosts >> finalhosts
