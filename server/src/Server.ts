import http, { RequestListener, ServerOptions } from 'http';

export class Server extends http.Server {
    constructor(requestListener?: RequestListener);
    constructor(options: ServerOptions, requestListener?: RequestListener);
    constructor(a?: any, b?: any) {
        super(a, b);
    }

    async start(port: number) {
        return new Promise<void>((resolve, reject) => {
            this.on('error', reject);
            this.on('listening', resolve)
            this.listen(port);
        });
    }

    async stop() {
        await new Promise<void>((resolve, reject) => {
            this.close(error => {
                if (error) {
                    reject(error);
                } else {
                    resolve();
                }
            });
        });
    }
}
