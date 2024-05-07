#!/bin/bash

# Configuration Variables
ZEROTIER_NETWORK_ID="your-zerotier-network-id"
WIREGUARD_CONFIG="/path/to/your/wireguard.conf"

failed_zt=0
failed_wg=0

function start_connections {
    echo "Joining ZeroTier network..."
    zerotier-cli join "$ZEROTIER_NETWORK_ID"
    if [ $? -ne 0 ]; then
        failed_zt=1
        exit 1
    fi

    sleep 2  # Give a little time for the network to establish.

    echo "Activating WireGuard VPN..."
    wg-quick up "$WIREGUARD_CONFIG"
    if [ $? -ne 0 ]; then
        failed_wg=1
        exit 1
    fi
}

function stop_connections {
    if [ $failed_zt = 1 ]; then
        return 0
    fi

    if [ $failed_wg = 0 ]; then
        echo "Deactivating WireGuard VPN..."
        wg-quick down "$WIREGUARD_CONFIG"
    fi

    echo "Leaving ZeroTier network..."
    zerotier-cli leave "$ZEROTIER_NETWORK_ID"
}

# Check if the script is running as root
if [ "$(id -u)" != "0" ]; then
    echo "This script needs to run as root. Please run again with sudo."
    exit 1
fi

# Register the cleanup function to be called on the script's exit.
trap stop_connections EXIT

start_connections

# Keep script running until interrupted
echo "VPN is running. Press CTRL+C to exit."
while true; do
    sleep 10
done