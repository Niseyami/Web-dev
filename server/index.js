http = require("http");
fs = require("fs");
url = require("url");

function requestHandler(req, res) {
    const request = url.parse(req.url, true);
    const path = request.path.toLowerCase().endsWith("/") ? request.path.toLowerCase().slice(0, -1) : request.path.toLowerCase();

    if (path == "/" || path == "") {
        fs.readFile(`../www/index.html`, (err, data) => {
            if (!err) {
                res.writeHead(200, { "Context-Type": "text/html" });
                res.write(data);
                res.end();
            }
        });
    }

    else if (fs.existsSync(`../www/${path}`)) {
        let filepath;
        if (fs.lstatSync(`../www/${path}`).isDirectory()) {
            filepath = `../www/${path}/index.html`;
        }
        else {
            filepath = `../www/${path}`;
        }
        fs.readFile(filepath, (err, data) => {
            if (!err) {
                res.writeHead(200, { "Context-Type": "text/html" });
                res.write(data);
                res.end();
            }
        });
    }

    else {
        fs.readFile("../www/404.html", (err, data) => {
            if (!err) {
                res.writeHead(404, { "Context-Type": "text/html" });
                res.write(data);
                res.end();
            }
        });
    }
}

http.createServer(requestHandler).listen(1337);