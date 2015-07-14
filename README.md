# aldryn/base

[![](https://badge.imagelayers.io/aldryn/base.svg)](https://imagelayers.io/?images=aldryn/base:latest 'Get your own badge on imagelayers.io')

docker base image for aldryn (python) applications.

simplified  version of https://github.com/progrium/cedarish

additions to the default packages installed in cedarish:

* latest pip
* geoip C libraries


## Changelog

### 2.6 (2015-07-14)

* newer ubuntu packages
* less layers
* run-forest-run command

### 2.5 (2015-03-03)

* add forego, a foreman clone in go

### 2.4 (2015-02-19)

* extra packages also installed on python:latest
* python encoding fixes

### 2.3 (2015-03-08)

* libffi-dev for pyOpenSSL/cryptography
* libpcre
* supervisor
* unzip
* wget
* node/npm

### 2.2 (2014-11-18)

* Procfile based startup


### 2.1 (2014-08-27)

* adds libncurses5-dev


### 2.0 (2014-08-06)

* ubuntu 14.04
* libgeoip
* removed java
