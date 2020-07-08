FROM alpine:latest

RUN apk add --update nodejs nodejs-npm

COPY ./dist /dist

RUN npm install && npm run build

EXPOSE 8080

CMD ["node", "./dist/index.js"]