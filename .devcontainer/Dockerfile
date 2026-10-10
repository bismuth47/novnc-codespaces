FROM mcr.microsoft.com/devcontainers/base:ubuntu

# 注意: Ubuntu 22.04+ の標準aptの firefox はsnapスタブであり、
# コンテナ内(snapdなし)では起動できない。そのため Mozilla公式PPA の .deb版を使う。
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common \
    && add-apt-repository -y ppa:mozillateam/ppa \
    && printf 'Package: *\nPin: release o=LP-PPA-mozillateam\nPin-Priority: 1001\n' \
        > /etc/apt/preferences.d/mozilla-firefox \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        firefox \
        menu-xdg \
        xdg-utils \
    && rm -rf /var/lib/apt/lists/*
