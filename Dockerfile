FROM moby/buildkit:latest
# Instalar herramientas necesarias
RUN apk add --no-cache \
    git \
    curl \
    bash \
    jq \
    docker-cli-buildx

# Descargar e instalar gh CLI de manera separada
RUN curl -fsSL https://github.com/cli/cli/releases/download/v2.44.0/gh_2.44.0_linux_amd64.tar.gz -o /tmp/gh.tar.gz \
    && tar -xzf /tmp/gh.tar.gz -C /tmp \
    && mv /tmp/gh_2.44.0_linux_amd64/bin/gh /usr/local/bin/gh \
    && rm -rf /tmp/gh.tar.gz /tmp/gh_2.44.0_linux_amd64

# Configurar Docker para ejecutarse con buildx por defecto
RUN docker buildx install

# Configurar entrada del contenedor
CMD ["dockerd-entrypoint.sh"]
