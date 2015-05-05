# aldryn/base

[![](https://badge.imagelayers.io/aldryn/base.svg)](https://imagelayers.io/?images=aldryn/base:latest 'Get your own badge on imagelayers.io')

docker base image for aldryn (python) applications.

simplified  version of https://github.com/progrium/cedarish

additions to the default packages installed in cedarish:

* latest pip
* geoip C libraries


## Changelog

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
