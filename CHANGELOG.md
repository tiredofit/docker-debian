## 2.6 2017-09-17 <dave at tiredofit dot ca>

* Fix some scripting errors

## 2.5 2017-09-01 <dave at tiredofit dot ca>

* Update S6 overlay to 1.20.0.0

## 2.4 2017-08-28 <dave at tiredofit dot ca>

* Added Debian Stretch and Wheezy 
* Added Official Zabbix Agent 3.4 instead of compiling from source

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

