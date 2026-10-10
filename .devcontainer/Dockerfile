FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Firefoxをaptで導入 (UbuntuのChromiumはsnap必須でCodespacesに不向きなためFirefox優先)
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        firefox \
        menu-xdg \
        xdg-utils \
    && rm -rf /var/lib/apt/lists/*
