# syntax=docker/dockerfile:1
FROM node:16-alpine as base

WORKDIR /app
RUN corepack enable

COPY .npmrc package.json pnpm-lock.yaml ./
RUN --mount=type=cache,id=pnpm-store,target=/root/.pnpm-store \
    pnpm install --frozen-lockfile
COPY . .

FROM base as test
RUN pnpm run test

# FROM base as prod
CMD [ "node", "server.js" ]
