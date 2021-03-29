# hub.docker.com/r/tiredofit/debian

[![Docker Pulls](https://img.shields.io/docker/pulls/tiredofit/debian.svg)](https://hub.docker.com/r/tiredofit/debian)
[![Docker Stars](https://img.shields.io/docker/stars/tiredofit/debian.svg)](https://hub.docker.com/r/tiredofit/debian)
[![Docker Layers](https://images.microbadger.com/badges/image/tiredofit/debian.svg)](https://microbadger.com/images/tiredofit/debian)

Dockerfile to build an [debian](https://www.debian.org/) container image to use used as a base for building other images.

* Currently tracking Jessie (8), Stretch (9), Buster (10).
* Multi Arch Compatible for amd64, arm arm64
* [s6 overlay](https://github.com/just-containers/s6-overlay) enabled for PID 1 init capabilities.
* [zabbix-agent](https://zabbix.org) for individual container monitoring.
* Cron installed along with other tools (curl, less, logrotate, nano, vim) for easier management.
* Ability to update User ID and Group ID permissions for development purposes dynamically.

## Authors

- [Dave Conroy](https://github.com/tiredofit/)

## Table of Contents

- [Introduction](#introduction)
- [Authors](#authors)
- [Table of Contents](#table-of-contents)
- [Installation](#installation)
  - [Quick Start](#quick-start)
- [Configuration](#configuration)
  - [Data-Volumes](#data-volumes)
  - [Environment Variables](#environment-variables)
    - [Container Config](#container-config)
    - [SMTP Redirection](#smtp-redirection)
    - [Zabbix](#zabbix)
    - [Changing Permissions](#changing-permissions)
  - [Networking](#networking)
- [Maintenance](#maintenance)
  - [Shell Access](#shell-access)


## Installation

Automated builds of the image are available on [Docker Hub](https://hub.docker.com/r/tiredofit/debian)

```bash
docker pull tiredofit/debian:(imagetag)
```

The following image tags are available:

* `latest` - Debian Buster - 10 (amd64, arm6, arm7. arm64)
* `buster` - Debian Buster - 10 (amd64, arm6, arm7. arm64)
* `stretch` - Debian Stretch - 9 (amd64, arm6, arm7. arm64)
* `jessie:` - Debian Jessie - 8 (amd64, arm7)


### Quick Start

Utilize this image as a base for further builds. By default, it does not start the S6 Overlay system, but
Bash. Please visit the [s6 overlay repository](https://github.com/just-containers/s6-overlay) for
instructions on how to enable the S6 init system when using this base or look at some of my other images
which use this as a base.

## Configuration

### Data-Volumes
The following directories are used for configure and can be mapped for persistent storage.

| Directory                           | Description                          |
| ----------------------------------- | ------------------------------------ |
| `/etc/zabbix/zabbix_agentd.conf.d/` | Zabbix Agent configuration directory |
| `/assets/cron-custom`               | Drop custom crontabs here            |


### Environment Variables

Below is the complete list of available options that can be used to customize your installation.

#### Container Config

| Parameter             | Description                                                            | Default   |
| --------------------- | ---------------------------------------------------------------------- | --------- |
| `COLORIZE_OUTPUT`     | Enable/Disable colorized console output                                | `TRUE`    |
| `CONTAINER_LOG_LEVEL` | Control level of output of container `INFO`, `WARN`, `NOTICE`, `DEBUG` | `NOTICE`  |
| `DEBUG_MODE`          | Enable debug mode                                                      | `FALSE`   |
| `DEBUG_SMTP`          | Setup mail catch all on port 1025 (SMTP) and 8025 (HTTP)               | `FALSE`   |
| `ENABLE_CRON`         | Enable Cron                                                            | `TRUE`    |
| `ENABLE_LOGROTATE`    | Enable Logrotate                                                       | `TRUE`    |
| `ENABLE_SMTP`         | Enable SMTP services                                                   | `TRUE`    |
| `ENABLE_ZABBIX`       | Enable Zabbix Agent                                                    | `TRUE`    |
| `SKIP_SANITY_CHECK`   | Disable container startup routine check                                | `FALSE`   |
| `TIMEZONE`            | Set Timezone                                                           | `Etc/GMT` |


#### SMTP Redirection

If you wish to have this send mail, set `ENABLE_SMTP=TRUE` and configure the following environment variables.
See the [MSMTP Configuration Options](http://msmtp.sourceforge.net/doc/msmtp.html) for further information on options to configure MSMTP.

| Parameter             | Description                                                            | Default            |
| --------------------- | ---------------------------------------------------------------------- | ------------------ |
| `SMTP_AUTO_FROM`      | Auto send From to resolve any SMTP sending issues (Specifically GMAIL) | `TRUE`             |
| `SMTP_FROM`           | From name to send email as                                             | `user@example.com` |
| `SMTP_HOST`           | Hostname of SMTP Server                                                | `postfix-relay`    |
| `SMTP_PORT`           | Port of SMTP Server                                                    | `25`               |
| `SMTP_DOMAIN`         | HELO domain                                                            | `docker`           |
| `SMTP_MAILDOMAIN`     | Mail domain from                                                       | `local`            |
| `SMTP_AUTHENTICATION` | SMTP Authentication                                                    | `none`             |
| `SMTP_USER`           | SMTP Username (optional)                                               |                    |
| `SMTP_PASS`           | SMTP Password (optional)                                               |                    |
| `SMTP_TLS`            | Use TLS                                                                | `off`              |
| `SMTP_STARTTLS`       | Start TLS from within session                                          | `off`              |
| `SMTP_TLSCERTCHECK`   | Check remote certificate                                               | `off`              |

See The [Official Zabbix Agent Documentation](https://www.zabbix.com/documentation/5.2/manual/appendix/config/zabbix_agentd)
for information about the following Zabbix values.

#### Zabbix
| Parameter                      | Description                             | Default                             |
| ------------------------------ | --------------------------------------- | ----------------------------------- |
| `ZABBIX_LOGFILE`               | Logfile location                        | `/var/log/zabbix/zabbix_agentd.log` |
| `ZABBIX_LOGFILESIZE`           | Logfile size                            | `1`                                 |
| `ZABBIX_DEBUGLEVEL`            | Debug level                             | `1`                                 |
| `ZABBIX_REMOTECOMMANDS_ALLOW`  | Enable remote commands                  | `*`                                 |
| `ZABBIX_REMOTECOMMANDS_DENY`   | Deny remote commands                    | `*`                                 |
| `ZABBIX_REMOTECOMMANDS_LOG`    | Enable remote commands Log (`0`/`1`)    | `1`                                 |
| `ZABBIX_SERVER`                | Allow connections from Zabbix server IP | `0.0.0.0/0`                         |
| `ZABBIX_LISTEN_PORT`           | Zabbix Agent listening port             | `10050`                             |
| `ZABBIX_LISTEN_IP`             | Zabbix Agent listening IP               | `0.0.0.0`                           |
| `ZABBIX_START_AGENTS`          | How many Zabbix Agents to start         | `3`                                 |
| `ZABBIX_SERVER_ACTIVE`         | Server for active checks                | `zabbix-proxy`                      |
| `ZABBIX_HOSTNAME`              | Container hostname to report to server  | `docker`                            |
| `ZABBIX_REFRESH_ACTIVE_CHECKS` | Seconds to refresh Active Checks        | `120`                               |
| `ZABBIX_BUFFER_SEND`           | Buffer Send                             | `5`                                 |
| `ZABBIX_BUFFER_SIZE`           | Buffer Size                             | `100`                               |
| `ZABBIX_MAXLINES_SECOND`       | Max Lines Per Second                    | `20`                                |
| `ZABBIX_ALLOW_ROOT`            | Allow running as root                   | `1`                                 |
| `ZABBIX_USER`                  | Zabbix user to start as                 | `zabbix`                            |


#### Changing Permissions
If you enable `ENABLE_PERIMISSIONS_PERMISSIONS=TRUE` all the users and groups have been modified in accordance with environment
variables will be displayed in output.
e.g. If you add `USER_NGINX=1000` it will reset the containers `nginx` user id from `82` to `1000` -
Hint, also change the Group ID to your local development users UID & GID and avoid Docker permission issues when developing.

| Parameter              | Description                                                                 | Default |
| ---------------------- | --------------------------------------------------------------------------- | ------- |
| `ENABLE_PERMISSIONS`   | Allow changing UID or GID of environment variables                          | `TRUE`  |
| `DEBUG_PERMISSIONS`    | For debugging your output when changing permissions                         | `FALSE` |
| `USER_<USERNAME>`      | The user's UID in /etc/passwd will be modified with new UID                 |         |
| `GROUP_<GROUPNAME>`    | The group's GID in /etc/group and /etc/passwd will be modified with new GID |         |
| `GROUP_ADD_<USERNAME>` | The username will be added in /etc/group after the group name defined       |         |


### Networking

The following ports are exposed.

| Port    | Description  |
| ------- | ------------ |
| `10050` | Zabbix Agent |



# Debug Mode

When using this as a base image, create statements in your startup scripts to check for existence of `DEBUG_MODE=TRUE`
and set various parameters in your applications to output more detail, enable debugging modes, and so on.
In this base image it does the following:
* Sets zabbix-agent to output logs in verbosity

## Maintenance
### Shell Access

For debugging and maintenance purposes you may want access the containers shell.

```bash
docker exec -it (whatever your container name is e.g. debian) bash
```

## References
=======
Dockerfiles to build a [Debian Linux](https://www.debian.org)
container image.

* Please see individual branches for distribution variants.
>>>>>>> master

