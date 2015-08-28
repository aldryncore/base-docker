# aldryn/base

[![](https://badge.imagelayers.io/aldryn/base.svg)](https://imagelayers.io/?images=aldryn/base:latest 'Get your own badge on imagelayers.io')

docker base image for aldryn (python) applications.

simplified  version of https://github.com/progrium/cedarish but based on the official python image

some of the additions to the default packages installed in cedarish:

* latest pip
* geoip C libraries


## Changelog

### 3.0 (2015-08-28)

* switch to debian as base (using the official python:2.7.10 docker image)
* a default virtualenv with --no-site-packages (at /virtualenv) that is activated
* pipsi
* no more globally installed python packages (mercurial, bzr are now installed with pipsi)
* pip-tools
* node/npm not installed anymore


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
