#!/bin/bash
# apt update -y && apt install -y docker.io docker-compose

# create directory for OpenVPN configuration
mkdir -p /opt/openvpn

# run OpenVPN temporary containers with volume mounted for generating configurations
docker run -v /opt/openvpn:/etc/openvpn --rm -it kylemanna/openvpn ovpn_genconfig -u udp://<ip of vpn server>
docker run -v /opt/openvpn:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki
docker run -v /opt/openvpn:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full myclient

# start OpenVPN server container in detached mode
docker run --name=openvpn -v /opt/openvpn:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn

# export client configuration .ovpn file
docker run -v /opt/openvpn:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient myclient > myclient.ovpn

# Client software for connection: https://openvpn.net/client/
