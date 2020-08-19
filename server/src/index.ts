import { exit, run } from './Runner';
import { Server } from './Server';

(async () => {
    try {
        const server = new Server((req, res) => {
            res.write('Server is running');
            res.end();
        });
        await server.start(8080);
        console.log('listening to port 8080');
        await run();
        await server.stop();
        console.log('stopping server');
    }
    catch (e) {
        console.error(e);
    }
    finally {
        exit();
    }
})();
