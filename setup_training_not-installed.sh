#!/bin/bash

echo "================================================= Init Training Script"

echo "================================================= Init Training Script - Install Falco"
curl -fsSL https://falco.org/repo/falcosecurity-packages.asc | gpg --dearmor -o /usr/share/keyrings/falco-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/falco-archive-keyring.gpg] https://download.falco.org/packages/deb stable main" | tee -a /etc/apt/sources.list.d/falcosecurity.list
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get install -y dkms make linux-headers-$(uname -r)
DEBIAN_FRONTEND=noninteractive apt-get install -y clang llvm
DEBIAN_FRONTEND=noninteractive FALCO_FRONTEND=noninteractive apt-get install --yes falco=0.38.0

echo "================================================= Init Training Script - Finished Successfully"
