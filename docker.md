# Docker

Pull and Install
```sh
# Pull based on the yaml manifest
docker compose pull

# Run the container detached from the stdout
docker compose up -d

# Stops the container
docker compose stop

# Stops and removes the container
docker compose down
```

Common commands
```sh
# View Stats
docker stats

# View services and filter with grep
docker ps | grep nextcloud

# View logs
docker logs 97f910a37a53

# List container names
docker ps --format '{{.Names}}'

# Enter to the container sh shell
docker exec -it openspeedtest /bin/sh

# Enter to the container bash shell
docker exec -it openspeedtest /bin/bash

# View live logs
docker logs -f openspeedtest

# View live logs with docker compose
docker compose logs -f
```


Creates and starts a container from an image
```sh
docker run -d --name my_container -p 8080:80 nginx
```

Lists running containers, add -a to see all containers
```sh
docker ps
```

```sh
# Manages the lifecycle of containers
docker start/stop/restart

# Removes one or more containers
docker rm my_container

# Fetches the logs of a container
docker logs -f my_container

# Builds an image from a Dockerfile
docker build -t myapp:1.0 .

# Cleans up unused data to free up space
docker system prune

# Displays system-wide information
docker info

# Cleans up unused data to free up space
docker system prune

# Manages Docker networks
docker network create/ls/rm

# Manages data volumes that containers
docker volume create/ls/rm

# Builds or rebuilds services
docker compose build

# Starts or stops services without creating or destroying them
docker compose start/stop

# Restarts services
docker compose restart

# Views output from services. Adding -f will follow the log output
docker compose logs

# Executes a command inside a running service container
docker compose exec
```
