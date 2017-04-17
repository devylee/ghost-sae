FROM node:4-slim

ENV GHOST_SOURCE=/var/www/ghost GHOST_CONTENT=/var/storage/ghost NODE_ENV=production GOSU_VERSION=1.10 GHOST_VERSION=0.11.7

VOLUME $GHOST_CONTENT

RUN set -x \
    && apt-get update \
    && apt-get install -y curl unzip rsync ca-certificates --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && curl -L "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)"  -o /usr/local/bin/gosu \
    && curl -L "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" -o /usr/local/bin/gosu.asc \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
    && mkdir -p "$GHOST_SOURCE" \
    && curl -L "https://github.com/TryGhost/Ghost/releases/download/$GHOST_VERSION/Ghost-$GHOST_VERSION.zip" -o /var/www/ghost.zip \
    && unzip -uo /var/www/ghost.zip -d "$GHOST_SOURCE" \
    && rm -f /var/www/ghost.zip \
    && cd "$GHOST_SOURCE" \
    && npm install -g npm@latest \
    && npm install --production \
    && npm cache clean \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false curl unzip ca-certificates \
    && rm -rf /tmp/* \
    && groupadd ghost \
    && useradd --create-home --home-dir /home/ghost -g ghost ghost \
    && chown -R ghost:ghost "$GHOST_CONTENT"

WORKDIR $GHOST_SOURCE

COPY ghost-config.js "$GHOST_SOURCE/config.js"

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["npm", "start"]
