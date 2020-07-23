## Aria2

aria2 is a lightweight multi-protocol & multi-source command-line download utility. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink. aria2 can be manipulated via built-in JSON-RPC and XML-RPC interfaces.


Download multiple files (16) at once:
```bash
aria2c -j 16 -i uris.txt
```

The `uris.txt` file:
```text
http://image1.png
  out=01.png
http://image2.png
  out=02.png
http://image3.png
  out=03.png

```

Download a ISO image using 6 concurrent connections, each server with 3 connections:
```bash
aria2c \
-s 6 \
-x 3 \
https://releases.ubuntu.com/20.04/ubuntu-20.04-desktop-amd64.iso \
https://mirror.math.princeton.edu/pub/ubuntu-iso/20.04/ubuntu-20.04-desktop-amd64.iso
```

Other options
```text
-j, --max-concurrent-downloads=<N> - maximum number of parallel downloads for every queue item
-s, --split=<N> - Download a file using N connections
-x, --max-connection-per-server
--console-log-level=info 
```

* [Site](https://aria2.github.io/)
* [Man](https://aria2.github.io/manual/en/html/aria2c.html)
* [Brew](https://formulae.brew.sh/formula/aria2)
* [SO](https://stackoverflow.com/a/24444698/218418)