FROM node:18.20.1-alpine3.18 AS build

RUN addgroup -g 1001 -S nodegroup && \
    adduser -S nodeuser -u 1001 -G nodegroup

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

COPY . .

RUN chown -R nodeuser:nodegroup /app


FROM gcr.io/distroless/nodejs:18


USER nonroot

WORKDIR /app

COPY --from=build /app /app

EXPOSE 3000

CMD ["server.js"]  # Remplace par ton fichier d'entrée si ce n'est pas server.js
