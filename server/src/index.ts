import { exit, run } from './Runner';
import { Server } from './Server';

(async () => {
    try {
        const server = new Server((_req, res) => {
            const data = { value: 'Server is running' };
            res.setHeader('Content-Type', 'application/json');
            res.write(JSON.stringify(data));
            res.end();
        });

        await server.start(8080);
        console.log('listening to port 8080');

        await run();
        console.log('stopping...');

        await server.stop();
        console.log('stopped');
    }
    catch (e) {
        console.error(e);
    }
    finally {
        exit();
    }
})();
