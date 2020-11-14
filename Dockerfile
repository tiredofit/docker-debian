FROM debian:buster
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Set defaults
ENV ZABBIX_VERSION=5.2 \
    S6_OVERLAY_VERSION=v2.1.0.2 \
    DEBUG_MODE=FALSE \
    TIMEZONE=Etc/GMT \
    DEBIAN_FRONTEND=noninteractive \
    ENABLE_CRON=TRUE \
    ENABLE_SMTP=TRUE \
    ENABLE_ZABBIX=TRUE \
    ZABBIX_HOSTNAME=debian.buster

### Dependencies addon
RUN set -x && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
            apt-transport-https \
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
            && \
    curl https://repo.zabbix.com/zabbix-official-repo.key | apt-key add - && \
    echo "deb http://repo.zabbix.com/zabbix/${ZABBIX_VERSION}/debian buster main" >>/etc/apt/sources.list && \
    echo "deb-src http://repo.zabbix.com/zabbix/${ZABBIX_VERSION}/debian buster main" >>/etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
            zabbix-agent && \
    rm -rf /etc/zabbix/zabbix-agentd.conf.d/* && \
    curl -sSLo /usr/local/bin/MailHog https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_amd64 && \
    curl -sSLo /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 && \
    chmod +x /usr/local/bin/MailHog && \
    chmod +x /usr/local/bin/mhsendmail && \
    useradd -r -s /bin/false -d /nonexistent mailhog && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /root/.gnupg /var/log/* /etc/logrotate.d && \
    mkdir -p /assets/cron && \
    rm -rf /etc/timezone && \
    ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
    echo "${TIMEZONE}" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata && \
    echo '%zabbix ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    \
### S6 installation
    curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar xfz - --strip 0 -C /

### Networking configuration
EXPOSE 1025 8025 10050/TCP

### Add folders
ADD install /

### Entrypoint configuration
ENTRYPOINT ["/init"]
