Install Openvpn server in Docker container (for example on Ubuntu) with getting myclient.ovpn for connection from Android, Windows, MacOS. Client you can download here: https://openvpn.net/client/

There is bash script install_openvpn_docker.sh or you can try to install manually:

# Install docker on ubuntu
apt update -y && apt install -y docker.io docker-compose

# Create directory for OpenVPN configuration
mkdir -p /opt/openvpn

# Run OpenVPN container with volume mounted
docker run -v /opt/openvpn:/etc/openvpn --rm -it kylemanna/openvpn ovpn_genconfig -u udp://<IP>
docker run -v /opt/openvpn:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki
docker run -v /opt/openvpn:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full myclient

# Start OpenVPN server container in detached mode
docker run -v /opt/openvpn:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn

# Export client configuration
docker run -v /opt/openvpn:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient myclient > myclient.ovpn
