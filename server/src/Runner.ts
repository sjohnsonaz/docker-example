import process from 'process';

export function run() {
    return new Promise(resolve => {
        process.on('SIGINT', () => {
            resolve();
        });
        process.on('SIGTERM', () => {
            resolve();
        });
    });
}

export function exit(code?: number) {
    process.exit(code);
}