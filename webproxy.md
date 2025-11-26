# Create proxys and tunnels

## Create a ssh tunnel
```bash
ssh -D 8080 -q -C -N user@domain.com
```

## Setup mitmproxy with Firefox

### Prerequisites
* Install mitmproxy: `pip install mitmproxy`
* Install [FoxyProxy Standard](https://addons.mozilla.org/en-US/firefox/addon/foxyproxy-standard/)

### Configure FoxyProxy
1. Add new proxy in FoxyProxy:
   * Title: `mitmproxy`
   * Type: `HTTP`
   * Hostname: `127.0.0.1`
   * Port: `8080`

### Install mitmproxy Certificate (Required for HTTPS)
1. Start mitmproxy: `mitmweb --listen-port 8080`
2. Enable the mitmproxy proxy in FoxyProxy
3. Visit http://mitm.it in Firefox
4. Click the Firefox icon to download the certificate
5. Firefox should auto-prompt to trust it

To install `mitmproxy` certificate in macOS
```sh
sudo security add-trusted-cert -d -p ssl -p basic -k /Library/Keychains/System.keychain mitmproxy-ca-cert.pem
```

### Disable HTTP/2 in Firefox and enable HTTPS
1. Go to `about:config`
2. Search for `network.http.http2.enabled`
3. Toggle to `false`
4. Enable `HTTPS` in the `mitmproxy` FoxyProxy settings.
5. Restart Firefox

