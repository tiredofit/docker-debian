FROM debian:stretch
MAINTAINER Dave Conroy <dave at tiredofit dot ca>

### Install Zabbix
  ARG S6_OVERLAY_VERSION=v1.19.1.1 
  ENV DEBIAN_FRONTEND=noninteractive TERM=xterm \
      ZABBIX_HOSTNAME=debian.stretch

### Dependencies Addon
  RUN apt-get update && \
      apt-get install -y --no-install-recommends \
               ca-certificates \
               curl \
               less \
               logrotate \
               msmtp \
               nano \
               tzdata \
               vim-tiny \
               wget \
               && \
       curl https://repo.zabbix.com/zabbix-official-repo.key | apt-key add - && \
       echo 'deb http://repo.zabbix.com/zabbix/3.4/debian stretch main' >>/etc/apt/sources.list && \
       echo 'deb-src http://repo.zabbix.com/zabbix/3.4/debian stretch main' >>/etc/apt/sources.list && \
       apt-get update && \
       apt-get install -y --no-install-recommends \
               zabbix-agent && \
       wget -O /usr/local/bin/MailHog  https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_amd64 && \
       wget -O /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 && \
       chmod +x /usr/local/bin/MailHog && \
       chmod +x /usr/local/bin/mhsendmail && \
       apt-get purge -y wget && \
       apt-get autoremove -y && \
       apt-get clean -y && \
       rm -rf /var/lib/apt/lists/* && \
       mkdir -p /assets/cron && \
       echo "America/Vancouver" > /etc/timezone && \
       dpkg-reconfigure -f noninteractive tzdata && \

### S6 Installation
       curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar xfz - -C /
   
### Add Folders
   ADD /install /

### Networking Configuration
   EXPOSE 1025 8025 10050/TCP
   
### Entrypoint Configuration
   ENTRYPOINT ["/init"]

