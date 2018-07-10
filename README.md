# xDocker

This repo made for special using. It's chanced lats of thing added nginx proxy for multi project 

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

docker
docker-compose

```
sudo wget -q -O - "http://get.docker.com"  | bash
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

### Installing

Firstly 

```
mv .env.example .env
```

edit .env. file and

```
./proxy.sh
docker-compose up -d nginx mysql redis phpmyadmin
```

## Authors
* **Laradock** - *Initial work* - [Laradock](https://github.com/laradock)
* **Umut Akkaya** - *Edit* - [Xicy](https://github.com/xicy)

## License

This project is licensed under the MIT License