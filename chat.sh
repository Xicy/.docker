export $(grep -v '^#' .env | xargs)
docker pull rocketchat/rocket.chat:latest
docker stop rocketchat
docker rm rocketchat
docker run --name=rocketmongo --network=nginx-net --restart=unless-stopped -d mongo:3.0 --smallfiles
docker run --name=rocketchat --env="ROOT_URL=https://chat.$DOMAIN" --env="VIRTUAL_HOST=chat.$DOMAIN" --env="VIRTUAL_PORT=3000" --network=nginx-net --restart=unless-stopped --link rocketmongo -d rocketchat/rocket.chat
unset $(grep -v '^#' .env | sed -E 's/(.*)=.*/\1/' | xargs)
