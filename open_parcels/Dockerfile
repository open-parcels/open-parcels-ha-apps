# Builds Open Parcels from a pinned commit of github.com/open-parcels/open-parcels like the
# project's own image, minus tini (Home Assistant's init takes its place), the non-root user, the
# HEALTHCHECK (the app's watchdog takes its place) and Tailscale (Home Assistant has its own app).
# The base image is pinned by digest; bump it together with OPENPARCELS_REF.
ARG NODE_IMAGE=node:26.13.1-slim@sha256:abe7e5a82b61a8ef67b315b85497c9e65173387ccf2f4a029248184b8e020be5
ARG OPENPARCELS_REF=98694fe28d1d43a8a4e921f0862c7cbadae2f1e4

FROM ${NODE_IMAGE} AS build
ARG OPENPARCELS_REF
# A failed download must fail the build, not hand tar an empty stream. The archive is not
# checksummed: GitHub does not promise byte-identical archives, and the commit SHA pins the content.
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
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

FROM ${NODE_IMAGE}
WORKDIR /app
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/server/package.json ./server/package.json
COPY --from=build /app/server/dist ./server/dist
COPY --from=build /app/web/dist ./web/dist

# The server reads the app's options itself when Home Assistant's Supervisor starts it (supervised
# mode). The data folder stays /data/open-parcels, where earlier versions kept it. The server
# hard-codes the ingress port 8099 as well (APP_INGRESS_PORT); keep it equal to config.yaml.
ENV NODE_ENV=production \
    OPENPARCELS_PORT=3000 \
    OPENPARCELS_INGRESS_PORT=8099 \
    OPENPARCELS_DATA_DIR=/data/open-parcels

CMD ["node", "/app/server/dist/main.js"]
