FROM docker:24-dind
# Instalar herramientas necesarias
RUN apk add --no-cache \
    git \
    curl \
    bash \
    jq \
    docker-cli-buildx \
    && curl -fsSL https://cli.github.com/packages/alpine/gh-2.44.0.apk -o /tmp/gh.apk \
    && apk add --allow-untrusted /tmp/gh.apk \
    && rm /tmp/gh.apk

# Configurar Docker para ejecutarse con buildx por defecto
RUN docker buildx install

# Configurar entrada del contenedor
CMD ["dockerd-entrypoint.sh"]
