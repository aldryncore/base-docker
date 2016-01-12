FROM python:2.7.11

ENV PYTHONUNBUFFERED=1\
    PIP_REQUIRE_VIRTUALENV=false\
    PATH=/virtualenv/bin:/root/.local/bin:$PATH\
    PROCFILE_PATH=/app/Procfile

COPY stack /stack
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /stack/prepare

RUN virtualenv --prompt mypython --no-site-packages /virtualenv

ADD Procfile /app/Procfile
CMD start web
