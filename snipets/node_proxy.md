# Node Proxy

Create app path and install dependencies
```sh
mkdir ~/.apps/proxy && cd ~/.apps/proxy
npm install http http-proxy
```

Generate Private Key, generate Certificate Signing Request (CSR) following the prompts, and generate Self-Signed Certificate
```sh
openssl genpkey -algorithm RSA -out private-key.pem
openssl req -new -key private-key.pem -out csr.pem
openssl x509 -req -days 365 -in csr.pem -signkey private-key.pem -out certificate.pem
rm csr.pem
```

Create `proxy.js`
```sh
nano proxy.js
```

```js
#!/usr/bin/env node

// Insecure port
const PORT = 80;

// SSL port
const HTTPS_PORT = 443;

const proxyTable = {
	'test.com': 'http://192.168.1.10:8888',
	'www.test.com': 'http://192.168.1.10:8888',
	'example.com': 'http://127.0.0.1:3000',
	'www.example.com': 'http://127.0.0.1:3000',
	// Add more entries as needed
};

const http = require('http');
const https = require('https');
const httpProxy = require('http-proxy');
const fs = require('fs');

const httpProxyServer = httpProxy.createProxyServer({});

const httpServer = http.createServer((req, res) => {
	handleRequest(req, res);
});

const httpsServer = https.createServer({
	key: fs.readFileSync(__dirname+'/private-key.pem'), // Replace with your private key path
	cert: fs.readFileSync(__dirname+'/certificate.pem'), // Replace with your certificate path
}, (req, res) => {
	handleRequest(req, res);
});

function handleRequest(req, res) {
	const host = req.headers.host;

	if (proxyTable.hasOwnProperty(host)) {
		const target = proxyTable[host];
		httpProxyServer.web(req, res, { target });
	} else {
		res.writeHead(404, { 'Content-Type': 'text/plain' });
		res.end('Not Found');
	}
}

httpServer.listen(PORT, () => {
	console.log(`HTTP Proxy server is listening on port ${PORT}`);
});

httpsServer.listen(HTTPS_PORT, () => {
	console.log(`HTTPS Proxy server is listening on port ${HTTPS_PORT}`);
});

```

Set permissions
```sh
chmod +x proxy.js
```

Check if it works
```sh
sudo node proxy.js
```

## Daemonizing the script (keep it running in background)

Remove authentication for the script in qustion
```sh
sudo visudo
```

Go to the last line, press `i` to enter insert mode, paste the following line replacing `USER` with your username
```
# Allow USER to run Node.js proxy script without a password
USER ALL=(ALL) NOPASSWD: /opt/homebrew/bin/node /Users/USER/.apps/proxy/proxy.js

```

After inserting the line, press `Esc` to return to normal mode. Save the changes and exit by typeing `:wq` and press `Enter`, alternatively, you can use `ZZ` (press `Shift` + `zz`) to save and exit.

Create `com.yourcompany.proxy.plist` and replace `USER` with your user
```sh
nano ~/Library/LaunchAgents/com.yourcompany.proxy.plist
```

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.yourcompany.proxy</string>
	<key>ProgramArguments</key>
	<array>
		<string>/opt/homebrew/bin/node</string>
		<string>/Users/USER/.apps/proxy/proxy.js</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
	<key>KeepAlive</key>
	<true/>
	<key>StandardOutPath</key>
	<string>/Users/USER/.apps/proxy/proxy.log</string>
	<key>StandardErrorPath</key>
	<string>/Users/USER/.apps/proxy/proxy_error.log</string>
	<key>UserName</key>
	<string>USER</string>
	<key>GroupName</key>
	<string>admin</string>
	<key>Sockets</key>
	<dict>
		<key>Listeners</key>
		<dict>
			<key>SockServiceName</key>
			<string>http</string>
			<key>SockType</key>
			<string>stream</string>
			<key>SockFamily</key>
			<string>IPv4</string>
		</dict>
		<key>Bonjour</key>
		<true/>
	</dict>
</dict>
</plist>

```

Load the Launch Agent to start the service
```sh
launchctl load ~/Library/LaunchAgents/com.yourcompany.proxy.plist
```

Unloading the Launch Agent to stop the service
```sh
launchctl unload ~/Library/LaunchAgents/com.yourcompany.proxy.plist
```

To list the service
```sh
launchctl list | grep -i com.yourcompany.proxy
```
