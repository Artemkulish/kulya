const fs = require('fs');
const http = require('http');
const https = require('https');

const HTTP = process.env.HTTP;
const HTTPS = process.env.HTTPS;
const HOST = process.env.HOST;

const httpsOptions = {
   cert: fs.readFileSync('/etc/ssl/nodejs.crt'),
   ca: fs.readFileSync('/etc/ssl/nodejs.ca-bundle'),
   key: fs.readFileSync('/etc/ssl/nodejs.key')
};

const httpServer = http.createServer((req, res) => {
    console.log(`Request from [${req.method}]:${req.url}`);
    if(req.url === "/err"){
        return;
    }

    res.statusCode = 200;
    res.write(`Welcome to the following URL: ${req.url}`);
    res.end();
});

const httpsServer = https.createServer(httpsOptions, (req, res) => {
    console.log(`Request from [${req.method}]:${req.url}`);
    if(req.url === "/err"){
        return;
    }

    res.statusCode = 200;
    res.write(`Welcome to the following URL: ${req.url}`);
    res.end();
});

httpServer.listen(HTTP, HOST, () => {
    console.log(`Server listen on ${HOST}:${HTTP}`);
});

httpsServer.listen(HTTPS, HOST, () => {
    console.log(`Server listen on ${HOST}:${HTTPS}`);
});

