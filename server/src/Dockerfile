FROM node:slim

COPY . /

RUN npm install && npm run build

EXPOSE 8080

CMD ["node", "./dist/index.js"]