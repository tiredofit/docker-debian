FROM debian:buster
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Set defaults
ARG S6_OVERLAY_VERSION=v2.2.0.3
ARG ZABBIX_VERSION

ENV ZABBIX_VERSION=${ZABBIX_VERSION:-"5.4.0"} \
    DEBUG_MODE=FALSE \
    TIMEZONE=Etc/GMT \
    DEBIAN_FRONTEND=noninteractive \
    ENABLE_CRON=TRUE \
    ENABLE_SMTP=TRUE \
    ENABLE_ZABBIX=TRUE \
    ZABBIX_HOSTNAME=debian

RUN set -ex && \
    if [ $(cat /etc/os-release |grep "VERSION=" | awk 'NR>1{print $1}' RS='(' FS=')') != "jessie" ] ; then zstd=zstd; fi ; \
    apt-get update && \
    apt-get upgrade -y && \
    ZABBIX_BUILD_DEPS=' \
                    autoconf \
                    automake \
                    autotools-dev\
                    build-essential \
                    pkg-config \
                    libpcre3-dev \
                    libssl-dev \
                    ' && \
    apt-get install -y --no-install-recommends \
                    apt-transport-https \
                    apt-utils \
                    aptitude \
                    bash \
                    ca-certificates \
                    curl \
                    dirmngr \
                    dos2unix \
                    gnupg \
                    less \
                    logrotate \
                    msmtp \
                    nano \
                    net-tools \
                    netcat-openbsd \
                    procps \
                    sudo \
                    tzdata \
                    vim-tiny \
                    ${zstd} \
                    ${ZABBIX_BUILD_DEPS} \
                    && \
    \
    rm -rf /etc/timezone && \
    ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    ## Zabbix Agent Install
    addgroup --gid 10050 zabbix && \
    adduser --uid 10050 \
            --gid 10050 \
            --gecos "Zabbix Agent" \
            --home /dev/null \
            --no-create-home \
            --shell /sbin/nologin \
            --disabled-login \
            --disabled-password \
            zabbix \
            && \
    mkdir -p /etc/zabbix && \
    mkdir -p /etc/zabbix/zabbix_agentd.d && \
    mkdir -p /var/lib/zabbix && \
    mkdir -p /var/lib/zabbix/enc && \
    mkdir -p /var/lib/zabbix/modules && \
    chown --quiet -R zabbix:root /var/lib/zabbix && \
    rm -rf /etc/zabbix/zabbix-agentd.conf.d/* && \
    mkdir -p /usr/src/zabbix && \
    curl -sSLk https://github.com/zabbix/zabbix/archive/${ZABBIX_VERSION}.tar.gz | tar xfz - --strip 1 -C /usr/src/zabbix && \
    cd /usr/src/zabbix && \
    sed -i "s|{ZABBIX_REVISION}|${ZABBIX_VERSION}|g" include/version.h && \
    ./bootstrap.sh 1>/dev/null && \
    export CFLAGS="-fPIC -pie -Wl,-z,relro -Wl,-z,now" && \
    ./configure \
            --prefix=/usr \
            --silent \
            --sysconfdir=/etc/zabbix \
            --libdir=/usr/lib/zabbix \
            --datadir=/usr/lib \
            --enable-agent \
            --enable-ipv6 \
            --with-openssl && \
    make -j"$(nproc)" -s 1>/dev/null && \
    cp src/zabbix_agent/zabbix_agentd /usr/sbin/zabbix_agentd && \
    cp src/zabbix_sender/zabbix_sender /usr/sbin/zabbix_sender && \
    cp conf/zabbix_agentd.conf /etc/zabbix && \
    mkdir -p /etc/zabbix/zabbix_agentd.conf.d && \
    mkdir -p /var/log/zabbix && \
    chown -R zabbix:root /var/log/zabbix && \
    chown --quiet -R zabbix:root /etc/zabbix && \
    rm -rf /usr/src/zabbix && \
    echo '%zabbix ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    \
    ### S6 installation
    debArch=$(dpkg --print-architecture) && \
    case "$debArch" in \
        amd64) s6Arch='amd64' ;; \
        armel) s6Arch='arm' ;; \
        armhf) s6Arch='armhf' ;; \
		arm64) s6Arch='aarch64' ;; \
		ppc64le) s6Arch='ppc64le' ;; \
		*) echo >&2 "Error: unsupported architecture ($debArch)"; exit 1 ;; \
	esac; \
    curl -sSLk https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-${s6Arch}.tar.gz | tar xfz - --strip 0 -C / && \
    \
    ### Cleanup
    mkdir -p /assets/cron && \
    apt-get purge -y ${ZABBIX_BUILD_DEPS} && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /root/.gnupg /var/log/* /etc/logrotate.d

### Networking configuration
EXPOSE 10050/TCP

### Add folders
ADD install /

### Entrypoint configuration
ENTRYPOINT ["/init"]
