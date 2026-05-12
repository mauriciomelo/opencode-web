FROM node:22-bookworm-slim

ARG OPENCODE_VERSION=1.14.48

ENV NODE_ENV=production \
  OPENCODE_DISABLE_AUTOUPDATE=true \
  OPENCODE_HOSTNAME=0.0.0.0 \
  OPENCODE_PORT=8080 \
  XDG_CONFIG_HOME=/home/node/.config \
  XDG_DATA_HOME=/home/node/.local/share

# bash: shell compatibility for scripts and spawned commands.
# ca-certificates: trusted TLS roots for npm, git, and API calls.
# git: repository operations used by OpenCode.
# openssh-client: SSH transport for git remotes.
# poppler-utils: PDF utilities such as `pdftotext`, `pdfinfo`, and `pdfimages`.
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  bash \
  ca-certificates \
  git \
  openssh-client \
  poppler-utils \
  && rm -rf /var/lib/apt/lists/*

RUN npm install --global "opencode-ai@${OPENCODE_VERSION}" \
  && npm cache clean --force

COPY opencode-entrypoint.sh /usr/local/bin/opencode-entrypoint
RUN chmod +x /usr/local/bin/opencode-entrypoint

RUN mkdir -p /home/node/workspace /home/node/.config/opencode /home/node/.local/share/opencode \
  && chown -R node:node /home/node/workspace /home/node/.config /home/node/.local

USER node

EXPOSE 8080

WORKDIR /home/node/workspace

ENTRYPOINT ["/usr/local/bin/opencode-entrypoint"]
