# Proxmox in ZimaBlade

### Setup
* Nginx Proxy Manager LXC
* AdGuard Home LXC
* Docker/Samba LXC
  * Immich
  * NextCloud
* Jellyfin LXC

### Requirements
* ZimaBlade
* Two SATA HDD
* One USB SSD
* USB HUB with at least 4 USB ports
* USB Drive for installation
* Keyboard and mouse

### Steps
1. Download ISO and Create bootable USB
2. Install Proxmox
3. Connect disks
4. Download debian template
5. Create Docker/Samba container
6. Create mirror pool
7. Attach mirror pool to the Docker/Samba container
8. Setup the Docker/Samba and other LXC

## Create Boot Drive and Install

> You can use `diskutil` or balenaEtcher.

### Installation
1. Select the destination.
2. Select country, time zone and keyboard layout.
3. Set your password and email.
4. Set your network settings.

## Docker in a generic Linux Container (LXC)
> 12GB RAM, 200GB HD, 4 Cores

### Setup steps
1. Press the `Create CT` button.
2. Enter the host name and password, then press `Next`.
3. Select the debian template.
4. Select the storage pool, and set the disk size.
5. Select the number of cores.
6. Set the memory limit.
7. Set the network settings.
8. Set the DNS settings.
9. Confirm and press `Finish`, do NOT start the container.

> Consider set the container as unprivileged and enabling `Nesting`, `NFS` and `SMB/CIFS` in `Options`.

### Creating the media pool and adding it to the main node

> In case force is needed for mirror
> ```
> /sbin/zpool create -f <commands>
> ```

```sh
# List ZFS
zfs list

# Create a pool
zfs create mzp/media

# Limit (Optional)
zfs set quota=100G mzp/media

# Set the mountpoint for 102 container
pct set 100 --mp1 /mzp/media,mp=/mnt/media

# Set permissions
chmod -R 777 /mzp/media
```

### Creating the main user for Docker/Samba

Update and install `sudo` and `curl`
```sh
apt update && apt upgrade
apt install sudo curl
```

Add the main user, replace `johnsmith` with your own
```sh
adduser johnsmith
```

Adding the user to sudoers
```sh
usermod -aG sudo johnsmith
```

Get your ip address
```sh
ip address
```

### Seting up Docker with the main user

With the newly created user, login using the remote terminal
```sh
ssh johnsmith@192.168.1.6
```

Install docker, replace `johnsmith` with your own
```sh
sudo apt update && sudo apt upgrade
curl -sSL https://get.docker.com | sh
sudo usermod -aG docker johnsmith
```

### File sharing

Install Samba
```sh
sudo apt install samba
```

Create your sharing directory in the zpool path
```sh
cd /mnt/media && mkdir nas guests
```

Create your Samba user
```sh
sudo smbpasswd -a johnsmith
```

Edit Config
```sh
sudo nano /etc/samba/smb.conf
```

Set the `/etc/samba/smb.conf` like this:
```sh
[global]
   # General server settings
   workgroup = WORKGROUP
   server string = Debian Samba Server
   security = user
   map to guest = Bad Password
   guest account = johnsmith
   
   # macOS compatibility
   server min protocol = SMB2
   server signing = auto
   client min protocol = SMB2
   client max protocol = SMB3

   # Logging (optional, for debugging)
   log file = /var/log/samba/log.%m
   max log size = 1000
   logging = file

   # Performance tweaks (optional)
   socket options = TCP_NODELAY IPTOS_LOWDELAY

[Guests]
   path = /mnt/media/guests
   writable = yes
   browsable = yes
   guest ok = yes
   read only = no
   create mask = 0666
   directory mask = 0777
   force user = johnsmith

[MyNAS]
   path = /mnt/media/nas
   writable = yes
   browsable = yes
   valid users = johnsmith
   guest ok = no
   read only = no
   create mask = 0666
   directory mask = 0777
```

Restart Samba
```sh
sudo systemctl restart smbd
```

Shares file structure
```
|-- guests
`-- nas
	|-- Movies
	|-- Pics
	`-- Shows
```

## Immich in Docker LXC

Download the Docker compose file
```sh
cd && mkdir immich && cd immich
wget -O docker-compose.yml https://github.com/immich-app/immich/releases/latest/download/docker-compose.yml
wget -O .env https://github.com/immich-app/immich/releases/latest/download/example.env
```

For external libraries, edit the `docker-compose.yml` and add the path for the external library
```sh
nano docker-compose.yml
```

From this:
```yaml
  volumes:
    # Do not edit the next line. If you want to change the media storage location on your system, edit the value of UPLOAD>
    - ${UPLOAD_LOCATION}:/usr/src/app/upload
    - /etc/localtime:/etc/localtime:ro
```

To this:
```yaml
  volumes:
    # Do not edit the next line. If you want to change the media storage location on your system, edit the value of UPLOAD>
    - ${UPLOAD_LOCATION}:/usr/src/app/upload
    - /etc/localtime:/etc/localtime:ro
    - /mnt/media/nas/Pics:/import/pictures
```

Install and run
```sh
docker compose up -d
```

Update by connecting trough ssh
```sh
cd immich && docker compose down -v && docker compose pull && docker compose up -d
```

> Installation instructions from https://immich.app/docs/install/docker-compose

## Jellyfin Media Server LXC
> 2GB RAM, 20GB HD, 4 Cores

1. Install the container with script
2. Set the pool mount point
3. Follow the setup wizard

### Install
In the pve->shell, run this recipe and follow the prompts:
```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/ct/jellyfin.sh)"
```
Recipe: https://community-scripts.github.io/ProxmoxVE/scripts?id=jellyfin

### Set the pool mount point
```sh
# Set the mountpoint for 101 container
pct set 101 --mp1 /mzp/media,mp=/mnt/media
```

## Nginx Proxy Manager LXC
> 1GB RAM, 8GB HD, 1 Core

In the pve->shell, run this recipe and follow the prompts:
```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/ct/nginxproxymanager.sh)"
```
> Recipe: https://community-scripts.github.io/ProxmoxVE/scripts?id=nginxproxymanager

Default login
```
Email:    admin@example.com
Password: changeme
```

## AdGuard Home LXC
> 1GB RAM, 8GB HD, 2 Cores

In the pve->shell, run this recipe and follow the prompts:
```sh
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/ct/adguard.sh)"
```
> Recipe: https://community-scripts.github.io/ProxmoxVE/scripts?id=adguard


## NextCloud in Docker LXC

Requirements:
* A public ip.
* A fully qualified domain name (FQDN) pointing to the public ip.
* Your ports `80` and `443` open in your router.
* Nginx Proxy Manager already running behind the router.
* Docker installed and running.

#### NextCloud Nginx Proxy Manager Settings

| Setting               | Value |
|-----------------------|-------|
| Scheme                | http  |
| Forward port          | 11000 |
| Block Common Exploits | On    |
| Websockets Support    | On    |

Custom Nginx Configuration:
```
client_body_buffer_size 512k;
proxy_read_timeout 86400s;
client_max_body_size 0;
```

> The following script is based in the official [all-in-one/compose.yaml](https://github.com/nextcloud/all-in-one/blob/main/compose.yaml).

```sh
cd && mkdir nextcloud && cd nextcloud/
nano docker-compose.yml
```

```yaml
services:
  nextcloud-aio-mastercontainer:
    image: nextcloud/all-in-one:latest
    init: true
    restart: always
    container_name: nextcloud-aio-mastercontainer # This line is not allowed to be changed
    volumes:
      - nextcloud_aio_mastercontainer:/mnt/docker-aio-config # This line is not allowed to be changed
      #- /var/run/docker.sock.raw:/var/run/docker.sock:ro # macOS
      - /var/run/docker.sock:/var/run/docker.sock:ro # Linux
    ports:
      - 8080:8080
    environment:
      APACHE_PORT: 11000 # Is needed when running behind a web server or reverse proxy (like Apache, Nginx, Cloudflare Tunnel and else). See https://github.com/nextcloud/all-in-one/blob/main/reverse-proxy.md
      APACHE_IP_BINDING: 0.0.0.0 # Should be set when running behind a web server or reverse proxy (like Apache, Nginx, Cloudflare Tunnel and else) that is running on the same host. See https://github.com/nextcloud/all-in-one/blob/main/reverse-proxy.md
      # NEXTCLOUD_DATADIR: /mnt/ncdata # Allows to set the host directory for Nextcloud's datadir. ⚠️⚠️⚠️ Warning: do not set or adjust this value after the initial Nextcloud installation is done! See https://github.com/nextcloud/all-in-one#how-to-change-the-default-location-of-nextclouds-datadir
      # NEXTCLOUD_MOUNT: /Volumes/path/to/external # Allows the Nextcloud container to access the chosen directory on the host. See https://github.com/nextcloud/all-in-one#how-to-allow-the-nextcloud-container-to-access-directories-on-the-host
      # NEXTCLOUD_UPLOAD_LIMIT: 10G # Can be adjusted if you need more. See https://github.com/nextcloud/all-in-one#how-to-adjust-the-upload-limit-for-nextcloud
      # NEXTCLOUD_MAX_TIME: 3600 # Can be adjusted if you need more. See https://github.com/nextcloud/all-in-one#how-to-adjust-the-max-execution-time-for-nextcloud
      # NEXTCLOUD_MEMORY_LIMIT: 512M # Can be adjusted if you need more. See https://github.com/nextcloud/all-in-one#how-to-adjust-the-php-memory-limit-for-nextcloud
      # NEXTCLOUD_STARTUP_APPS: deck twofactor_totp tasks calendar contacts notes # Allows to modify the Nextcloud apps that are installed on starting AIO the first time. See https://github.com/nextcloud/all-in-one#how-to-change-the-nextcloud-apps-that-are-installed-on-the-first-startup
      # NEXTCLOUD_ADDITIONAL_APKS: imagemagick # This allows to add additional packages to the Nextcloud container permanently. Default is imagemagick but can be overwritten by modifying this value. See https://github.com/nextcloud/all-in-one#how-to-add-os-packages-permanently-to-the-nextcloud-container
      # NEXTCLOUD_ADDITIONAL_PHP_EXTENSIONS: imagick # This allows to add additional php extensions to the Nextcloud container permanently. Default is imagick but can be overwritten by modifying this value. See https://github.com/nextcloud/all-in-one#how-to-add-php-extensions-permanently-to-the-nextcloud-container
      # NEXTCLOUD_ENABLE_DRI_DEVICE: true # This allows to enable the /dev/dri device in the Nextcloud container. ⚠️⚠️⚠️ Warning: this only works if the '/dev/dri' device is present on the host! If it should not exist on your host, don't set this to true as otherwise the Nextcloud container will fail to start! See https://github.com/nextcloud/all-in-one#how-to-enable-hardware-transcoding-for-nextcloud
      # NEXTCLOUD_KEEP_DISABLED_APPS: false # Setting this to true will keep Nextcloud apps that are disabled in the AIO interface and not uninstall them if they should be installed. See https://github.com/nextcloud/all-in-one#how-to-keep-disabled-apps
      # TALK_PORT: 3478 # This allows to adjust the port that the talk container is using. See https://github.com/nextcloud/all-in-one#how-to-adjust-the-talk-port
      WATCHTOWER_DOCKER_SOCKET_PATH: /var/run/docker.sock # Needs to be specified if the docker socket on the host is not located in the default '/var/run/docker.sock'. Otherwise mastercontainer updates will fail. For macos it needs to be '/var/run/docker.sock'

volumes: # If you want to store the data on a different drive, see https://github.com/nextcloud/all-in-one#how-to-store-the-filesinstallation-on-a-separate-drive
  nextcloud_aio_mastercontainer:
    name: nextcloud_aio_mastercontainer # This line is not allowed to be changed as otherwise the built-in backup solution will not work

# Optional: If you need ipv6, follow step 1 and 2 of https://github.com/nextcloud/all-in-one/blob/main/docker-ipv6-support.md first and then uncomment the below config in order to activate ipv6 for the internal nextcloud-aio network.
# Please make sure to uncomment also the networking lines of the mastercontainer above in order to actually create the network with docker-compose
networks:
  nextcloud-aio:
    name: nextcloud-aio # This line is not allowed to be changed as otherwise the created network will not be used by the other containers of AIO
    driver: bridge
    enable_ipv6: false
    ipam:
      driver: default
      # config:
      #   - subnet: fd12:3456:789a:2::/64 # IPv6 subnet to use

```

```sh
docker compose up -d
```

Go to https://docker-ip:8080/, save the passphrase, follow the instructions. After the installation, save the admin initial password.
