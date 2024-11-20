ARG DEBIAN_VERSION=bookworm

FROM docker.io/debian:${DEBIAN_VERSION}
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

ARG GOLANG_VERSION=1.22.4
ARG DOAS_VERSION
ARG FLUENTBIT_VERSION
ARG S6_OVERLAY_VERSION
ARG YQ_VERSION
ARG ZABBIX_VERSION

ENV FLUENTBIT_VERSION=${FLUENTBIT_VERSION:-"3.2.1"} \
    S6_OVERLAY_VERSION=${S6_OVERLAY_VERSION:-"3.2.0.2"} \
    YQ_VERSION=${YQ_VERSION:-"v4.44.1"} \
    ZABBIX_VERSION=${ZABBIX_VERSION:-"7.0.6"} \
    DOAS_VERSION=${DOAS_VERSION:-"v6.8.2"} \
    DEBUG_MODE=FALSE \
    TIMEZONE=Etc/GMT \
    CONTAINER_ENABLE_SCHEDULING=TRUE \
    CONTAINER_SCHEDULING_BACKEND=cron \
    CONTAINER_ENABLE_MESSAGING=TRUE \
    CONTAINER_MESSAGING_BACKEND=msmtp \
    CONTAINER_ENABLE_MONITORING=TRUE \
    CONTAINER_MONITORING_BACKEND=zabbix \
    CONTAINER_ENABLE_LOGSHIPPING=FALSE \
    DEBIAN_FRONTEND=noninteractive \
    S6_GLOBAL_PATH=/command:/usr/bin:/bin:/usr/sbin:sbin:/usr/local/bin:/usr/local/sbin \
    S6_KEEP_ENV=1 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0 \
    IMAGE_NAME="tiredofit/debian" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-debian/"

RUN debArch=$(dpkg --print-architecture) && \
    case "$debArch" in \
        amd64) fluentbit='true' ; FLUENTBIT_BUILD_DEPS="bison cmake flex libssl-dev libsasl2-dev libsystemd-dev libyaml-dev pkg-config zlib1g-dev " ;; \
		*) : ;; \
	esac; \
    set -ex && \
    apt-get update && \
    apt-get upgrade -y && \
      ZABBIX_BUILD_DEPS=' \
                    autoconf \
                    automake \
                    autotools-dev\
                    build-essential \
                    g++ \
                    pkg-config \
                    libpcre3-dev \
                    libssl-dev \
                    zlib1g-dev \
                    ' && \
    apt-get install -y --no-install-recommends \
                    apt-transport-https \
                    apt-utils \
                    acl \
                    aptitude \
                    bash \
                    busybox-static \
                    ca-certificates \
                    curl \
                    dirmngr \
                    dos2unix \
                    fail2ban \
                    gettext \
                    gnupg \
                    git \
                    inetutils-ping \
                    iptables \
                    jq \
                    less \
                    libpcre3 \
                    libyaml-0-2 \
                    logrotate \
                    msmtp \
                    nano \
                    net-tools \
                    netcat-openbsd \
                    procps \
                    sudo \
                    tzdata \
                    vim-tiny \
                    zstd \
                    ${ZABBIX_BUILD_DEPS} ${FLUENTBIT_BUILD_DEPS} \
                    && \
    \
    mv /usr/bin/envsubst /usr/local/bin && \
    rm -rf /usr/bin/crontab && \
    rm -rf /usr/sbin/cron && \
    ln -s /bin/busybox /usr/sbin/crontab && \
    ln -s /bin/busybox /usr/sbin/crond && \
    mkdir -p /usr/local/go && \
    echo "Downloading Go ${GOLANG_VERSION}..." && \
    curl -sSLk  https://dl.google.com/go/go${GOLANG_VERSION}.linux-amd64.tar.gz | tar xvfz - --strip 1 -C /usr/local/go && \
    ln -sf /usr/local/go/bin/go /usr/local/bin/ && \
    ln -sf /usr/local/go/bin/godoc /usr/local/bin/ && \
    ln -sf /usr/local/go/bin/gfmt /usr/local/bin/ && \
    \
    rm -rf /etc/timezone && \
    ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    \
    ### Build Doas
    mkdir -p /usr/src/doas && \
    curl -sSLk https://github.com/Duncaen/OpenDoas/archive/${DOAS_VERSION}.tar.gz | tar xfz - --strip 1 -C /usr/src/doas && \
    cd /usr/src/doas && \
    ./configure --prefix=/usr \
                --enable-static \
                --without-pam \
                && \
    make && \
    make install && \
    mkdir -p /etc/doas.d && \
    \
  ## yq Install
    git clone https://github.com/mikefarah/yq /usr/src/yq && \
    cd /usr/src/yq && \
    git checkout ${YQ_VERSION} && \
    go build && \
    cp -R yq /usr/local/bin && \
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
    mkdir -p /var/lib/zabbix && \
    mkdir -p /var/lib/zabbix/enc && \
    mkdir -p /var/lib/zabbix/modules && \
    mkdir -p /var/lib/zabbix/run && \
    mkdir -p /etc/zabbix/zabbix_agentd.conf.d && \
    chown --quiet -R zabbix:root /var/lib/zabbix && \
    chmod -R 770 /var/lib/zabbix/run && \
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
            --enable-agent2 \
            --enable-ipv6 \
            --with-openssl && \
    make -j"$(nproc)" -s 1>/dev/null && \
    cp src/zabbix_agent/zabbix_agentd /usr/sbin/zabbix_agentd && \
    cp src/zabbix_get/zabbix_get /usr/sbin/zabbix_get && \
    cp src/zabbix_sender/zabbix_sender /usr/sbin/zabbix_sender && \
    cp src/go/bin/zabbix_agent2 /usr/sbin/zabbix_agent2 && \
    strip /usr/sbin/zabbix_agentd && \
    strip /usr/sbin/zabbix_get && \
    strip /usr/sbin/zabbix_sender && \
    strip /usr/sbin/zabbix_agent2 && \
    mkdir -p /etc/zabbix/zabbix_agentd.conf.d && \
    mkdir -p /var/log/zabbix && \
    chown -R zabbix:root /var/log/zabbix && \
    chown --quiet -R zabbix:root /etc/zabbix && \
    rm -rf /usr/src/zabbix && \
    \
### Fluentbit compilation
    mkdir -p /usr/src/fluentbit && \
    curl -sSLk https://github.com/fluent/fluent-bit/archive/v${FLUENTBIT_VERSION}.tar.gz | tar xfz - --strip 1 -C /usr/src/fluentbit && \
    cd /usr/src/fluentbit && \
    cmake \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_INSTALL_LIBDIR=lib \
        -DCMAKE_BUILD_TYPE=None \
        -DFLB_AWS=No \
        -DFLB_BACKTRACE=No \
        -DFLB_DEBUG=No \
        -DFLB_EXAMPLES=No \
        -DFLB_FILTER_AWS=No \
        -DFLB_FILTER_KUBERNETES=No \
        -DFLB_HTTP_SERVER=Yes \
        -DFLB_IN_COLLECTD=No \
        -DFLB_IN_CPU=No \
        -DFLB_IN_DOCKER=No \
        -DFLB_IN_DOCKER_EVENTS=No \
        -DFLB_IN_KMSG=No \
        -DFLB_IN_MEM=No \
        -DFLB_IN_MQTT=No \
        -DFLB_IN_NETIF=No \
        -DFLB_IN_SERIAL=No \
        -DFLB_IN_SYSTEMD=Yes \
        -DFLB_IN_TCP=No \
        -DFLB_IN_THERMAL=No \
        -DFLB_IN_WINLOG=No \
        -DFLB_IN_WINSTAT=No \
        -DFLB_JEMALLOC=Yes \
        -DFLB_LUAJIT=No \
        -DFLB_OUT_AZURE=No \
        -DFLB_OUT_AZURE_BLOB=No \
        -DFLB_OUT_BIGQUERY=No \
        -DFLB_OUT_CALYPTIA=No \
        -DFLB_OUT_CLOUDWATCH_LOGS=No \
        -DFLB_OUT_COUNTER=No \
        -DFLB_OUT_DATADOG=No \
        -DFLB_OUT_GELF=No \
        -DFLB_OUT_INFLUXDB=No \
        -DFLB_OUT_KAFKA=No \
        -DFLB_OUT_KAFKA_REST=No \
        -DFLB_OUT_KINESIS_FIREHOSE=No \
        -DFLB_OUT_KINESIS_STREAMS=No \
        -DFLB_OUT_LOGDNA=No \
        -DFLB_OUT_NATS=No \
        -DFLB_OUT_NRLOGS=No \
        -DFLB_OUT_PGSQL=No \
        -DFLB_OUT_S3=No \
        -DFLB_OUT_SLACK=No \
        -DFLB_OUT_SPLUNK=No \
        -DFLB_OUT_STACKDRIVER=No \
        -DFLB_OUT_TCP=No \
        -DFLB_OUT_TD=No \
        -DFLB_RELEASE=Yes \
        -DFLB_SHARED_LIB=Off \
        -DFLB_SIGNV4=No \
        -DFLB_SMALL=Yes \
        . && \
    if [ "$debArch" = "amd64" ] ; then make -j"$(nproc)" ; make install ; mv /usr/etc/fluent-bit /etc/fluent-bit ; strip /usr/bin/fluent-bit ; fi ; \
    \
    ### Fail2ban Configuration
    groupadd -g 65500 fail2ban && \
#    usermod -a -G fail2ban zabbix && \
    rm -rf /var/run/fail2ban && \
    mkdir -p /var/run/fail2ban && \
#    chown -R root:fail2ban /var/run/fail2ban && \
#    setfacl -d -m g:fail2ban:rwx /var/run/fail2ban && \
    find /etc/fail2ban/action.d/ -type f -not -name 'iptables*.conf' -delete && \
    rm -rf /etc/fail2ban/filter.d && \
    mkdir -p /etc/fail2ban/filter.d && \
    rm -rf /etc/fail2ban/fail2ban.d \
           /etc/fail2ban/jail.d/* \
           /etc/fail2ban/paths* \
           && \
    \
    ### S6 installation
    debArch=$(dpkg --print-architecture) && \
    case "$debArch" in \
        amd64) s6Arch='x86_64' ;; \
        armel) s6Arch='armhf' ;; \
        armhf) s6Arch='armhf' ;; \
		arm64) s6Arch='aarch64' ;; \
		*) echo >&2 "Error: unsupported architecture ($debArch)"; exit 1 ;; \
	esac; \
    curl -sSLk https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz | tar xvpfJ - -C / && \
    curl -sSLk https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${s6Arch}.tar.xz | tar xvpfJ - -C / && \
    curl -sSLk https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-symlinks-noarch.tar.xz | tar xvpfJ - -C / && \
    curl -sSLk https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-symlinks-arch.tar.xz | tar xvpfJ - -C / && \
    mkdir -p /etc/cont-init.d && \
    mkdir -p /etc/cont-finish.d && \
    mkdir -p /etc/services.d && \
    chown -R 0755 /etc/cont-init.d && \
    chown -R 0755 /etc/cont-finish.d && \
    chmod -R 0755 /etc/services.d && \
    sed -i "s|echo|: # echo |g" /package/admin/s6-overlay/etc/s6-rc/scripts/cont-init && \
    sed -i "s|echo|: # echo |g" /package/admin/s6-overlay/etc/s6-rc/scripts/cont-finish && \
    sed -i "s|echo ' (no readiness notification)'|: # echo ' (no readiness notification)'|g" /package/admin/s6-overlay/etc/s6-rc/scripts/services-up && \
    sed -i "s|s6-echo -n|: # s6-echo -n|g" /package/admin/s6-overlay/etc/s6-rc/scripts/services-up && \
    sed -i "s|v=2|v=1|g" /package/admin/s6-overlay/etc/s6-linux-init/skel/rc.init && \
    sed -i "s|v=2|v=1|g" /package/admin/s6-overlay/etc/s6-linux-init/skel/rc.shutdown && \
    \
    ### Cleanup
    mkdir -p /assets/cron && \
    apt-get purge -y ${BUSYBOX_BUILD_DEPS} ${ZABBIX_BUILD_DEPS} ${FLUENTBIT_BUILD_DEPS} gettext && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf \
        /etc/logrotate.d/* \
        /root/.cache \
        /root/.gnupg \
        /root/go \
        /usr/local/bin/go* \
        /usr/local/go \
        /usr/share/doc/* \
        /usr/share/doc/kde/HTML/*/* \
        /usr/share/gnome/help/*/* \
        /usr/share/info/* \
        /usr/share/linda/* \
        /usr/share/lintian/overrides/* \
        /usr/share/locale/* \
        /usr/share/man/* \
        /usr/share/omf/*/*-*.emf \
        /usr/src/* \
        /var/lib/apt/lists/* \
        /var/log/*

SHELL ["/bin/bash", "-c"]
EXPOSE 2020/TCP 10050/TCP
COPY install /
ENTRYPOINT ["/init"]
