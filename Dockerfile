FROM debian:buster
LABEL maintainer="Dave Conroy (github.com/tiredofit)"

### Set defaults
ARG FLUENTBIT_VERSION
ARG S6_OVERLAY_VERSION
ARG ZABBIX_VERSION
ARG GO_VERSION=1.16.5

ENV FLUENTBIT_VERSION=${FLUENTBIT_VERSION:-"1.7.9"} \
    S6_OVERLAY_VERSION=${S6_OVERLAY_VERSION:-"v2.2.0.3"} \
    ZABBIX_VERSION=${ZABBIX_VERSION:-"5.4.2"} \
    CONTAINER_ENABLE_SCHEDULING=TRUE \
    CONTAINER_ENABLE_MESSAGING=TRUE \
    CONTAINER_ENABLE_MONITORING=TRUE \
    DEBUG_MODE=FALSE \
    TIMEZONE=Etc/GMT \
    DEBIAN_FRONTEND=noninteractive \
    ZABBIX_HOSTNAME=debian

RUN debArch=$(dpkg --print-architecture) && \
    case "$debArch" in \
        amd64) fluentbit='true' ; FLUENTBIT_BUILD_DEPS="bison cmake flex libssl-dev libsasl2-dev libsystemd-dev zlib1g-dev " ;; \
		*) : ;; \
	esac; \
    set -ex && \
    if [ $(cat /etc/os-release |grep "VERSION=" | awk 'NR>1{print $1}' RS='(' FS=')') != "jessie" ] ; then zstd=zstd; fi ; \
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
                    ${ZABBIX_BUILD_DEPS} ${FLUENTBIT_BUILD_DEPS} \
                    && \
    \
    mkdir -p /usr/local/go && \
    echo "Downloading Go ${GO_VERSION}..." && \
    curl -sSL  https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz | tar xvfz - --strip 1 -C /usr/local/go && \
    ln -sf /usr/local/go/bin/go /usr/local/bin/ && \
    ln -sf /usr/local/go/bin/godoc /usr/local/bin/ && \
    ln -sf /usr/local/go/bin/gfmt /usr/local/bin/ && \
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
            --enable-agent2 \
            --enable-ipv6 \
            --with-openssl && \
    make -j"$(nproc)" -s 1>/dev/null && \
    cp src/zabbix_agent/zabbix_agentd /usr/sbin/zabbix_agentd && \
    cp src/zabbix_sender/zabbix_sender /usr/sbin/zabbix_sender && \
    cp src/go/bin/zabbix_agent2 /usr/sbin/zabbix_agent2 && \
    strip /usr/sbin/zabbix_agentd && \
    strip /usr/sbin/zabbix_sender && \
    mkdir -p /etc/zabbix/zabbix_agentd.conf.d && \
    mkdir -p /var/log/zabbix && \
    chown -R zabbix:root /var/log/zabbix && \
    chown --quiet -R zabbix:root /etc/zabbix && \
    rm -rf /usr/src/zabbix && \
    \
    ### Fluentbit compilation
    mkdir -p /usr/src/fluentbit && \
    curl -sSL https://github.com/fluent/fluent-bit/archive/v${FLUENTBIT_VERSION}.tar.gz | tar xfz - --strip 1 -C /usr/src/fluentbit && \
    cd /usr/src/fluentbit && \
    cmake \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_INSTALL_LIBDIR=lib \
        -DCMAKE_BUILD_TYPE=None \
        -DFLB_JEMALLOC=Yes \
        -DFLB_RELEASE=Yes \
        -DFLB_SIGNV4=Yes \
        -DFLB_BACKTRACE=No \
        -DFLB_HTTP_SERVER=Yes \
        -DFLB_EXAMPLES=No \
        -DFLB_IN_SERIAL=No \
        -DFLB_IN_SYSTEMD=No \
        -DFLB_IN_WINLOG=No \
        -DFLB_IN_WINSTAT=No \
        -DFLB=FLB_IN_KMSG=No \
        -DFLB_IN_SYSTEMD=No \
        -DFLB_OUT_AZURE=No \
        -DFLB_OUT_AZURE_BLOB=No \
        -DFLB_OUT_BIGQUERY=No \
        -DFLB_OUT_DATADOG=No \
        -DFLB_OUT_COUNTER=No \
        -DFLB_OUT_INFLUXDB=No \
        -DFLB_OUT_NRLOGS=No \
        -DFLB_OUT_LOGDNA=No \
        -DFLB_OUT_KAFKA=No \
        -DFLB_OUT_KAFKA_REST=No \
        -DFLB_OUT_KINESIS_FIREHOSE=No \
        -DFLB_OUT_KINESIS_STREAMS=No \
        -DFLB_OUT_PGSQL=No \
        -DFLB_OUT_SLACK=No \
        -DFLB_OUT_SPLUNK=No \
        . && \
    if [ "$debArch" = "amd64" ] ; then make -j"$(nproc)" ; make install ; mv /usr/etc/fluent-bit /etc/fluent-bit ; strip /usr/bin/fluent-bit ; if [ "$debArch" = "amd64" ] && [ "$no_upx" != "true "]; then upx /usr/bin/fluent-bit ; fi ; fi ; \
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
    apt-get purge -y ${ZABBIX_BUILD_DEPS} ${FLUENTBIT_BUILD_DEPS} && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /usr/local/go && \
    rm -rf /usr/local/bin/go* && \
    rm -rf /usr/src/* && \
    rm -rf /root/go && \
    rm -rf /root/.cache && \
    rm -rf /var/lib/apt/lists/* /root/.gnupg /var/log/* /etc/logrotate.d

### Networking configuration
EXPOSE 10050/TCP

### Add folders
ADD install /

### Entrypoint configuration
ENTRYPOINT ["/init"]
