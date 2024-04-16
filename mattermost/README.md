Official documentation
https://docs.mattermost.com/install/install-docker.html#deploy-mattermost-on-docker-for-production-use

In this repository there is example of .env, nginx default.conf and other configurations for deployment Mattermost with you own SSL, there will be three containers in docker: mattermost (app), nginx, postgres.


An approximate algorithm:


git clone https://github.com/mattermost/docker

cd docker

cp env.example .env

mkdir -p ./volumes/app/mattermost/{config,data,logs,plugins,client/plugins,bleve-indexes}
sudo chown -R 2000:2000 ./volumes/app/mattermost

mkdir -p ./volumes/web/cert
cp <PATH-TO-PRE-EXISTING-CERT>.pem ./volumes/web/cert/cert.pem
cp <PATH-TO-PRE-EXISTING-KEY>.pem ./volumes/web/cert/key-no-password.pem

add to .env

DOMAIN=example.com
CERT_PATH=./volumes/web/cert/cert.pem
KEY_PATH=./volumes/web/cert/key-no-password.pem

sudo docker compose -f docker-compose.yml -f docker-compose.nginx.yml up -d
