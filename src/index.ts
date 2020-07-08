import http from 'http';

async function listen(server: http.Server, port: number) {
    return new Promise((resolve, reject) => {
        server.on('error', reject);
        server.on('listening', resolve)
        server.listen(port);
    });
}

(async () => {
    try {
        const server = http.createServer((_req, res) => {
            res.write('Server is running');
            res.end();
        });
        await listen(server, 8080);
        console.log('listening to port 8080');
    }
    catch(e) {
        console.error(e);
    }
})();
