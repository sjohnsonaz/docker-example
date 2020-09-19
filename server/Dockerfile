# --- Dev 0 ---
FROM node:latest AS dev-0

WORKDIR /app/server

COPY package.json package-lock.json ./

RUN npm ci


# --- Prod 0 ---
FROM node:latest AS prod-0

WORKDIR /app/server

COPY package.json package-lock.json ./

RUN npm ci --only=production


# --- Dev ---
FROM dev-0 AS dev

COPY tsconfig.json ./
COPY ./src ./src

CMD npm run watch


# --- Prod 1 ---
FROM dev AS prod-1

RUN npm run build


# --- Prod ---
FROM node:latest AS prod

EXPOSE 8080
WORKDIR /app/server

COPY --from=prod-1 /app/server/node_modules ./node_modules
COPY --from=prod-1 /app/server/dist ./dist
COPY --from=prod-1 /app/server/src ./src

CMD ["node", "./dist/index.js"]
