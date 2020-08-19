# Docker Example

## Build Server

``` bash
mkdir server
cd server
```

``` bash
npm init
tsc init
```

Modify `tsconfig.json`.

``` bash
npm install typescript @types/node ts-watch
```

## Build Client

``` bash
mkdir client
cd client
```

``` bash
npm init
tsc init
```

Modify `tsconfig.json`.

``` bash
npm install typescript @types/node ts-watch
```

## Docker Compose Commands
| Action  | Command                         |
| ------- | ------------------------------- |
| Build   | `docker-compose up`             |
| Start   | `docker-compose start`          |
| Stop    | `docker-compose stop`           |
| Destroy | `docker-compose down`           |
| Clean   | `docker-compose down --rmi all` |
