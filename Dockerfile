FROM ubuntu:20.04

LABEL maintainer="m3chd09 <m3chd09@protonmail.com>"

ARG SSMGRVER=0.38.10
ARG SSVER=v1.12.4
ARG V2VER=v1.4.1
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install curl wget git sudo -y && \
    curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt install -y nodejs shadowsocks-libev && \
    npm i -g shadowsocks-manager@${SSMGRVER} --unsafe-perm && \
    ss_file="shadowsocks-${SSVER}.x86_64-unknown-linux-gnu.tar.xz" && \
    v2_file="v2ray-plugin-linux-amd64-${V2VER}.tar.gz" && \
    ss_url="https://github.com/shadowsocks/shadowsocks-rust/releases/download/${SSVER}/${ss_file}" && \
    v2_url="https://github.com/M3chD09/v2ray-plugin/releases/download/${V2VER}/${v2_file}" && \
    wget $ss_url && \
    tar -C /usr/bin/ -xf $ss_file && \
    wget $v2_url && \
    tar xf $v2_file && \
    mv v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin && \
    rm -f $ss_file $v2_file && \
    rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/ssmgr"]
