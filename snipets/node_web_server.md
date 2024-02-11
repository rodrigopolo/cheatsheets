# Node web server for paths

Create dir and `index.js`
```sh
mkdir webserver && cd webserver
npm install express serve-index
nano index.js
```

Paste the following code into `index.js`
```js
const port = 3000;
const folderPath = '/path/to/files/';

const express = require('express');
const serveIndex = require('serve-index');

const app = express();

app.use('/', express.static(folderPath), serveIndex(folderPath, { 'icons': true }));

app.listen(port, () => {
	console.log(`Server is running on port ${port}`);
});
```

Run the server, and notice that if it runs on port `80` it requires `sudo`
```js
node index.js
```
