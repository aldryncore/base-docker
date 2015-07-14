FROM ubuntu:14.04.2
MAINTAINER aldryn "support@aldryn.com"

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8\
    PYTHONUNBUFFERED=1\
    PIP_REQUIRE_VIRTUALENV=false

ADD stack /stack
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /stack/prepare

ADD Procfile /app/Procfile
CMD start web
