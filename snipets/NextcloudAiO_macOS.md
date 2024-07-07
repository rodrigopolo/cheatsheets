# Nextcloud All-in-One in macOS

For this setup to work you need:
. A public ip
. A fully qualified domain name (FQDN) pointing to the public ip
. Your ports `80` and `443` open in your router
. Nginx Proxy Manager already running behind the router
. Docker Desktop installed and running

The following script is based in the official [all-in-one/compose.yaml](https://github.com/nextcloud/all-in-one/blob/main/compose.yaml).

## Setup

Create a directory, and inside, create the following `compose.yml` file:
```yaml
services:
  nextcloud-aio-mastercontainer:
    image: nextcloud/all-in-one:latest
    init: true
    restart: always
    container_name: nextcloud-aio-mastercontainer # This line is not allowed to be changed
    volumes:
      - nextcloud_aio_mastercontainer:/mnt/docker-aio-config # This line is not allowed to be changed
      - /var/run/docker.sock.raw:/var/run/docker.sock:ro # May be changed on macOS
    ports:
      - 8080:8080
    environment:
      APACHE_PORT: 11000 # Is needed when running behind a web server or reverse proxy (like Apache, Nginx, Cloudflare Tunnel and else). See https://github.com/nextcloud/all-in-one/blob/main/reverse-proxy.md
      APACHE_IP_BINDING: 0.0.0.0 # Should be set when running behind a web server or reverse proxy (like Apache, Nginx, Cloudflare Tunnel and else) that is running on the same host. See https://github.com/nextcloud/all-in-one/blob/main/reverse-proxy.md
      # NEXTCLOUD_DATADIR: /mnt/ncdata # Allows to set the host directory for Nextcloud's datadir. ⚠️⚠️⚠️ Warning: do not set or adjust this value after the initial Nextcloud installation is done! See https://github.com/nextcloud/all-in-one#how-to-change-the-default-location-of-nextclouds-datadir
      # NEXTCLOUD_MOUNT: /mnt/ # Allows the Nextcloud container to access the chosen directory on the host. See https://github.com/nextcloud/all-in-one#how-to-allow-the-nextcloud-container-to-access-directories-on-the-host
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

Feel free to set your script as you want, notice that the `APACHE_IP_BINDING: 0.0.0.0` allow the Nginx Proxy Manager access Nextcloud ip address.

After editing and saving the file, on the terminal run inside the directory containing the `compose.yml` file:
```sh
docker-compose up -d
```

Proceed to the web installation in: https://localhost:8080, ignore the `NET::ERR_CERT_AUTHORITY_INVALID` warnings.

You'll be received with a page that says *"Nextcloud AIO Login"* *"Log in using your Nextcloud AIO passphrase:"*, no worries, to get the passphrase just run this in the macOS Terminal:

```sh
sudo docker exec nextcloud-aio-mastercontainer grep password /mnt/docker-aio-config/data/configuration.json
```

Once logged in, you'll see a page titled *Nextcloud AIO v9.1.0* where you can create your *New AIO instance*, but first, make sure to have your Nginx Proxy Manager configured as it is shown here:
https://github.com/nextcloud/all-in-one/blob/main/reverse-proxy.md#nginx-proxy-manager

> **APACHE_IP_BINDING: 0.0.0.0** allows Nginx Proxy Manager reach the NextCloud domain check.

Once the domain is validated, select your *Optional containers* and time-zone; set your time-zone save, download, and start the containers, it will take some minutes.

> Special thanks to the expert [Willi Weikum](https://help.nextcloud.com/u/wwe/summary) for all the help provided for this guide.
