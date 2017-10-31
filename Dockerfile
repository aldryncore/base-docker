FROM python:2.7.14-stretch

ENV PYTHONUNBUFFERED=1 \
    PIP_REQUIRE_VIRTUALENV=false \
    WHEELS_PLATFORM=aldryn-baseproject \
    PIPSI_HOME=/root/.pipsi/venvs \
    PIPSI_BIN_DIR=/root/.pipsi/bin \
    PATH=/virtualenv/bin:/root/.pipsi/bin:$PATH \
    PROCFILE_PATH=/app/Procfile \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

COPY stack /stack/base
RUN DEBIAN_FRONTEND=noninteractive /stack/base/install.sh

ENTRYPOINT ["/tini", "-g", "--"]

ADD Procfile /app/Procfile
CMD ["start", "web"]
