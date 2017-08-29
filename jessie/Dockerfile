FROM debian:jessie
MAINTAINER Dave Conroy <dave at tiredofit dot ca>

### Install Zabbix
   ARG APT_FLAGS_COMMON="-y"
   ARG APT_FLAGS_PERSISTANT="${APT_FLAGS_COMMON} --no-install-recommends"
   ARG APT_FLAGS_DEV="${APT_FLAGS_COMMON} --no-install-recommends"
   ENV DEBIAN_FRONTEND=noninteractive TERM=xterm
   ARG MAJOR_VERSION=3.4
   ARG ZBX_VERSION=${MAJOR_VERSION}
   ARG S6_OVERLAY_VERSION=v1.19.1.1 

   RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d && \
       addgroup --system --quiet zabbix && \
       adduser --quiet \
               --system --disabled-login \
               --ingroup zabbix \
               --home /var/lib/zabbix/ \
           zabbix && \
       mkdir -p /etc/zabbix && \
       mkdir -p /etc/zabbix/zabbix_agentd.d.conf && \
       mkdir -p /var/log/zabbix && \
       mkdir -p /var/lib/zabbix && \
       mkdir -p /var/lib/zabbix/enc && \
       mkdir -p /var/lib/zabbix/modules && \
       chown --quiet -R zabbix:root /var/lib/zabbix && \
       apt-get ${APT_FLAGS_COMMON} update && \
       apt-get ${APT_FLAGS_PERSISTANT} install \
               libssl1.0.0 1>/dev/null && \
       apt-get ${APT_FLAGS_DEV} install \
               gcc \
               make \
               automake \
               libc6-dev \
               pkg-config \
               libssl-dev \
               ca-certificates \
               git && \

       cd /tmp/ && \
       git clone --verbose --progress https://github.com/zabbix/zabbix/ && \
       cd zabbix && \
       git fetch origin && \
       git checkout trunk && \
       sed -i "s/{ZABBIX_REVISION}/trunk/g" include/version.h && \
       ./bootstrap.sh 1>/dev/null && \
       ./configure \
               --prefix=/usr \
               --silent \
               --sysconfdir=/etc/zabbix \
               --libdir=/usr/lib/zabbix \
               --datadir=/usr/lib \
               --enable-agent \
               --enable-ipv6 \
               --enable-static && \
       make -j"$(nproc)" -s 1>/dev/null && \
       cp src/zabbix_agent/zabbix_agentd /usr/sbin/zabbix_agentd && \
       cp src/zabbix_sender/zabbix_sender /usr/sbin/zabbix_sender && \
       cp conf/zabbix_agentd.conf /etc/zabbix/ && \
       mkdir -p /var/log/zabbix && \
       chown -R zabbix:root /var/log/zabbix && \
       chown --quiet -R zabbix:root /etc/zabbix && \
       cd /tmp/ && \
       rm -rf /tmp/zabbix && \
       apt-get ${APT_FLAGS_COMMON} purge \
               gcc \
               make \
               automake \
               libc6-dev \
               pkg-config \
               libssl-dev \
               git 1>/dev/null && \

### Dependencies Addon
       apt-get ${APT_FLAGS_COMMON} install \
               curl \
               less \
               logrotate \
               msmtp \
               nano \
               tzdata \
               vim-tiny \
               wget \
               && \
       wget -O /usr/local/bin/MailHog  https://github.com/mailhog/MailHog/releases/download/v1.0.0/MailHog_linux_amd64 && \
       wget -O /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 && \
       chmod +x /usr/local/bin/MailHog && \
       chmod +x /usr/local/bin/mhsendmail && \
       apt-get purge -y wget && \
       apt-get ${APT_FLAGS_COMMON} autoremove && \
       apt-get ${APT_FLAGS_COMMON} clean && \
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
   CMD ["bash"]

