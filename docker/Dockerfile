ARG UBUNTU_VER=jammy

FROM ubuntu:${UBUNTU_VER} AS prepare-builder
ARG DEBIAN_FRONTEND=noninteractive
ARG APP_USER=c6supper
ARG PASS="none"

RUN sed -i 's/ports.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list && \
    sed -i "s/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list && \
    sed -i "s/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install locales xz-utils tzdata sudo; \
    locale-gen en_US.UTF-8 && echo "dash dash/sh boolean false" | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    useradd --groups sudo -m -s /bin/bash $APP_USER && echo "$APP_USER:$PASS" | chpasswd && \
    ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime && \
    cat > /home/$APP_USER/.cargo/config <<EOF
[source.crates-io]
registry = "https://github.com/rust-lang/crates.io-index"
replace-with = 'tuna'
[source.tuna]
registry = "https://mirrors.tuna.tsinghua.edu.cn/git/crates.io-index.git"
EOF

ARG LIVENESS_PROBE

USER $APP_USER

ENV NETEASE_MUSIC_DIR /netease_music
ENV NETEASE_MUSIC_INITIALIZED_MARK $NETEASE_MUSIC_DIR/patched
COPY --chown=$APP_USER docker/version $NETEASE_MUSIC_DIR/version
COPY --chown=$APP_USER docker/docker-entrypoint.sh $NETEASE_MUSIC_DIR/docker-entrypoint.sh

# initilization for the first time
ENTRYPOINT ["/netease_music/docker-entrypoint.sh"]

CMD ["/usr/bin/bash"]