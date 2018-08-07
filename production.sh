#!/usr/bin/env bash
docker update --restart=unless-stopped $(docker-compose ps -q)