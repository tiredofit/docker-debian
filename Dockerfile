# SPDX-FileCopyrightText: © 2024 Dave Conroy <dave@tiredofit.ca>
#
# SPDX-License-Identifier: MIT

ARG DEBIAN_VERSION=bookworm

FROM docker.io/debian:${DEBIAN_VERSION}-slim

LABEL org.opencontainers.image.title         "Debian"
LABEL org.opencontainers.image.description   "Dockerized Container Base Image"
LABEL org.opencontainers.image.url           "https://hub.docker.com/r/tiredofit/debian"
LABEL org.opencontainers.image.documentation "https://github.com/tiredofit/docker-debian/blob/main/README.md"
LABEL org.opencontainers.image.source        "https://github.com/tiredofit/docker-debian.git"
LABEL org.opencontainers.image.authors       "Dave Conroy <dave@tiredofit.ca>"
LABEL org.opencontainers.image.vendor        "Tired of I.T! <https://www.tiredofit.ca>"
LABEL org.opencontainers.image.licenses      "MIT"

ARG IMAGE_BASE_VERSION
ARG GOLANG_VERSION=1.22.6
ARG FLUENTBIT_VERSION
ARG INFISICAL_VERION
ARG S6_OVERLAY_VERSION
ARG TAILSCALE_VERSION
ARG ZABBIX_VERSION

### Set defaults
ENV IMAGE_BASE_VERSION=${IMAGE_BASE_VERSION:-"main"} \
    FLUENTBIT_VERSION=${FLUENTBIT_VERSION:-"3.1.6"} \
    INFISICAL_VERSION=${INFISICAL_VERSION:-"v0.23.3"} \
    S6_OVERLAY_VERSION=${S6_OVERLAY_VERSION:-"3.2.0.0"} \
    TAILSCALE_VERSION=${TAILSCALE_VERSION:-"v1.68.2"} \
    ZABBIX_VERSION=${ZABBIX_VERSION:-"7.0.2"} \
    ZEROTIER_VERSION=${ZEROTIER_VERSION:-"1.14.0"} \
    IMAGE_BASE_REPO_URL=${IMAGE_BASE_REPO_URL:-"https://github.com/tiredofit/docker-base"} \
    INFISICAL_REPO_URL=${INFISICAL_REPO_URL:-"https://github.com/infisical/infisical"} \
    TAILSCALE_REPO_URL=https://github.com/tailscale/tailscale \
    ZEROTIER_REPO_URL=https://github.com/zerotier/ZeroTierOne \
    DEBUG_MODE=FALSE \
    TIMEZONE=Etc/GMT \
    CONTAINER_ENABLE_SCHEDULING=FALSE \
    CONTAINER_SCHEDULING_BACKEND=cron \
    CONTAINER_ENABLE_MESSAGING=FALSE \
    CONTAINER_MESSAGING_BACKEND=msmtp \
    CONTAINER_ENABLE_METRICS=TRUE \
    CONTAINER_ENABLE_MONITORING=FALSE \
    CONTAINER_MONITORING_BACKEND=zabbix \
    CONTAINER_ENABLE_LOGSHIPPING=FALSE \
    DEBIAN_FRONTEND=noninteractive \
    S6_GLOBAL_PATH=/command:/usr/bin:/bin:/usr/sbin:sbin:/usr/local/bin:/usr/local/sbin \
    S6_KEEP_ENV=1 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0 \
    IMAGE_NAME="tiredofit/debian" \
    IMAGE_REPO_URL="https://github.com/tiredofit/docker-debian/"

COPY CHANGELOG.md /usr/src/build_image/CHANGELOG.md
COPY LICENSE /usr/src/build_image/LICENSE
COPY README.md /usr/src/build_image/README.md

RUN echo "" && \
    CONTAINER_BUILD_DEPS=" \
                         " && \
    CONTAINER_RUN_DEPS=" \
                            acl \
                            apt-transport-https \
                            apt-utils \
                            aptitude \
                            bash \
                            busybox-static \
                            ca-certificates \
                            curl \
                            dirmngr \
                            fail2ban \
                            gettext \
                            git \
                            gnupg \
                            iptables \
                            logrotate \
                            msmtp \
                            nano \
                            net-tools \
                            netcat-openbsd \
                            procps \
                            sudo \
                            tzdata \
                            zstd \
                        " && \
    \
    debArch=$(dpkg --print-architecture) && \
    case "${debArch}" in \
        amd64) \
            build_fluentbit="true" ; \
		;; \
        *) \
            : \
        ;; \
	esac ; \
    build_age=true && \
    build_go=true && \
    build_infisical=true && \
    build_tailscale=true && \
    build_zabbixagent="true" && \
    build_zerotier=true && \
    \
    set -ex && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
                            ${CONTAINER_BUILD_DEPS} \
                            ${CONTAINER_RUN_DEPS} \
                        && \
    mv /usr/bin/envsubst /usr/local/bin && \
    rm -rf /usr/bin/crontab && \
    rm -rf /usr/sbin/cron && \
    ln -s /usr/bin/busybox /usr/sbin/crontab && \
    ln -s /usr/bin/busybox /usr/sbin/crond && \
    busybox --install -s /usr/bin && \
    \
    rm -rf /etc/timezone && \
    ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    \
    mkdir -p /usr/local/go && \
    echo "Downloading Go ${GOLANG_VERSION}..." && \
    curl -sSLk  https://dl.google.com/go/go${GOLANG_VERSION}.linux-${debArch}.tar.gz | tar xvfz - --strip 1 -C /usr/local/go && \
    ln -sf /usr/local/go/bin/go /usr/local/bin/ && \
    ln -sf /usr/local/go/bin/godoc /usr/local/bin/ && \
    ln -sf /usr/local/go/bin/gfmt /usr/local/bin/ && \
    \
    if [ "${build_fluentbit}" = "true" ] ; then \
        FLUENTBIT_BUILD_DEPS=" \
                                automake \
                                bison \
                                build-essential \
                                cmake \
                                flex \
                                libssl-dev \
                                libsasl2-dev \
                                libsystemd-dev \
                                libyaml-dev \
                                pkg-config \
                                zlib1g-dev \
                            " ; \
        FLUENTBIT_RUN_DEPS=" \
                                libyaml-0-2 \
                            " ; \
        apt-get install -y \
                                ${FLUENTBIT_BUILD_DEPS} \
                                ${FLUENTBIT_RUN_DEPS} \
                           && \
        mkdir -p /usr/src/fluentbit ; \
        curl -sSLk https://github.com/fluent/fluent-bit/archive/v${FLUENTBIT_VERSION}.tar.gz | tar xfz - --strip 1 -C /usr/src/fluentbit ; \
        cd /usr/src/fluentbit ; \
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
                . ; \
        make -j"$(nproc)" ; \
        make install ; \
        mv /usr/etc/fluent-bit /etc/fluent-bit ; \
        strip /usr/bin/fluent-bit ; \
    fi ; \
    \
    if [ "${build_age}" = true ]; then \
        go install filippo.io/age/cmd/...@latest ; \
        mkdir -p /usr/local/sbin ; \
        strip /root/go/bin/age ; \
        strip /root/go/bin/age-keygen ; \
        cp -aR /root/go/bin/* /usr/local/sbin ; \
    fi ; \
    if [ "${build_infisical}" = "true" ] ; then \
        INFISICAL_BUILD_DEPS=" \
            libssl-dev \
        " \
        ; \
        INFISICAL_RUN_DEPS=" \
            openssl \
        " \
        ; \
        apt-get install -y \
                                ${INFISICAL_BUILD_DEPS} \
                                ${INFISICAL_RUN_DEPS} \
                           ; \
        git clone "${INFISICAL_REPO_URL}" /usr/src/infisical ; \
        cd /usr/src/infisical ; \
        git checkout infisical-cli/"${INFISICAL_VERSION}" ; \
        cd cli ; \
        sed -i "s|CLI_VERSION = \".*\"|CLI_VERSION = \"${INFISICAL_VERSION}\"|g" packages/util/constants.go ; \
        go build -ldflags "-w -s" -a . ; \
        mv infisical-merge /usr/local/bin/infisical ; \
    fi ; \
    \
    if [ "${build_zabbixagent}" = "true" ] ; then \
        ZABBIXAGENT_BUILD_DEPS=" \
                                    autoconf \
                                    automake \
                                    autotools-dev\
                                    build-essential \
                                    g++ \
                                    pkg-config \
                                    libpcre3-dev \
                                    libssl-dev \
                                    zlib1g-dev  \
                                " \
                                ; \
        ZABBIXAGENT_RUN_DEPS=" \
                                    libpcre3 \
                                " \
                                ; \
        apt-get install -y \
                                ${ZABBIXAGENT_BUILD_DEPS} \
                                ${ZABBIXAGENT_RUN_DEPS} \
                            ; \
        addgroup \
                --gid 10050 \
                zabbix \
                ; \
        adduser \
                --uid 10050 \
                --gid 10050 \
                --gecos "Zabbix Agent" \
                --home /dev/null \
                --no-create-home \
                --shell /sbin/nologin \
                --disabled-login \
                --disabled-password \
                zabbix \
                ; \
        mkdir -p \
                /etc/zabbix \
                /etc/zabbix/zabbix_agentd.conf.d \
                /var/lib/zabbix \
                /var/lib/zabbix/enc \
                /var/lib/zabbix/modules \
                /var/lib/zabbix/run \
                ; \
        chown --quiet -R zabbix:root \
                                    /etc/zabbix \
                                    /var/lib/zabbix \
                                    ; \
        chmod -R 770 /var/lib/zabbix/run ; \
        mkdir -p /usr/src/zabbix ; \
        curl -sSLk https://github.com/zabbix/zabbix/archive/${ZABBIX_VERSION}.tar.gz | tar xfz - --strip 1 -C /usr/src/zabbix ; \
        cd /usr/src/zabbix ; \
        sed -i "s|{ZABBIX_REVISION}|${ZABBIX_VERSION}|g" include/version.h ; \
        ./bootstrap.sh 1>/dev/null ; \
        export CFLAGS="-fPIC -pie -Wl,-z,relro -Wl,-z,now" ; \
        ./configure \
                --prefix=/usr \
                --silent \
                --sysconfdir=/etc/zabbix \
                --libdir=/usr/lib/zabbix \
                --datadir=/usr/lib \
                --enable-agent \
                --enable-agent2 \
                --enable-ipv6 \
                --with-openssl \
                ; \
        make -j"$(nproc)" -s 1>/dev/null ; \
        cp src/zabbix_agent/zabbix_agentd /usr/sbin/zabbix_agentd ; \
        cp src/zabbix_get/zabbix_get /usr/sbin/zabbix_get ; \
        cp src/zabbix_sender/zabbix_sender /usr/sbin/zabbix_sender ; \
        cp src/go/bin/zabbix_agent2 /usr/sbin/zabbix_agent2 ; \
        strip /usr/sbin/zabbix_agentd ; \
        strip /usr/sbin/zabbix_get ; \
        strip /usr/sbin/zabbix_sender ; \
        strip /usr/sbin/zabbix_agent2 ; \
    fi ; \
    \
    if [ "${build_tailscale}" = "true" ] ; then \
        TAILSCALE_BUILD_DEPS=" \
                                    \
                                " \
                                ; \
        TAILSCALE_RUN_DEPS=" \
                                    ca-certificates \
                                    iproute2 \
                                    iptables \
                                " \
                                ; \
        apt-get install -y \
                                ${TAILSCALE_BUILD_DEPS} \
                                ${TAILSCALE_RUN_DEPS} \
                            ; \
        addgroup \
                --gid 8245 \
                tailscale \
                ; \
        adduser \
                --uid 8245 \
                --gid 8245 \
                --gecos "Tailscale" \
                --home /dev/null \
                --no-create-home \
                --shell /sbin/nologin \
                --disabled-login \
                --disabled-password \
                tailscale \
                ; \
        git clone "${TAILSCALE_REPO_URL}" /usr/src/tailscale ; \
        cd /usr/src/tailscale ; \
        git checkout "${TAILSCALE_VERSION}" ; \
        go build -ldflags="-s -w" -a ./cmd/tailscale ; \
        go build -ldflags="-s -w" -a ./cmd/tailscaled ; \
        mv tailscale /usr/local/bin ; \
        mv tailscaled /usr/local/bin ; \
    fi ; \
    \
    if [ "${build_zerotier}" = "true" ] ; then \
        ZEROTIER_BUILD_DEPS=" \
                                build-essential \
                                clang \
                                git \
                            " ; \
        ZEROTIER_RUN_DEPS=" \
                                curl  \
                                iproute2 \
                                iputils-arping \
                                iputils-ping \
                                net-tools \
                                openssl \
                            " ;\
        apt-get install -y \
                                ${ZEROTIER_BUILD_DEPS} \
                                ${ZEROTIER_RUN_DEPS} \
                            ; \
        addgroup \
            --gid 9376 \
            zerotier \
            ; \
        adduser \
            --uid 9376 \
            --gid 9376 \
            --gecos "Zerotier" \
            --home /dev/null \
            --no-create-home \
            --shell /sbin/nologin \
            --disabled-login \
            --disabled-password \
            zerotier \
            ; \
        git clone "${ZEROTIER_REPO_URL}" /usr/src/zerotier ; \
        cd /usr/src/zerotier ; \
        git checkout "${ZEROTIER_VERSION}" ; \
        sed -i "s|ZT_SSO_SUPPORTED=1|ZTG_SSO_SUPPORTED=0|g" make-linux.mk ; \
        make -j $(nproc) -f make-linux.mk ; \
        make -j $(nproc) -f make-linux.mk install ; \
    fi ; \
    \
    addgroup \
            --gid 65500 \
            fail2ban \
            && \
    mkdir -p /var/run/fail2ban && \
    find /etc/fail2ban/action.d/ -type f -not -name 'iptables*.conf' -delete && \
    mkdir -p /etc/fail2ban/filter.d && \
    rm -rf \
            /etc/fail2ban/fail2ban.d \
            /etc/fail2ban/filter.d \
            /etc/fail2ban/jail.d/* \
            /etc/fail2ban/paths* \
            /var/run/fail2ban/* \
            && \
    \
    debArch=$(dpkg --print-architecture) && \
    case "$debArch" in \
        amd64) \
            s6Arch='x86_64' ; \
        ;; \
        armel) \
            s6Arch='armhf' ; \
        ;; \
        armhf) \
            s6Arch='armhf' ; \
        ;; \
		arm64) \
            s6Arch='aarch64' ; \
        ;; \
		*) \
            echo >&2 "Error: unsupported architecture ($debArch)" ; \
            exit 1 ; \
        ;; \
	esac ; \
    curl -sSLk https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz | tar xvpfJ - -C / && \
    curl -sSLk https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-${s6Arch}.tar.xz | tar xvpfJ - -C / && \
    curl -sSLk https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-symlinks-noarch.tar.xz | tar xvpfJ - -C / && \
    curl -sSLk https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-symlinks-arch.tar.xz | tar xvpfJ - -C / && \
    mkdir -p \
        /etc/cont-init.d \
        /etc/cont-finish.d \
        /etc/services.d \
        && \
    chown -R 0755 \
        /etc/cont-init.d \
        /etc/cont-finish.d \
        /etc/services.d \
        && \
    \
    sed -i "s|echo|: # echo |g" /package/admin/s6-overlay/etc/s6-rc/scripts/cont-init && \
    sed -i "s|echo|: # echo |g" /package/admin/s6-overlay/etc/s6-rc/scripts/cont-finish && \
    sed -i "s|echo ' (no readiness notification)'|: # echo ' (no readiness notification)'|g" /package/admin/s6-overlay/etc/s6-rc/scripts/services-up && \
    sed -i "s|s6-echo -n|: # s6-echo -n|g" /package/admin/s6-overlay/etc/s6-rc/scripts/services-up && \
    sed -i "s|v=2|v=1|g" /package/admin/s6-overlay/etc/s6-linux-init/skel/rc.init && \
    sed -i "s|v=2|v=1|g" /package/admin/s6-overlay/etc/s6-linux-init/skel/rc.shutdown && \
    \
    mkdir -p /etc/bash && \
    rm -rf /etc/bash.bashrc && \
    echo "for script in \$(find /etc/bash/ /override/bash/ -type f ! -name *.enc* -print -maxdepth 1 2>/dev/null) ; do source \$script; done" > /etc/bash.bashrc && \
    \
    git clone "${IMAGE_BASE_REPO_URL}" /usr/src/docker-base && \
    cd /usr/src/docker-base && \
    git checkout "${IMAGE_BASE_VERSION}" && \
    cp -a /usr/src/docker-base/rootfs/* / && \
    mkdir -p /container/build/tiredofit_base && \
    cp -a \
                /usr/src/docker-base/CHANGELOG.md \
                /usr/src/docker-base/LICENSE \
                /usr/src/docker-base/README.md \
            /container/build/tiredofit_base/ && \
    if [ "${IMAGE_BASE_VERSION}" = "main" ]; then IMAGE_BASE_VERSION=$(git log -1 --pretty="format:%H" -- /usr/src/docker-base) ; fi && \
    echo "$(TZ=$TIMEZONE date +'%Y-%m-%d %H:%M:%S %Z') | ${IMAGE_BASE_VERSION} | ${IMAGE_BASE_REPO_URL}" >> /container/build/tiredofit_base/fetch.log && \
    mkdir -p /container/build/$(echo ${IMAGE_NAME} | sed 's|/|_|g') && \
    echo "$(TZ=$TIMEZONE date +'%Y-%m-%d %H:%M:%S %Z') | ${IMAGE_NAME} | ${IMAGE_REPO_URL}" >> /container/build/$(echo ${IMAGE_NAME} | sed 's|/|_|g')/build.log && \
    echo "$(TZ=$TIMEZONE date +'%Y-%m-%d %H:%M:%S %Z') | ${IMAGE_BASE_VERSION} | ${IMAGE_BASE_REPO_URL}" >> /container/build/build.log && \
    echo "$(TZ=$TIMEZONE date +'%Y-%m-%d %H:%M:%S %Z') | ${IMAGE_NAME} | ${IMAGE_REPO_URL}" >> /container/build/build.log && \
    mv /usr/src/build_image/* /container/build/$(echo ${IMAGE_NAME} | sed 's|/|_|g') && \
    \
    apt-get purge -y \
                    ${CONTAINER_BUILD_DEPS} \
                    gettext \
                    && \
    if [ "${build_fluentbit}" = "true" ]; then \
        apt-get purge -y ${FLUENTBIT_BUILD_DEPS} ; \
        apt-get install -y ${FLUENTBIT_RUN_DEPS} ; \
    fi ; \
    if [ "${build_infisical}" = "true" ]; then \
        apt-get purge -y ${INFISICAL_BUILD_DEPS} ; \
        apt-get install -y ${INFISICAL_RUN_DEPS} ; \
    fi ; \
    if [ "${build_tailscale}" = "true" ]; then \
        apt-get purge -y ${TAILSCALE_BUILD_DEPS} ; \
        apt-get install -y ${TAILSCALE_RUN_DEPS} ; \
    fi ; \
    if [ "${build_zabbixagent}" = "true" ]; then \
        apt-get purge -y ${ZABBIXAGENT_BUILD_DEPS} ; \
        apt-get install -y ${ZABBIXAGENT_RUN_DEPS} ; \
    fi ; \
    if [ "${build_zerotier}" = "true" ]; then \
        apt-get purge -y ${ZEROTIER_BUILD_DEPS} ; \
        apt-get install -y ${ZEROTIER_RUN_DEPS} ; \
    fi ; \
    apt-get autoremove -y && \
    apt-get clean -y && \
    \
    rm -rf \
        /etc/cron* \
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
ENTRYPOINT ["/init"]

COPY rootfs/ /
