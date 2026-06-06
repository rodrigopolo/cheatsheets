# Podman Cheat Sheet

## Installation & Machine Management

### Install Podman
```bash
# macOS
brew install podman

# Ubuntu/Debian
sudo apt update && sudo apt install podman

# RHEL/CentOS/Fedora
sudo dnf install podman
```

### Install Podman Compose
```bash
# macOS (separate installation required)
brew install podman-compose

# Ubuntu/Debian
sudo apt install podman-compose

# RHEL/CentOS/Fedora
sudo dnf install podman-compose

# Or install via pip (cross-platform)
pip3 install podman-compose
```

### Machine Management (macOS/Windows)
```bash
# Initialize podman machine
podman machine init

# Start podman machine
podman machine start

# Stop podman machine
podman machine stop

# List machines
podman machine ls

# Remove machine
podman machine rm

# Set machine to rootful mode
podman machine set --rootful

# Install podman-mac-helper (macOS)
sudo /opt/homebrew/Cellar/podman/5.5.2/bin/podman-mac-helper install

# SSH into machine
podman machine ssh
```

## Container Management

### Running Containers
```bash
# Run a container
podman run <image>

# Run container in background (detached)
podman run -d <image>

# Run container with port mapping
podman run -p 8080:80 <image>

# Run container with volume mount
podman run -v /host/path:/container/path <image>

# Run container with environment variables
podman run -e VAR_NAME=value <image>

# Run container with custom name
podman run --name my-container <image>

# Run interactive container with TTY
podman run -it <image> /bin/bash

# Run container and remove after exit
podman run --rm <image>
```

### Container Lifecycle
```bash
# List running containers
podman ps

# List all containers (including stopped)
podman ps -a

# Stop container
podman stop <container_id_or_name>

# Start stopped container
podman start <container_id_or_name>

# Restart container
podman restart <container_id_or_name>

# Remove container
podman rm <container_id_or_name>

# Remove all stopped containers
podman container prune

# Force remove running container
podman rm -f <container_id_or_name>
```

### Container Inspection
```bash
# View container logs
podman logs <container_id_or_name>

# Follow logs in real-time
podman logs -f <container_id_or_name>

# Execute command in running container
podman exec -it <container_id_or_name> <command>

# Get container information
podman inspect <container_id_or_name>

# View container processes
podman top <container_id_or_name>

# View container statistics
podman stats <container_id_or_name>
```

## Image Management

### Image Operations
```bash
# List images
podman images

# Pull image from registry
podman pull <image>

# Remove image
podman rmi <image>

# Remove unused images
podman image prune

# Remove all images
podman rmi -a

# Search for images
podman search <term>

# Get image information
podman inspect <image>

# View image history
podman history <image>
```

### Building Images
```bash
# Build image from Dockerfile
podman build -t <tag> <path>

# Build image with custom Dockerfile name
podman build -f <dockerfile> -t <tag> <path>

# Build image without cache
podman build --no-cache -t <tag> <path>

# Build image with build arguments
podman build --build-arg ARG=value -t <tag> <path>
```

## Pod Management

### Pod Operations
```bash
# Create pod
podman pod create --name <pod_name>

# List pods
podman pod ls

# Start pod
podman pod start <pod_name>

# Stop pod
podman pod stop <pod_name>

# Remove pod
podman pod rm <pod_name>

# Run container in pod
podman run --pod <pod_name> <image>

# Create pod with port mapping
podman pod create --name <pod_name> -p 8080:80

# Get pod information
podman pod inspect <pod_name>
```

## Volume Management

### Volume Operations
```bash
# Create volume
podman volume create <volume_name>

# List volumes
podman volume ls

# Remove volume
podman volume rm <volume_name>

# Remove unused volumes
podman volume prune

# Inspect volume
podman volume inspect <volume_name>

# Mount volume in container
podman run -v <volume_name>:/path/in/container <image>
```

## Network Management

### Network Operations
```bash
# List networks
podman network ls

# Create network
podman network create <network_name>

# Remove network
podman network rm <network_name>

# Inspect network
podman network inspect <network_name>

# Connect container to network
podman network connect <network_name> <container_name>

# Disconnect container from network
podman network disconnect <network_name> <container_name>
```

## Compose Operations

### Docker Compose Compatibility
```bash
# Start services defined in docker-compose.yml
podman-compose up

# Start services in background
podman-compose up -d

# Stop services
podman-compose down

# Stop and remove volumes
podman-compose down -v

# Build services
podman-compose build

# View logs
podman-compose logs

# Follow logs
podman-compose logs -f

# List running services
podman-compose ps

# Execute command in service
podman-compose exec <service> <command>

# Pull latest images
podman-compose pull

# Restart services
podman-compose restart

# Scale services
podman-compose up --scale <service>=<number>

# Validate compose file
podman-compose config

# Use custom compose file
podman-compose -f <compose-file.yml> up
```

## Registry Operations

### Image Registry
```bash
# Login to registry
podman login <registry_url>

# Logout from registry
podman logout <registry_url>

# Push image to registry
podman push <image>

# Tag image
podman tag <source_image> <target_image>

# Save image to tar file
podman save -o <filename.tar> <image>

# Load image from tar file
podman load -i <filename.tar>
```

## System Management

### System Information
```bash
# Show system information
podman system info

# Show podman version
podman version

# Show disk usage
podman system df

# Clean up system (remove unused data)
podman system prune

# Clean up everything (containers, images, volumes, networks)
podman system prune -a --volumes

# Show system events
podman system events
```

## Useful Aliases

Add these to your shell profile (.bashrc, .zshrc, etc.):

```bash
# Container aliases
alias pps='podman ps'
alias ppsa='podman ps -a'
alias prun='podman run'
alias pstop='podman stop'
alias prm='podman rm'
alias pexec='podman exec -it'
alias plogs='podman logs -f'

# Image aliases
alias pimg='podman images'
alias ppull='podman pull'
alias pbuild='podman build'
alias prmi='podman rmi'

# System aliases
alias pinfo='podman system info'
alias pclean='podman system prune'
alias pcleanall='podman system prune -a --volumes'

# Compose aliases
alias pup='podman-compose up'
alias pupd='podman-compose up -d'
alias pdown='podman-compose down'
alias pclogs='podman-compose logs -f'
alias pcexec='podman-compose exec'
```

## Common Use Cases

### Development Environment
```bash
# Run database container
podman run -d --name postgres \
  -e POSTGRES_PASSWORD=secret \
  -p 5432:5432 \
  postgres:15

# Run Redis container
podman run -d --name redis \
  -p 6379:6379 \
  redis:alpine

# Run web server with volume mount
podman run -d --name nginx \
  -p 8080:80 \
  -v ./html:/usr/share/nginx/html:ro \
  nginx:alpine
```

### Multi-Container Applications
```bash
# Example docker-compose.yml with podman compose
podman-compose up -d

# Scale specific service
podman-compose up --scale web=3

# View service logs
podman-compose logs web

# Execute command in service
podman-compose exec web /bin/bash
```

### Quick Testing
```bash
# Run temporary container for testing
podman run --rm -it alpine /bin/sh

# Run one-off command
podman run --rm alpine echo "Hello World"

# Test network connectivity
podman run --rm alpine ping google.com
```

## Tips and Best Practices

- Use `--rm` flag for temporary containers to avoid cleanup
- Use specific image tags instead of `latest` for production
- Regularly clean up unused containers and images with `podman system prune`
- Use volumes for persistent data instead of bind mounts when possible
- Use pods to group related containers together
- Always stop containers gracefully before removing them
- Use `podman inspect` to troubleshoot container issues
