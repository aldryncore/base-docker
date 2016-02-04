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

if [ $PYTHON_MAJOR_VERSION -eq 3 ]
then
    # the official python 3 docker image does not have virtualenv installed
    pip3 install virtualenv
    # we also need virtualenv and pip for python2, so pipsi works
    #apt-get install -y --force-yes --no-install-recommends python-pip
    #/usr/bin/pip2 install virtualenv
fi

#
# pipsi for simple installation of python commands
#
# Unfortunatly pipsi does not work with python3 (probably because of a bug in
# click).
#
# NOTE: PATH=/root/.local/bin:$PATH must be set in the Dockerfile
#curl --silent --retry 5 https://raw.githubusercontent.com/mitsuhiko/pipsi/master/get-pipsi.py | python2
python ${BASEDIR}/get-pipsi.py

#
# MISC
#
pipsi install https://github.com/aldryncore/pip-tools/archive/1.5.0.1.tar.gz#egg=pip-tools==1.5.0.1 --python=python2
pipsi install start==0.2


# install forego (a foreman clone in go)
# TODO: remove once not needed anymore. Currently aldryn-django uses forego to
#       launch pagespeed sites with separate nginx and django processes.
curl --silent --show-error --retry 5 -o /usr/local/bin/forego https://godist.herokuapp.com/projects/ddollar/forego/releases/current/linux-amd64/forego
chmod u+x /usr/local/bin/forego

# cleanup
rm -rf /var/lib/apt/lists/*
apt-get clean

# workaround for a bug in hub.docker.com
ln -s -f /bin/true /usr/bin/chfn

# install custom commands
cp ${BASEDIR}/run-forest-run /usr/local/bin/run-forest-run

# default virtualenv
# NOTE: PATH=/virtualenv/bin:$PATH must be set in the Dockerfile
virtualenv --no-site-packages /virtualenv
