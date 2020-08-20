FROM node:slim AS builder

COPY package.json package-lock.json tsconfig.json /

RUN npm install

COPY /src /src

RUN npm run build



FROM node:slim

COPY package.json package-lock.json /

RUN npm install --production

COPY --from=builder /dist /dist
COPY --from=builder /src /src

EXPOSE 8080

CMD ["node", "./dist/index.js"]
