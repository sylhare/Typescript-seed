FROM node:18-alpine AS builder

WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

FROM node:18-alpine AS production

ARG NODE_ENV=production
RUN addgroup -S docker && adduser -S user -G docker

WORKDIR /app

COPY --from=builder --chown=user:docker /app/package*.json ./
COPY --from=builder --chown=user:docker /app/dist ./dist
RUN npm ci --omit=dev && npm cache clean --force

USER user

ENTRYPOINT ["node"]
CMD ["dist/index.js"]