FROM debian:buster
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Set defaults
ARG S6_OVERLAY_VERSION=v2.2.0.3

ENV DEBUG_MODE=FALSE \
    TIMEZONE=Etc/GMT \
    DEBIAN_FRONTEND=noninteractive \
    ENABLE_CRON=TRUE \
    ENABLE_SMTP=TRUE \
    ENABLE_ZABBIX=TRUE \
    ZABBIX_HOSTNAME=debian

RUN set -x && \
    if [ $(cat /etc/os-release |grep "VERSION=" | awk 'NR>1{print $1}' RS='(' FS=')') != "jessie" ] ; then echo "deb http://deb.debian.org/debian $(cat /etc/os-release |grep "VERSION=" | awk 'NR>1{print $1}' RS='(' FS=')')-backports main" > /etc/apt/sources.list.d/backports.list ; zstd=zstd; backports="/$(cat /etc/os-release |grep "VERSION=" | awk 'NR>1{print $1}' RS='(' FS=')')-backports"; fi ; \
    apt-get update && \
    apt-get upgrade -y && \
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
            zabbix-agent${backports} \
            ${zstd} \
            && \
    rm -rf /etc/zabbix/zabbix-agentd.conf.d/* && \
    rm -rf /etc/timezone && \
    ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
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
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /root/.gnupg /var/log/* /etc/logrotate.d

### Networking configuration
EXPOSE 10050/TCP

### Add folders
ADD install /

### Entrypoint configuration
ENTRYPOINT ["/init"]
