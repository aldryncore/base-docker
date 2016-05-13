#!/bin/bash
#
# Prepares the "stack" to run apps and the environment to run buildpacks
#
set -x
set -e

PYTHON_MAJOR_VERSION=$(python -c 'import platform; print(platform.python_version_tuple()[0])')

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")

#
# SYSTEM PACKAGES
#
apt-get update
xargs apt-get install -y --force-yes --no-install-recommends < ${BASEDIR}/packages.txt

# pip 8.1.2 has made internal changes that break pip-tools < 1.7
# since pip-tools > 1.7 is not released yet we're freezing pip to 8.1.1
# https://github.com/nvie/pip-tools/issues/358
pip install pip==8.1.1

if [ $PYTHON_MAJOR_VERSION -eq 3 ]
then
    # the official python 3 docker image does not have virtualenv installed
    pip3 install virtualenv
fi

#
# pipsi for simple installation of python commands
#
# - Unfortunatly the current release on pypi (0.9) does not work with python3.
# - get-pipsi.py does some setup stuff, we want to continue to use it.
# - The unaltered get-pipsi.py tries to install the broken version from pypi.
# So: we install pipsi with an altered get-pipsi.py to use the version from
#     gitub. It'll use python 2 or 3 depending on the base image. The github
#     version won't explode when using it to install commands installed in
#     python3 (e.g pip-tools).

# NOTE: PATH=/root/.local/bin:$PATH must be set in the Dockerfile
python ${BASEDIR}/get-pipsi.py

#
# MISC
#

# pip-tools: requirements evaluator
#    to work correctly on python3 it must be installed with python3 (that is the
#    default if pipsi was installed with python3). If pip-tools were installed
#    in python2 while using it in python3, some wheel packages would not be
#    recognized on pypi and our wheels proxy.
pipsi install https://github.com/aldryncore/pip-tools/archive/1.5.0.1.tar.gz#egg=pip-tools==1.5.0.1

# start: a simple tool to start one process out of a Procfile
pipsi install start==0.2

# tini: minimal PID 1 init. reaps zombie processes and forwards signals.
# set
# ENTRYPOINT ["/tini", "--"]
# in the Dockerfile to make it the default method for starting processes.
# https://github.com/krallin/tini
curl -L --show-error --retry 5 -o /tini https://github.com/krallin/tini/releases/download/v0.9.0/tini
chmod +x /tini

# install forego (a foreman clone in go)
# TODO: remove once not needed anymore. Currently aldryn-django uses forego to
#       launch pagespeed sites with separate nginx and django processes.
curl -L --show-error --retry 5 -o /tmp/forego.deb https://bin.equinox.io/c/ekMN3bCZFUn/forego-stable-linux-amd64.deb
dpkg -i /tmp/forego.deb

# cleanup
rm -rf /var/lib/apt/lists/*
rm -rf /tmp/*
apt-get clean

# workaround for a bug in hub.docker.com
ln -s -f /bin/true /usr/bin/chfn

# install custom commands
cp ${BASEDIR}/run-forest-run /usr/local/bin/run-forest-run

# default virtualenv
# NOTE: PATH=/virtualenv/bin:$PATH must be set in the Dockerfile
virtualenv --no-site-packages /virtualenv
