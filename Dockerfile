# ---------------------------------------------------------
# Stage 1: Download the latest uNmINeD CLI (self-contained)
# ---------------------------------------------------------
FROM debian:bookworm-slim AS downloader

RUN apt-get update \
  && apt-get install -y --no-install-recommends curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN curl -sSL "https://unmined.net/download/unmined-cli-linux-x64-dev/" \
  | tar -xz \
  && mv unmined-cli* /opt/unmined-cli

# ---------------------------------------------------------
# Stage 2: Minimal runtime image
# ---------------------------------------------------------
FROM debian:bookworm-slim

LABEL org.opencontainers.image.source="https://github.com/molnia1311/unmined-cli"
LABEL org.opencontainers.image.description="uNmINeD CLI - Minecraft and Hytale map renderer"
LABEL org.opencontainers.image.licenses="Proprietary"

# Install minimal runtime dependencies for .NET / image rendering
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  libicu72 \
  libssl3 \
  libfontconfig1 \
  libfreetype6 \
  && rm -rf /var/lib/apt/lists/* \
  && useradd -m -s /bin/bash unmined

COPY --from=downloader --chown=unmined:unmined /opt/unmined-cli /opt/unmined-cli

USER unmined
WORKDIR /data

ENTRYPOINT ["/opt/unmined-cli/unmined-cli"]
