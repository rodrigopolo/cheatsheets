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

function logWithTimestamp(logFn, message) {
	const timestamp = new Date().toISOString();
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