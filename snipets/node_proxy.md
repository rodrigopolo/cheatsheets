# Node Proxy

Create app path and install dependencies
```sh
mkdir ~/.apps/proxy && cd ~/.apps/proxy
npm install http http-proxy
```

Self signed certificate: Generate Private Key, generate Certificate Signing Request (CSR) following the prompts, and generate Self-Signed Certificate
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
	// Normal
	handleRequest(req, res);

	// Redirect all HTTP requests to HTTPS
	// const host = req.headers.host;
	// res.writeHead(301, { "Location": `https://${host}${req.url}` });
	// res.end();
});

const httpsServer = https.createServer({
	key: fs.readFileSync(__dirname+'/private-key.pem'), // Replace with your private key path
	cert: fs.readFileSync(__dirname+'/certificate.pem'), // Replace with your certificate path
}, (req, res) => {
	handleRequest(req, res);
});

function logWithTimestamp(logFn, message, offsetHours) {
	if (typeof offsetHours === 'undefined') {
		offsetHours = -6; // Default offset in hours
	}
	const now = new Date();
	now.setHours(now.getHours() + offsetHours);
	const timestamp = now.toISOString();
	logFn(`[${timestamp}] ${message}`);
}

function handleRequest(req, res) {
	const host = req.headers.host;
	if (proxyTable.hasOwnProperty(host)) {
		const target = proxyTable[host];
		httpProxyServer.web(req, res, { target }, (err) => {
			if (err) {
				handleProxyError(err, res);
			}
		});
	} else {
		res.writeHead(404, { 'Content-Type': 'text/plain' });
		res.end('Not Found');
	}
}

function handleProxyError(err, res) {
	if (err.code === 'ECONNRESET') {
		logWithTimestamp(console.error, 'Connection reset by peer: ' + err.message);
	} else {
		logWithTimestamp(console.error, 'Proxy error: ' + err.message);
	}
	res.writeHead(500, { 'Content-Type': 'text/plain' });
	res.end('Server error or connection error');
}

httpProxyServer.on('error', (err, req, res) => {
	handleProxyError(err, res);
});

httpServer.on('upgrade', (req, socket, head) => {
	// Normal
	handleUpgrade(req, socket, head);

	// Redirect WebSocket upgrades to HTTPS
	// const host = req.headers.host;
	// socket.write(`HTTP/1.1 301 Moved Permanently\r\nLocation: wss://${host}${req.url}\r\n\r\n`);
	// socket.end();
});

httpsServer.on('upgrade', (req, socket, head) => {
	handleUpgrade(req, socket, head);
});

function handleUpgrade(req, socket, head) {
	const host = req.headers.host;
	if (proxyTable.hasOwnProperty(host)) {
		const target = proxyTable[host];
		httpProxyServer.ws(req, socket, head, { target }, (err) => {
			if (err) {
				logWithTimestamp(console.error, 'WebSocket proxy error: ' + err.message);
				socket.write('HTTP/1.1 500 Internal Server Error\r\n' +
							 'Content-Type: text/plain\r\n' +
							 'Connection: close\r\n' +
							 '\r\n' +
							 'Internal Server Error\r\n');
				socket.destroy();
			}
		});
	} else {
		socket.write('HTTP/1.1 404 Not Found\r\n' +
					 'Content-Type: text/plain\r\n' +
					 'Connection: close\r\n' +
					 '\r\n' +
					 'Not Found\r\n');
		socket.destroy();
	}
}

httpServer.listen(PORT, () => {
	logWithTimestamp(console.log, `HTTP Proxy server is listening on port ${PORT}`);
});

httpsServer.listen(HTTPS_PORT, () => {
	logWithTimestamp(console.log, `HTTPS Proxy server is listening on port ${HTTPS_PORT}`);
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

Create `com.yourcompany.proxy.plist`
```sh
nano sudo nano /Library/LaunchDaemons/com.yourcompany.proxy.plist
```

Edit your `USER` path, 
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
	<string>/Users/USER/.apps/proxy/output.log</string>
	<key>StandardErrorPath</key>
	<string>/Users/USER/.apps/proxy/error.log</string>
	<key>UserName</key>
	<string>root</string>
	<key>GroupName</key>
	<string>wheel</string>
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
sudo launchctl load /Library/LaunchDaemons/com.yourcompany.proxy.plist
```

Unloading the Launch Agent to stop the service
```sh
sudo launchctl unload /Library/LaunchDaemons/com.yourcompany.proxy.plist
```

To list the service
```sh
launchctl list | grep -i com.yourcompany.proxy
```

Check if any port is alredy in use
```sh
sudo lsof -i -P | grep LISTEN
```

## Let's Encrypt certificate
Creating your own SSL/HTTPS certificate with Let's Encrypt using Certbot on a macOS computer:

1. Ensure your firewall allows traffic on ports 80 (HTTP) and 443 (HTTPS).
2. Install Certbot
3. Stop your web server
4. Run Certbot to obtain the certificate, following the prompts
5. Start your web server
6. Set up automatic renewal with a cronjob

Install and run Certbot to create your certificates
```sh
brew install certbot
sudo certbot certonly --standalone -d yourdomain.com -d www.yourdomain.com
```

`Crontab.txt` for easy edition of crons
```sh
0 0,12 * * * /opt/homebrew/bin/certbot renew --quiet
```

Add/replace all cronjobs in the crontab
```sh
crontab crontab.txt
```
