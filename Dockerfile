FROM ubuntu:14.04
MAINTAINER aldryn "support@aldryn.com"

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# workaround for a bug in hub.docker.com
RUN ln -s -f /bin/true /usr/bin/chfn

RUN mkdir /build
ADD ./stack/ /build
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /build/prepare
ENV PYTHONUNBUFFERED 1
ENV PIP_REQUIRE_VIRTUALENV false
ADD start /usr/local/bin/start
RUN chmod +x /usr/local/bin/start
RUN ln -nsf /usr/local/bin/start /start
ADD Procfile /app/Procfile
CMD start web
