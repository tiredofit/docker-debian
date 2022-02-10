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
      - New routine to cleanup /tmp/state for users who only restart the container, not fully bring down and remove.


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
