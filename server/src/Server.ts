import http from 'http';

export class Server extends http.Server {
    async start(port: number) {
        return new Promise<void>((resolve, reject) => {
            const startup = () => {
                this.on('error', onError);
                this.on('listening', onListening)
            };
            const cleanup = () => {
                this.off('error', onError);
                this.off('listening', onListening);
            };
            const onError = (err: Error) => {
                reject(err);
                cleanup();
            };
            const onListening = () => {
                resolve();
                cleanup()
            };
            startup();
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
