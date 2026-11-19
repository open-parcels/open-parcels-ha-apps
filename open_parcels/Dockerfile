# Builds Open Parcels from a pinned commit of github.com/open-parcels/open-parcels, the same way
# the project's own image is built, for the architecture Home Assistant runs on.
ARG NODE_VERSION=26
ARG OPENPARCELS_REF=af09814c448d3e900ff0db7958f6dba6d16b3fb8

FROM node:${NODE_VERSION}-slim AS build
ARG OPENPARCELS_REF
# Compilers for native modules without a prebuilt binary for this architecture.
RUN apt-get update \
 && apt-get install --no-install-recommends -y python3 make g++ ca-certificates curl \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN curl -fsSL "https://github.com/open-parcels/open-parcels/archive/${OPENPARCELS_REF}.tar.gz" \
    | tar -xz --strip-components=1
RUN npm ci --workspace server --workspace web --include-workspace-root \
 && npm run build --workspace server \
 && npm run build --workspace web \
 && rm -rf node_modules server/node_modules \
 && npm ci --workspace server --omit=dev

FROM node:${NODE_VERSION}-slim
WORKDIR /app
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/server/package.json ./server/package.json
COPY --from=build /app/server/dist ./server/dist
COPY --from=build /app/web/dist ./web/dist
COPY run.sh /run.sh
RUN chmod 755 /run.sh

ENV NODE_ENV=production \
    OPENPARCELS_PORT=3000 \
    OPENPARCELS_INGRESS_PORT=8099

CMD ["/run.sh"]
