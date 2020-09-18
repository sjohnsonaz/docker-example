# --- Dev ---
FROM node:latest AS dev

WORKDIR /app/client

COPY package.json package-lock.json ./

RUN npm ci

COPY tsconfig.json webpack.config.js ./
COPY ./src ./src

CMD npm start


# --- Build ---
FROM dev AS build

RUN npm run build


# --- Prod ---
FROM nginx:latest AS prod

COPY --from=build /app/client/build /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d/
