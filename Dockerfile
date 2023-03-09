# BASE

FROM node:18-bullseye as node-base

RUN npm i -g pnpm

# DEPENDENCIES

FROM node-base as node-dependencies

WORKDIR /app
ENV NODE_ENV=production
COPY package.json pnpm-lock.yaml ./
RUN pnpm install

# BUILD

FROM node-base as node-build

WORKDIR /app
ENV NODE_ENV=production
COPY . .
COPY --from=node-dependencies /app/node_modules ./node_modules
RUN pnpm build
RUN pnpm prune --prod

# DEPLOY

FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=node-build /app/dist /srv