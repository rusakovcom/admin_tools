#!/bin/bash
# apt update -y && apt install -y docker.io docker-compose

# Define variables
VPN_SERVER_IP="<ip of vpn server>"
CLIENT_NAME="myclient"
CONFIG_DIR="/opt/openvpn"
DOCKER_IMAGE="kylemanna/openvpn"

# Create directory for OpenVPN configuration if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Run OpenVPN container for configuration generation
docker run \
    -v "$CONFIG_DIR":/etc/openvpn \
    --rm \
    -it \
    "$DOCKER_IMAGE" \
    /bin/bash -c "\
    ovpn_genconfig -u udp://$VPN_SERVER_IP && \
    ovpn_initpki && \
    easyrsa build-client-full $CLIENT_NAME"

# Start OpenVPN server container in detached mode
docker run \
    --name=openvpn \
    -v "$CONFIG_DIR":/etc/openvpn \
    -d \
    -p 1194:1194/udp \
    --cap-add=NET_ADMIN \
    "$DOCKER_IMAGE"

# Export client configuration .ovpn file
docker run \
    -v "$CONFIG_DIR":/etc/openvpn \
    --rm \
    "$DOCKER_IMAGE" \
    ovpn_getclient $CLIENT_NAME > "$CLIENT_NAME.ovpn"

