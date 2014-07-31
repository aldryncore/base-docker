FROM ubuntu:14.04
MAINTAINER aldryn "support@aldryn.com"

# workaround for a bug in hub.docker.com
RUN ln -s -f /bin/true /usr/bin/chfn

RUN mkdir /build
ADD ./stack/ /build
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /build/prepare
ENV PYTHONUNBUFFERED 1
ENV VERSION 2.0
