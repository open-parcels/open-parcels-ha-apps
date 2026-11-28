# Builds Open Parcels from a pinned commit of github.com/open-parcels/open-parcels like the
# server's own image (esbuild bundle of the server plus only its native modules, no npm, npx or
# corepack), minus tini (Home Assistant's init takes its place), the non-root user, the HEALTHCHECK
# (the HA app's watchdog takes its place) and Tailscale (Home Assistant has its own Tailscale HA
# app, so the on-demand download of the server's entrypoint is not shipped either).
# The base image is pinned by digest; bump it together with OPENPARCELS_REF.
ARG NODE_IMAGE=node:26.13.1-slim@sha256:abe7e5a82b61a8ef67b315b85497c9e65173387ccf2f4a029248184b8e020be5
ARG OPENPARCELS_REF=ea86927168e235c4427a27f83c7bb55239665788

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
 && npm run build --workspace web
# The server and its tools as ESM bundles plus only the native modules, laid out like /app.
RUN cd server && node dist/tools/bundle.js /out \
 && cp package.json /out/server/package.json \
 && mkdir -p /out/web && cp -r /app/web/dist /out/web/dist
# The bundled layout must start: a missing native module or a misplaced file fails the build here.
RUN cd /out && node --input-type=module \
    -e "await import('sharp'); const { default: Db } = await import('better-sqlite3'); new Db(':memory:').close()" \
 && node /app/server/dist/tools/smoke.js /out/server/dist/main.js

FROM ${NODE_IMAGE}
# npm, npx, corepack and yarn are not needed at run time.
RUN rm -rf /usr/local/lib/node_modules/npm /usr/local/lib/node_modules/corepack \
    /usr/local/bin/npm /usr/local/bin/npx /usr/local/bin/corepack /opt/yarn-* \
    /usr/local/bin/yarn /usr/local/bin/yarnpkg
WORKDIR /app
COPY --from=build /out/ ./

# The server reads the HA app's options itself when Home Assistant's Supervisor starts it
# (supervised mode). The data folder stays /data/open-parcels, where earlier versions kept it. The
# server hard-codes the ingress port 8099 as well (APP_INGRESS_PORT); keep it equal to config.yaml.
ENV NODE_ENV=production \
    OPENPARCELS_PORT=3000 \
    OPENPARCELS_INGRESS_PORT=8099 \
    OPENPARCELS_DATA_DIR=/data/open-parcels

CMD ["node", "/app/server/dist/main.js"]
