#!/bin/bash
# apt update -y && apt install -y docker.io docker-compose

# Create directory for OpenVPN configuration
mkdir -p /opt/openvpn

# Run OpenVPN container with volume mounted
docker run -v /opt/openvpn:/etc/openvpn --rm -it kylemanna/openvpn ovpn_genconfig -u udp://93.183.74.90
docker run -v /opt/openvpn:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki
docker run -v /opt/openvpn:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full myclient nopass

# Start OpenVPN server container in detached mode
docker run -v /opt/openvpn:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn

# Export client configuration
docker run -v /opt/openvpn:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient myclient > myclient.ovpn

echo "OpenVPN setup complete."

