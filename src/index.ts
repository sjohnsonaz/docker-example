import http from 'http';

async function listen(server: http.Server, port: number) {
    return new Promise((resolve, reject) => {
        server.on('error', reject);
        server.on('listening', resolve)
        server.listen(port);
    });
}

async function shutdown(server: http.Server) {
    await new Promise((resolve, reject) => {
        server.close(error => {
            if (error) {
                reject(error);
            } else {
                resolve();
            }
        });
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
        process.on('SIGINT', async () => {
            console.log('Server is stopping');
            try {
                await shutdown(server);
            }
            catch (e) {
                console.error(e);
            }
            finally {
                console.log('Closing');
                process.exit();
            }
        });
    }
    catch (e) {
        console.error(e);
    }
})();
