## 7.8.16 2023-12-05 <dave at tiredofit dot ca>

   ### Changed
      - When using service_stop do not pass DONOTSTART to running script if $1 is different


## 7.8.15 2023-11-08 <dave at tiredofit dot ca>

   ### Added
      - Golang 1.21.4
      - Zabbix Agent 6.4.8


## 7.8.14 2023-11-06 <dave at tiredofit dot ca>

   ### Added
      - S6 Overlay 3.16.0


## 7.8.13 2023-10-08 <dave at tiredofit dot ca>

   ### Changed
      - Change around Fluent-bit compression parameter


## 7.8.12 2023-09-28 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 2.1.10
      - Add option for gzip compression for fluent-bit output/loki


## 7.8.11 2023-09-26 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.4.7


## 7.8.10 2023-09-22 <dave at tiredofit dot ca>

   ### Changed
      - Fix Golang version issues

   ### Reverted
      - Remove stale busybox development routines


## 7.8.9 2023-08-23 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.4.6
      - Go Build 1.21.0
      - YQ 4.35.1
      - Add SMTP_ALLOW_FROM override (credit to coolibre@github)


## 7.8.8 2023-07-28 <dave at tiredofit dot ca>

   ### Added
      - Add 'libpcre3' package


## 7.8.7 2023-07-28 <dave at tiredofit dot ca>

   ### Added
      - Golang build chain 1.20.6
      - YQ 4.34.2
      - Fluent-bit 2.1.8

   ### Changed
      - Change the db_ready function to accomodate the binary name change with MariaDB 11 clients


## 7.8.6 2023-06-27 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.4.4


## 7.8.5 2023-06-23 <dave at tiredofit dot ca>

   ### Added
      - Fluent Bit 2.1.6


## 7.8.4 2023-06-20 <dave at tiredofit dot ca>

   ### Reverted
      - Stop using UPX to pack executibles


## 7.8.3 2023-06-20 <dave at tiredofit dot ca>

   ### Added
      - Fluent-Bit 2.1.5


## 7.8.2 2023-06-16 <dave at tiredofit dot ca>

   ### Changed
      - Fix issue with newer versions of fluent-bit not compiling due to a problem with node-exporter not respecting the fact we aren't building the systemd input


## 7.8.1 2023-05-03 <dave at tiredofit dot ca>

   ### Added
      - GoLang 1.20.4

   ### Changed
      - Cleanup


## 7.8.0 2023-04-26 <dave at tiredofit dot ca>

   ### Added
      - Introduce _FILE support for environment variables
      - Quiet down DEBUG_MODE for "base image" services
      - Zabbix Agent 6.4.2
      - Fluent-bit 2.1.2


## 7.7.59 2023-04-21 <dave at tiredofit dot ca>

   ### Added
      - Fluent-Bit 2.1.1


## 7.7.58 2023-04-05 <dave at tiredofit dot ca>

   ### Added
      - Go Build 1.20.3
      - Fluent-bit 2.0.11


## 7.7.57 2023-04-03 <dave at tiredofit dot ca>

   ### Added
      - S6 Overlay 3.14.2


## 7.7.56 2023-03-31 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.4.1
      - YQ 4.33.1


## 7.7.55 2023-03-26 <dave at tiredofit dot ca>

   ### Added
      - YQ 4.33.1

   ### Changed
      - Fix issue with fluentbit version


## 7.7.54 2023-03-16 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 2.0.10
      - Use Golang 1.20.1 for building again


## 7.7.53 2023-03-07 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.4.0


## 7.7.52 2023-02-21 <dave at tiredofit dot ca>

   ### Added
      - S6 Overlay 3.1.4.1


## 7.7.51 2023-02-20 <dave at tiredofit dot ca>

   ### Added
      - YQ 4.31.1


## 7.7.50 2023-02-17 <dave at tiredofit dot ca>

   ### Added
      - S6 Overlay 3.1.4.0


## 7.7.49 2023-02-15 <dave at tiredofit dot ca>

   ### Changed
      - Additional doas fixes


## 7.7.48 2023-02-15 <dave at tiredofit dot ca>

   ### Changed
      - Fix S6 overlay verbosity hack which now throws errors due to a blank if statement


## 7.7.47 2023-02-14 <dave at tiredofit dot ca>

   ### Changed
      - Fix for grant_doas function not saving to correct location and set proper permissions


## 7.7.46 2023-02-06 <dave at tiredofit dot ca>

   ### Added
      - Fluent Bit version 2.0.9
      - S6 Overlay 3.1.3.0
      - Zabbix Agent 6.2.7
      - YQ 4.30.8
      - Go build environment 1.20


## 7.7.45 2022-12-31 <dave at tiredofit dot ca>

   ### Changed
      - Change to `service_` commands - New addition `service_list` and also `service_reset` to reset watchdog status to avoid having to restart container after triggered
      - `service_down` and `service_up` also take `all` argument to bring up or down all services


## 7.7.44 2022-12-23 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 2.0.8


## 7.7.43 2022-12-22 <dave at tiredofit dot ca>

   ### Added
      - Start building and including yq (presently 4.30.6) - Upcoming releases will remove jq
      - prepare_service function ingests variables much differently when called from /etc/cont-init.d


## 7.7.42 2022-12-12 <dave at tiredofit dot ca>

   ### Changed
      - Fix extra ampersand in Dockerfile


## 7.7.41 2022-12-12 <dave at tiredofit dot ca>

   ### Changed
      - Fix for optimized rm command


## 7.7.40 2022-12-12 <dave at tiredofit dot ca>

   ### Added
      - Golang build environment 1.19.4

   ### Changed
      - Allow clone_git_repo to shallow clone and still perform git describe


## 7.7.39 2022-12-11 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.2.6


## 7.7.38 2022-12-05 <dave at tiredofit dot ca>

   ### Changed
      - Fix for Zabbix volatile data permissions


## 7.7.37 2022-11-30 <dave at tiredofit dot ca>

   ### Changed
      - Fix quoting issue with package remove


## 7.7.36 2022-11-29 <dave at tiredofit dot ca>

   ### Changed
      - Quiet down package function


## 7.7.35 2022-11-29 <dave at tiredofit dot ca>

   ### Changed
      - Better handle package removals


## 7.7.32 2022-11-29 <dave at tiredofit dot ca>

   ### Added
      - Introduce "package" function


## 7.7.31 2022-11-25 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 2.0.6


## 7.7.30 2022-11-11 <dave at tiredofit dot ca>

   ### Added
      - Golang build environment 1.19.3
      - Fluent-bit 2.0.5


## 7.7.29 2022-11-08 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 2.0.4


## 7.7.28 2022-11-07 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.2.4


## 7.7.27 2022-10-29 <dave at tiredofit dot ca>

   ### Added
      - Fluent-Bit 2.0.3


## 7.7.26 2022-10-27 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 2.0.2


## 7.7.25 2022-10-25 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 2.0.0
      - Golang Build environment 1.19.2


## 7.7.24 2022-10-04 <dave at tiredofit dot ca>

   ### Changed
      - Death by if statements


## 7.7.23 2022-10-04 <dave at tiredofit dot ca>

   ### Changed
      - For real, fix for clone_git_repo and .git extensions


## 7.7.22 2022-10-03 <dave at tiredofit dot ca>

   ### Changed
      - Final clone_git_repo modifications


## 7.7.21 2022-10-03 <dave at tiredofit dot ca>

   ### Changed
      - Additional work on 'clone_git_repo' function


## 7.7.20 2022-10-01 <dave at tiredofit dot ca>

   ### Added
      - Add custom_dir to clone_git_repo function


## 7.7.19 2022-10-01 <dave at tiredofit dot ca>

   ### Changed
      - Start pulling submodules with clone_git_repo function


## 7.7.18 2022-10-01 <dave at tiredofit dot ca>

   ### Changed
      - Tweak to update_templates function to allow wildcards


## 7.7.17 2022-09-29 <dave at tiredofit dot ca>

   ### Added
      - Change default shell to /bin/bash when building descendent Dockerfiles

   ### Changed
      - Refine clone_git_repo function


## 7.7.16 2022-09-29 <dave at tiredofit dot ca>

   ### Changed
      - Add check for git existence for clone_git_repo


## 7.7.15 2022-09-29 <dave at tiredofit dot ca>

   ### Added
      - Add envsubst binary


## 7.7.14 2022-09-29 <dave at tiredofit dot ca>

   ### Added
      - Introduce clone_git_repo function for bandwidth and space saving purposes
      - Introduce install_template function for copying files with correct permissions
      - Introduce update_template to update tags in template files - Create templates tags like {{VALUE}} in your files to update


## 7.7.13 2022-09-29 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 1.9.9
      - Golang for building 1.19.1


## 7.7.12 2022-09-21 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.2.3


## 7.7.11 2022-09-11 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 1.9.8


## 7.7.10 2022-09-05 <terryzwt@github>

   ### Fixed
      - MSMTP Configuration doesn't like all caps letters


## 7.7.9 2022-08-30 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.2.2
      - S6 Overlay 3.1.2.1
      - GO Build 1.19


## 7.7.8 2022-08-17 <dave at tiredofit dot ca>

   ### Changed
      - Start taking over pid of services.avaialable scripts


## 7.7.7 2022-08-15 <dave at tiredofit dot ca>

   ### Changed
      - Change Fail2ban gid to 65500 as LXC containers can't start on higher than 65535


## 7.7.6 2022-08-12 <dave at tiredofit dot ca>

   ### Changed
      - Make logrotate use /etc/logrotate.conf as main configuration


## 7.7.5 2022-08-11 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 1.9.7
      - Customizable compssion types for logrotate, now defaults to using zstd
      - Function for zcat to handle bz/xz/gz/zst

   ### Changed
      - Fix error when CRON_PERIOD exists as a default or environment variable


## 7.7.4 2022-08-06 <dave at tiredofit dot ca>

   ### Added
      - Add third and fourth argument to custom_files function to change ownership post copy


## 7.7.3 2022-08-06 <dave at tiredofit dot ca>

   ### Changed
      - Additional fix to custom_scripts function


## 7.7.2 2022-08-05 <dave at tiredofit dot ca>

   ### Changed
      - Fix for custom_scripts function not firing


## 7.7.1 2022-08-05 <dave at tiredofit dot ca>

   ### Changed
      - Fix busted CONTAINER_POST_INIT_COMMAND feature


## 7.7.0 2022-08-05 <dave at tiredofit dot ca>

   ### Added
      - Firewall Support - Now have the capability of either loading an iptables.rules file or using environment variables to set individual IPTables rules inside the container
      - Fail2Ban Support - Along with above, embed fail2ban within the container rather than having it maintained downstream in many images. Drop your jails and filters in /etc/fail2ban/filters.d and /etc/fail2ban/jails.d
      - Go 1.19.0 build chain


## 7.6.26 2022-07-27 <dave at tiredofit dot ca>

   ### Added
      - Added option to show output of application on the final execution before process runaway guard is activated


## 7.6.25 2022-07-27 <dave at tiredofit dot ca>

   ### Changed
      - Quiet down dir_empty and dir_notempty functions


## 7.6.24 2022-07-25 <dave at tiredofit dot ca>

   ### Changed
      - Fix Process Watchdog in various situations from throwing an error about line 729


## 7.6.23 2022-07-25 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.2.1
      - Fluent-bit 1.9.6


## 7.6.22 2022-07-18 <dave at tiredofit dot ca>

   ### Added
      - Parity with tiredofit/alpine 7.6.22


## 7.6.21 2022-07-18 <dave at tiredofit dot ca>

   ### Added
      - Version parity to tiredofit/alpine:7.6.21


## 7.6.20 2022-07-07 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.2.0


## 7.6.19 2022-07-05 <dave at tiredofit dot ca>

   ### Added
      - Add blank /etc/fluent-bit/parsers.d directory


## 7.6.18 2022-07-05 <dave at tiredofit dot ca>

   ### Changed
      - Fix issues relating to Fluent-Bit not parsing configuration correctly due to logrotate shift


## 7.6.17 2022-07-04 <dave at tiredofit dot ca>

   ### Changed
      - Add version ARG in FROM Dockerfile


## 7.6.16 2022-06-29 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.0.6
      - S6 Overlay 3.1.1.2


## 7.6.15 2022-06-24 <dave at tiredofit dot ca>

   ### Added
      - Bring to Parity with tiredofit/alpine


## 7.6.14 2022-06-24 <dave at tiredofit dot ca>

   ### Added
      - Add libyaml-0-2 for runtime operations


## 7.6.13 2022-06-23 <dave at tiredofit dot ca>

   ### Changed
      - Add libyaml-dev to properly compile fluent-bit


## 7.6.12 2022-06-23 <dave at tiredofit dot ca>

   ### Added
      - S6 Overlay 3.1.1.1
      - Fluent-bit 1.9.5


## 7.6.11 2022-06-22 <dave at tiredofit dot ca>

   ### Changed
      - Rollback to S6 Overlay 3.1.0.1


## 7.6.10 2022-06-17 <dave at tiredofit dot ca>

   ### Added
      - S6 Overlay 3.1.1.0


## 7.6.9 2022-06-15 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 1.9.4


## 7.6.8 2022-06-05 <dave at tiredofit dot ca>

   ### Reverted
      - Drop Jessie and Stretch Support


## 7.6.7 2022-06-05 <dave at tiredofit dot ca>


## 7.6.6 2022-06-04 <dave at tiredofit dot ca>

   ### Added
      - Strip 30mb from base image due to cleanup that occurs similar to debian:sim


## 7.6.5 2022-06-03 <dave at tiredofit dot ca>

   ### Added
      - Add Ubuntu init script support


## 7.6.4 2022-06-01 <dave at tiredofit dot ca>

   ### Added
      - Build with Golang 1.18.3


## 7.6.3 2022-05-30 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.0.5


## 7.6.2 2022-05-24 <dave at tiredofit dot ca>

   ### Changed
      - Change bash prompt to show pathname when working inside container


## 7.6.1 2022-05-03 <dave at tiredofit dot ca>

   ### Changed
      - Zabbix Agent 6.0.4


## 7.6.0 2022-04-30 <dave at tiredofit dot ca>

   ### Changed
      - Move /etc/logrotate.d assets to /assets/logrotate to avoid packages being upgraded auto adding more configuration


## 7.5.5 2022-04-05 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.0.3


## 7.5.4 2022-03-23 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 1.8.15


## 7.5.3 2022-03-22 <dave at tiredofit dot ca>

   ### Added
      - Add inetutils-ping package


## 7.5.2 2022-03-18 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 1.8.14


## 7.5.1 2022-03-16 <dave at tiredofit dot ca>

   ### Added
      - Build Zabbix Agent with Go 1.18


## 7.5.0 2022-03-15 <dave at tiredofit dot ca>

   ### Added
      - Introduce Container File Logging Support


## 7.4.2 2022-03-14 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.0.2

   ### Changed
      - Patchup for missing folder for cold start notifications


## 7.4.1 2022-03-11 <dave at tiredofit dot ca>

   ### Added
      - - Add CONTAINER_PROCESS_RUNAWAY_PROTECTOR function to disable a service from restarting (X) amount of times and taking down a system


## 7.4.0 2022-03-10 <dave at tiredofit dot ca>

   ### Changed
      - Change /tmp/.container to /tmp/.container
      - Add logic to tell when a container was started and when it was warm started


## 7.3.9 2022-03-08 <dave at tiredofit dot ca>

   ### Added
      - S6 Overlay 3.1.0.1


## 7.3.8 2022-03-02 <dave at tiredofit dot ca>

   ### Added
      - Add CONTAINER_POST_INIT_SCRIPT and CONTAINER_POST_INIT_COMMAND environment variables to either execute scripts or commands at the very end of the container initialization process


## 7.3.7 2022-03-02 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 1.8.13


## 7.3.6 2022-03-01 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.0.1
      - S6 Overlay 3.0.0.2-2 (3.0.10.0 ??)
      - Golang 1.17.7 for building agents


## 7.3.5 2022-02-15 <dave at tiredofit dot ca>

   ### Added
      - Add truefalse_onezero function


## 7.3.4 2022-02-14 <dave at tiredofit dot ca>

   ### Changed
      - Fix downstream images relying on sudo for Zabbix


## 7.3.3 2022-02-14 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 6.0.0


## 7.3.2 2022-02-11 <dave at tiredofit dot ca>

   ### Changed
      - Fix for cron log directory not being created at startup


## 7.3.1 2022-02-10 <dave at tiredofit dot ca>

   ### Changed
      - Fix for slower machines that timeout after 5 seconds of container configuration


## 7.3.0 2022-02-07 <dave at tiredofit dot ca>

   ### Added
      - S6 Overlay 3.0.0.2
      - FluentBit 1.7.12
      - Zabbix Agent 5.4.10
      - New functions (create_zabbix) for easier development
      - doas package for eventual replacement of sudo
      - Added new helpers on command line (service_up/service_down/changelog/version)
      - Added banner showing image name and version upon startup
      - Custom Bash Prompt when entering in container

   ### Changed
      - Stop relying on /usr/bin/with-contenv - Instead use recommended /command/ folder as outlined in S6 overlay documentation
      - Cleanup of code and allow for CaMeLCasE environment variables (specifically for var_true/var_false and others)
      - Many optimizations and cleanup of scripts for pure modernization sake

   ### Removed
      - Removed fix-attrs.d reliance due to deprecation by S6 Overlay


## 7.2.19 2022-01-20 <dave at tiredofit dot ca>

   ### Changed
      - Rework again db_ready command for MySQL/MariaDB to properly support using 'root'


## 7.2.18 2022-01-06 <dave at tiredofit dot ca>

   ### Changed
      - Change db_ready mariadb function to support Percona/MySQL 5.7+ without needing PROCESS privileges


## 7.2.17 2021-12-27 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 5.4.9


## 7.2.16 2021-12-21 <zeridon@github>

   ### Fixed
      - Actually disable "messaging" via both environment variables

## 7.2.15 2021-12-21 <dave at tiredofit dot ca>

   ### Added
      - Add jq package


## 7.2.14 2021-12-17 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 1.8.11


## 7.2.13 2021-12-15 <dave at tiredofit dot ca>

   ### Changed
      - Fix for Dockerfile build for Zabbix Agent 2
      - Fix for Zabbix Hostname Auto registration


## 7.2.12 2021-12-15 <dave at tiredofit dot ca>

   ### Added
      - Add auto register for Fluentbit if enabled


## 7.2.11 2021-12-15 <dave at tiredofit dot ca>

   ### Changed
      - Do the same cleanup for AUTOREGISTER_DNS as Autoregister


## 7.2.10 2021-12-13 <dave at tiredofit dot ca>

   ### Added
      - Add switchable Zabbix Autoregistration capability
      - Add Zabbix Autoregistration by DNS name instead of IP address capability


## 7.2.9 2021-12-10 <dave at tiredofit dot ca>

   ### Changed
      - Fix for Zabbix Container OS detection


## 7.2.8 2021-12-10 <dave at tiredofit dot ca>

   ### Changed
      - Cleanup permissions for root Zabbix configuration folder


## 7.2.7 2021-12-08 <dave at tiredofit dot ca>

   ### Changed
      - Stop writing multiple HostMetadata keys in Zabbix configuration


## 7.2.6 2021-12-06 <dave at tiredofit dot ca>

   ### Changed
      - Move Zabbix Autoregister to last to ensure proper parsing


## 7.2.5 2021-12-06 <dave at tiredofit dot ca>

   ### Added
      - Add zabbix_get to image


## 7.2.4 2021-12-03 <dave at tiredofit dot ca>

   ### Changed
      - Fix for Dockerfile build


## 7.2.3 2021-12-03 <dave at tiredofit dot ca>

   ### Added
      - Introduce Zabbix Agent Autoregister support by parsing '/etc/zabbix/zabbix_agentd.conf.d/*.conf' looking for '# Autoregister=' string. See README"


## 7.2.2 2021-12-03 <dave at tiredofit dot ca>

   ### Changed
      - Consolidate Zabbix Container Agent configuration into one file and introduce Autoregister header
      - Tighten up permissions on Zabbix log and configuration areas


## 7.2.1 2021-12-03 <dave at tiredofit dot ca>

   ### Changed
      - Move Zabbix Agent Socket and PidFile to private directory


## 7.2.0 2021-12-03 <dave at tiredofit dot ca>

   ### Added
      - Add Zabbix Agent PSK Encryption


## 7.1.26 2021-11-29 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 5.4.8


## 7.1.25 2021-11-25 <dave at tiredofit dot ca>

   ### Changed
      - Fix for Zabbix agent OS checking


## 7.1.22 2021-11-19 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 1.8.10


## 7.1.21 2021-10-28 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 1.8.9
      - Zabbix Agent 5.4.7


## 7.1.20 2021-10-28 <dave at tiredofit dot ca>

   ### Changed
      - Disable time format parsing for Zabbix Agent with fluent-bit


## 7.1.19 2021-10-22 <dave at tiredofit dot ca>

   ### Added
      - Added new features and defaults for Fluent-Bit Tail Input Plugin


## 7.1.18 2021-10-13 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 5.4.5
      - Fluent-Bit 1.8.8
      - GoLang 1.17.2 for building Zabbix Agents


## 7.1.17 2021-09-23 <dave at tiredofit dot ca>

   ### Changed
      - Fix fluent-bit parsing configuration


## 7.1.15 2021-09-19 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 1.8.7


## 7.1.14 2021-09-05 <dave at tiredofit dot ca>

   ### Changed
      - Unmatched sed statement


## 7.1.13 2021-09-05 <dave at tiredofit dot ca>

   ### Changed
      - Fix for multiple parsers appearing in all fluent-bit configurations


## 7.1.12 2021-09-04 <dave at tiredofit dot ca>

   ### Changed
      - Change syntax for create_logrotate


## 7.1.11 2021-09-04 <dave at tiredofit dot ca>

   ### Changed
      - Fix for create_logrotate function unneccessarily requesting su access
      - Zabbix Agent Logrotate/Fluent bit configuration fix


## 7.1.10 2021-09-03 <dave at tiredofit dot ca>

   ### Changed
      - Cleanup fluentbit logrotate name


## 7.1.9 2021-09-03 <dave at tiredofit dot ca>

   ### Changed
      - Properly read wildcards as wildcards for fluentbit logrotate configuration


## 7.1.8 2021-09-01 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 1.8.6

   ### Changed
      - Set SMTP_AUTO_FROM default to FALSE
      - Quiet down some grep commands when auto generating fluent-bit configs


## 7.1.7 2021-08-31 <dave at tiredofit dot ca>

   ### Changed
      - Fix double slashes in logrotate paths if auto generated


## 7.1.6 2021-08-31 <dave at tiredofit dot ca>

   ### Changed
      - Fix for Zabbix Agent 2 fluent-bit parsing


## 7.1.5 2021-08-30 <dave at tiredofit dot ca>

   ### Added
      - Fluent-bit 1.8.5


## 7.1.4 2021-08-30 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 5.4.4


## 7.1.3 2021-08-30 <dave at tiredofit dot ca>

   ### Added
      - Add Zabbix Agent (classic/modern) Log Shipping parsers for fluent-bit


## 7.1.2 2021-08-30 <dave at tiredofit dot ca>

   ### Changed
      - Change references from 'edge' to 3.15 when looking at os-release


## 7.1.1 2021-08-27 <dave at tiredofit dot ca>

   ### Added
      - Add TLS Verification for LOKI Output plugin (Logshipping/Fluent-bit)


## 7.1.0 2021-08-25 <dave at tiredofit dot ca>

   ### Added
      - Fluent-Bit 1.8.3 - Only available for Alpine 3.11 and up
      - Customize the amount of days logrotate retains archived logs
      - New CONTAINER_NAME variable that is used for Monitoring and log shipping
      - Auto configuration of output plugins for Fluent-Bit (NULL, LOKI, Forward/FluentD)
      - Auto configuration of Log shipping for files already setup to use log rotation
      - Multiple Parsers support for Log Shipping
      - Add new log to ship via fluent-bit via environment variable

   ### Changed
      - Change SMTP_TLS, SMTP_STARTTLS, SMTP_TLSCERTCHECK from "on/off" values to `TRUE|FALSE`
      - Fix for MSMTP backend not properly accounting for legacy variables (ENABLE_SMTP)

## 7.0.3 2021-08-04 <dave at tiredofit dot ca>

   ### Added
      - Bring monitoring cont-init.d script up to parity with debian side for ease of codebase


## 7.0.2 2021-07-26 <dave at tiredofit dot ca>

   ### Changed
      - Fix for Zabbix Agent 2 File Logging


## 7.0.1 2021-07-25 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 5.4.3

   ### Changed
      - Change the location where Zabbix Agent logs


## 7.0.0 2021-07-05 <dave at tiredofit dot ca>

Major changes to this base image, reworking technical debt, creating consistency, and building hooks and expansion capabilities for future purposes.

   ### Added
      - Log Shipping support, presently supporting Fluent Bit (x86_64 only)
      - Zabbix Agent 5.4.2
      - Zabbix Agent 2 (modern/go) included, 1 (classic/c) still remains
      - Dyanmically add crontab entries via CRON_* environment variables
      - Prefix container logs with Timestamp
      - Process watchdog support should a process execute multiple times (hooks)
      - Development functions for ease of use

   ### Changed
      - Service Names, and order of execution
      - db_ready and sanity_db functions take additional arguments
      - Environment Variable names have changed, attempts have been made to ensure legacy variable names will still function but will be removed at a later date
      - Rewrote permissions changing routines from scratch

## 6.1.3 2021-07-19 <dave at tiredofit dot ca>

   ### Changed
      - Change from Debian cron to Busybox cron


## 6.1.2 2021-05-18 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 5.4.0


## 6.1.1 2021-05-18 <dave at tiredofit dot ca>

   ### Added
      - Add bullseye builds
      - Zabbix Agent 5.2.6


## 6.1.0 2021-05-01 <dave at tiredofit dot ca>

   ### Added
      - Start compiling Zabbix Agent due to too many issues with repositories and multi arch


## 6.0.4 2021-05-01 <dave at tiredofit dot ca>

   ### Reverted
      - Remove routine that inserts (distrib)-backports. Was causing too many problems for debian/buster with SSL


## 6.0.3 2021-04-20 <dave at tiredofit dot ca>

   ### Changed
      - FIx for 05-smtp initialization not allowing SMTP_AUTO_FROM


## 6.0.2 2021-04-16 <dave at tiredofit dot ca>

   ### Added
      - Add apt-utils package

   ### Changed
      - Don't install zstd for Debian Jessie as it's breaking CI/CD


## 6.0.1 2021-04-16 <dave at tiredofit dot ca>

   ### Added
      - Add zstd to core applications

   ### Changed
      - Core folder permission sanity check


## 6.0.0 2021-03-29 <dave at tiredofit dot ca>

   ### Added
      - Multi Arch Builds (amd64,arm,arm64)

   ### Changed
      - Zabbix Agent now pulls from backports if possible, no longer installs from official Zabbix repository due to lack of multiarch capability
      - Switched back to single branch for building all versions taking advantage of GitHub actions
      - ENABLE_PERMISSIONS by default=TRUE

   ### Removed
      - MailHog SMTP Tester


## 5.1.2 2021-03-14 <dave at tiredofit dot ca>

   ### Added
      - S6 Overlay 2.2.0.3


## 5.1.1 2021-01-04 <dave at tiredofit dot ca>

   ### Changed
      - Fix Group ID altering function


## 5.1.0 2020-11-14 <dave at tiredofit dot ca>

   ### Added
      - S6 Overlay 2.1.0.2
      - Zabbix Agent 5.2


## 5.0.11 2020-09-15 <dave at tiredofit dot ca>

   ### Added
      - Add LOGROTATE_FORCE environment variable


## 5.0.10 2020-08-25 <dave at tiredofit dot ca>

   ### Changed
      - Fix warning with Zabbix Agent


## 5.0.9 2020-08-15 <dave at tiredofit dot ca>

   ### Changed
      - Reapply SMTP_FROM statement


## 5.0.8 2020-08-11 <dave at tiredofit dot ca>

   ### Changed
      - Fix container startup routine check


## 5.0.7 2020-08-01 <dave at tiredofit dot ca>

   ### Added
      - Add dos2unix tool
      - Add SMTP_FROM environment variable to solve missing from address mail errors with msmtp


## 5.0.6 2020-06-15 <dave at tiredofit dot ca>

   ### Changed
      - Fix broken db_ready function


## 5.0.5 2020-06-15 <rusxakep@github>

   ### Changed
      - Bugfixes and code cleanup


## 5.0.4 2020-06-13 <dave at tiredofit dot ca>

   ### Added
      - Ability to disable logrotate


## 5.0.3 2020-06-11 <dave at tiredofit dot ca>

   ### Changed
      - Change logrotate to be called from absolute path in cron


## 5.0.2 2020-06-11 <dave at tiredofit dot ca>

   ### Changed
      - Delete /etc/logrotate.d/ contents


## 5.0.1 2020-06-11 <dave at tiredofit dot ca>

   ### Added
      - Added netcat-openbsd package


## 5.0.0 2020-06-10 <dave at tiredofit dot ca>

   ### Added
      - Split Defaults and Functions into seperate files for cleanliness
      - Additional functions to load defaults/functions per script
      - Additional functions for checking if files/directories/sockets/ports are available before proceeding
      - Cleanup Container functions file to satisy shellcheck

   ### Changed
      - All /etc/s6/services files moved to /etc/services.available - Legacy images that have not been updated will still function but will always execute


## 4.6.1 2020-06-08 <dave at tiredofit dot ca>

   ### Added
      - Zabbix Agent 5.0.x


## 4.6.0 2020-06-06 <rusxakep@github>

   ### Added
      - S6 Overlay 2.0.0.1

   ### Changed
      - Timezone changed to `Etc/GMT`
      - Default mail domain changed to non internet-domain 'local'

## 4.5.0 2020-05-01 <dave at tiredofit dot ca>

   ### Added
      - Update to latest functions


## 4.4.4 2020-03-16 <dave at tiredofit dot ca>

   ### Changed
      - Spelling mistake in 4.4.3


## 4.4.3 2020-03-16 <dave at tiredofit dot ca>

   ### Changed
      - Patchup for Services that do not have initialization scripts


## 4.4.2 2020-03-16 <dave at tiredofit dot ca>

   ### Changed
      - Change msmtp configuraiton file location


## 4.4.1 2020-03-14 <dave at tiredofit dot ca>

   ### Changed
      - Fix when trying to disable Zabbix Monitoring throwing errors


## 4.4.0 2020-03-04 <dave at tiredofit dot ca>

   ### Added
      - Added new functions for service starting and stopping
      - Reworked how services are stopped and started to ensure nothing in services are executed until successful completion of init scripts. This bhas the potential of breaking all downstream images if they are not updated.
      - Rewrote SMTP confgiuration


## 4.3.0 2020-03-02 <dave at tiredofit dot ca>

   ### Added
      - New routine to cleanup /tmp/.container for users who only restart the container, not fully bring down and remove.


## 4.2.0 2020-02-12 <dave at tiredofit dot ca>

   ### Added
      - Reworked Debug Mode to quiet down output on core services and cut down on unnecessary noise
      - Reworked Container Initialization Check to clearly show which file hasn't successfully completed


## 4.1.5 2020-01-11 <dave at tiredofit dot ca>

   ### Changed
      - Additional fix for check_service_initialized function to properly look for finished /etc/s6/services processes

## 4.1.4 2020-01-11 <dave at tiredofit dot ca>

   ### Changed
      - Fix for check_service_initialized function to properly look for finished /etc/s6/services processes

## 4.1.3 2020-01-10 <dave at tiredofit dot ca>

   ### Changed
      - Remove code showing $dirname erronously on process startup

## 4.1.2 2020-01-10 <dave at tiredofit dot ca>

   ### Added
      - Quiet down sudo error
      - Zabbix 4.4.4 Agent


## 4.1.1 2020-01-02 <dave at tiredofit dot ca>

   ### Changed
      - check_service_initialized was throwing false information


## 4.1.0 2020-01-01 <dave at tiredofit dot ca>

   ### Added
      - Start splitting out Defaults into seperate /assets/functions/* files

   ### Changed
      - Cleanup of Permissions Changing routines

## 4.0.1 2020-01-01 <dave at tiredofit dot ca>

   ### Added
      - New text output for Notices

   ### Changed
      - Additional checks to ensure cont-init.d scripts have finished executing

## 4.0.0 2020-01-01 <dave at tiredofit dot ca>

   ### Added
      - Now relying on Container Level functions file
      - Easier methods for displaying console output
      - Colorized Prompts
      - Cleaner Startup Routines
      - Sanity Check to not start any processes until all startup scripts completed

    ### Changed
      - When DEBUG_MODE set stop taking over SMTP functionality. Require DEBUG_SMTP=TRUE instead

## 3.9.3 2019-12-20 <dave at tiredofit dot ca>

   ### Added
      - Alpine 3.11 Base


## 3.9.2 2019-08-23 <edisonlee at selfdesign dot org>

* Cleanup lines subversion.

## 3.9.1 2019-08-23 <edisonlee at selfdesign dot org>

* Cleanup variable.

## 3.9 2019-07-15 <dave at tiredofit dot ca>

* Add Busybox Extras

## 3.8.2 2019-04-06 <dave at tiredofit dot ca>

* S6 Overlay 1.22.1.0

## 3.8.1 2019-01-13 <dave at tiredofit dot ca>

* Cleanup Cache

## 3.8 2018-10-17 <dave at tiredofit dot ca>

* Force executible permissions on S6 Directories

## 3.7 2018-10-14 <dave at tiredofit dot ca>

* Bump Zabbix to 4.0

## 3.6 2018-09-19 <dave at tiredofit dot ca>

* Set +x on all descendents of /etc/s6/services

## 3.5 2018-07-27 <dave at tiredofit dot ca>

* Add TERM=xterm

## 3.4 2018-07-02 <dave at tiredofit dot ca>

* Revert back to using && \ instead of ; \ in Dockerfile
* Add ENABLE_GMAIL_SMTP environment variable thanks to @joeyberkovitz

## 3.3 2018-04-22 <dave at tiredofit dot ca>

* Update 01-permissions to quiet down if no UIDs changed.
* Refinements to MailHog, to always route through msmtp

## 3.2 2018-04-15 <dave at tiredofit dot ca>

* Update Zabbix UID/GID

## 3.1 2018-03-25 <dave at tiredofit dot ca>

* Update MailHog Test Server Startup

## 3.0 2018-03-14 <lesliesit at outlook dot com>

* Add 01-permissions script to support change uid & gid and add user to group:
* USER_<USERNAME>=<aNewNumber>
* GROUP_<GROUPNAME>=<aNewNumber>
* GROUP_ADD_<USERNAME>=<aGroupName>
* UID & GID in /etc/passwd & /etc/group will be modified.
* Old 01- 02- 03- scripts renamed after the new 01-permissions as 02- 03- 04-

## 2.18 2017-02-15 <dave at tiredofit dot ca>

* Update File Permissions for logrotate.d

## 2.17 2017-02-01 <dave at tiredofit dot ca>

* Init Scripts Update
* msmtp Update

## 2.16 2017-01-29 <dave at tiredofit dot ca>

* More Permissions Fixes

## 2.15 2017-01-29 <dave at tiredofit dot ca>

* Add Grep, sudo
* Fix Permissions

## 2.14 2017-01-29 <dave at tiredofit dot ca>

* Add Container Package Check

## 2.13 2017-01-28 <dave at tiredofit dot ca>

* Add zabbix-utils to edge
* Update S6 Overlay to 1.21.2.2

## 2.12 2017-01-28 <dave at tiredofit dot ca>

* Add Zabbix Check for Updated Packages

## 2.11 2017-12-24 <dave at tiredofit dot ca>

* Check for custom cron files in /assets/cron-custom/ on startup

## 2.10 2017-12-01 <dave at tiredofit dot ca>

* Update S6 overlay to 1.21.2.1
* Add Alpine 3.7
* Remove Alpine 3.2

## 2.9 2017-10-23 <dave at tiredofit dot ca>

* Update S6 overlay to 1.21.1.1

## 2.8 2017-09-27 <dave at tiredofit dot ca>

* Updated Alpine Edge to Zabbix-Agent Package as opposed to Compiling
* Quieted down service startup to avoid duplication

## 2.7 2017-09-26 <dave at tiredofitdot ca>

* Added more verbosity to services being enabled/disabled

## 2.6 2017-09-18 <dave at tiredofit dot ca>

* Add Alpine 3.2, 3.3 for legacy purposes
* Fix Scripts for checking enabling services

## 2.5 2017-09-02 <dave at tiredofit dot ca>

* Move to Zabbix 3.4.1 instead of compiling from TRUNK

## 2.4 2017-09-01 <dave at tiredofit dot ca>

* Update S6 Overlay to 1.2.0.0

## 2.3 2017-08-28 <dave at tiredofit dot ca>

* Added `DEBUG_SMTP` environment variable to trap SMTP messages accesible via port 8025

## 2.2 2017-08-27 <dave at tiredofit dot ca>

* Added MSMTP to be able to route mail to external hosts

## 2.1 2017-08-27 <dave at tiredofit dot ca>

* Added DEBUG_MODE environment variable
* Added TIMEZONE environment variable
* Added ENABLE_CRON, ENABLE_ZABBIX switches
* Built mechanisms to not start processes until container initialized
* Zabbix Agent Configuration can be controlled and adjusted via Environment Variables
* General Tidying Up
