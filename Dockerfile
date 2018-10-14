FROM debian:stretch
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Set Defaults
  ENV DEBUG_MODE=FALSE \
      ENABLE_CRON=TRUE \
      ENABLE_SMTP=TRUE \
      ENABLE_ZABBIX=TRUE \
      DEBIAN_FRONTEND=noninteractive \
      TERM=xterm \
      ZABBIX_HOSTNAME=debian.stretch

### Install Zabbix
ARG S6_OVERLAY_VERSION=v1.21.7.0

### Dependencies Addon
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
             gnupg \
             less \
             logrotate \
             msmtp \
             nano \
             net-tools \
             procps \
             sudo \
             tzdata \
             vim-tiny \
             && \
     curl https://repo.zabbix.com/zabbix-official-repo.key | apt-key add - && \
     echo 'deb http://repo.zabbix.com/zabbix/4.0/debian stretch main' >>/etc/apt/sources.list && \
     echo 'deb-src http://repo.zabbix.com/zabbix/4.0/debian stretch main' >>/etc/apt/sources.list && \
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
     rm -rf /var/lib/apt/lists/* /root/.gnupg /var/log/* && \
     mkdir -p /assets/cron && \
     rm -rf /etc/timezone && \
     ln -snf /usr/share/zoneinfo/America/Vancouver /etc/localtime && \
     echo "America/Vancouver" > /etc/timezone && \
     dpkg-reconfigure -f noninteractive tzdata && \
     echo '%zabbix ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
     \
### S6 Installation
     cd /usr/src && \
     curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar xzf - -C /

### Networking Configuration
 EXPOSE 1025 8025 10050/TCP

### Add Folders
 ADD install /

### Entrypoint Configuration
 ENTRYPOINT ["/init"]

