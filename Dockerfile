FROM ubuntu:quantal
MAINTAINER aldryn "support@aldryn.com"

RUN mkdir /tmp/build
ADD ./stack/ /tmp/build
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive cd /tmp/build && ./cedar.sh
RUN rm -rf /tmp/build