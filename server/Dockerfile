FROM node:slim

COPY package.json package-lock.json tsconfig.json /

RUN npm install

COPY ./src /src

RUN npm run build

EXPOSE 8080

CMD ["node", "./dist/index.js"]