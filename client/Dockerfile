FROM node:latest AS builder

COPY package.json package-lock.json tsconfig.json webpack.config.js /

RUN npm ci

COPY ./src /src

RUN npm run build



FROM nginx:latest

COPY --from=builder /build /usr/share/nginx/html
