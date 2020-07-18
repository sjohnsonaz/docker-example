FROM node:latest AS builder
COPY . /
RUN npm run abstract

FROM nginx:latest
COPY --from=builder /bundle /usr/share/nginx/html
