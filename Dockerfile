FROM node:24-alpine AS builder

# Install pnpm
RUN npm install -g pnpm

WORKDIR /app
COPY . .
RUN pnpm install
RUN pnpm run build

FROM node:24-alpine AS production

# Install pnpm
RUN npm install -g pnpm

ARG NODE_ENV=production
RUN addgroup -S docker && adduser -S user -G docker

WORKDIR /app

COPY --from=builder --chown=user:docker /app/package.json ./
COPY --from=builder --chown=user:docker /app/pnpm-lock.yaml ./
COPY --from=builder --chown=user:docker /app/dist ./dist
RUN pnpm install --frozen-lockfile --prod && pnpm store prune

USER user

ENTRYPOINT ["node"]
CMD ["dist/index.js"]